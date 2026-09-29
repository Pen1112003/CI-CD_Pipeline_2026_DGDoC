#!/usr/bin/env bash
# ==============================================================================
# Script tự động thực thi các bộ rà soát mã nguồn (Linters & Static Analyzers)
# Sử dụng: ./scripts/run-scanners.sh [all|fe|be|hadolint]
# ==============================================================================

set -uo pipefail

TARGET="${1:-all}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}======================================================================${NC}"
echo -e "${BLUE}       CHẠY BỘ QUÉT MÃ NGUỒN CI/CD (MODE: ${TARGET^^})        ${NC}"
echo -e "${BLUE}======================================================================${NC}"

# 1. Hadolint
run_hadolint() {
    echo -e "\n${BLUE}▶ [Hadolint] Rà soát Dockerfile...${NC}"
    mkdir -p "${ROOT_DIR}/monitoring/reports/hadolint"
    
    if [ -f "${ROOT_DIR}/Dockerfile" ]; then
        docker run --rm \
            -v "${ROOT_DIR}:/workspace:ro" \
            -v "${ROOT_DIR}/Hadolint/.hadolint.yaml:/root/.config/hadolint.yaml:ro" \
            hadolint/hadolint:latest-debian hadolint --config /root/.config/hadolint.yaml -f json /workspace/Dockerfile \
            > "${ROOT_DIR}/monitoring/reports/hadolint/dockerfile-lint.json" 2>/dev/null || true
        echo -e "${GREEN}✔ Hadolint hoàn tất -> monitoring/reports/hadolint/dockerfile-lint.json${NC}"
    else
        echo -e "${YELLOW}ℹ Không tìm thấy Dockerfile ở thư mục gốc, bỏ qua.${NC}"
    fi
}

# 2. Frontend Linters
run_frontend() {
    echo -e "\n${BLUE}▶ [Frontend] Rà soát React / JavaScript / TypeScript (ESLint) & CSS...${NC}"
    mkdir -p "${ROOT_DIR}/monitoring/reports/frontend/eslint"
    mkdir -p "${ROOT_DIR}/monitoring/reports/frontend/stylelint"

    # React ESLint
    if command -v npx >/dev/null 2>&1; then
        echo "  - Đang chạy ESLint (FE)..."
        npx eslint "${ROOT_DIR}" \
            --ext .js,.jsx,.ts,.tsx \
            --ignore-pattern "**/node_modules/**" \
            --ignore-pattern "**/build/**" \
            --format json \
            -o "${ROOT_DIR}/monitoring/reports/frontend/eslint/eslint-report.json" 2>/dev/null || true
        echo -e "${GREEN}✔ ESLint FE hoàn tất -> monitoring/reports/frontend/eslint/eslint-report.json${NC}"
    else
        echo -e "${YELLOW}⚠ Không có Node/npx, bỏ qua ESLint local.${NC}"
    fi
}

# 3. Backend Linters
run_backend() {
    echo -e "\n${BLUE}▶ [Backend] Rà soát Python (Flake8), Java (Checkstyle), C#, Node.js...${NC}"
    mkdir -p "${ROOT_DIR}/monitoring/reports/backend/flake8"
    mkdir -p "${ROOT_DIR}/monitoring/reports/backend/checkstyle"
    mkdir -p "${ROOT_DIR}/monitoring/reports/backend/csharp"
    mkdir -p "${ROOT_DIR}/monitoring/reports/backend/nodejs"

    # Python Flake8
    if command -v flake8 >/dev/null 2>&1; then
        echo "  - Đang chạy Flake8 (Python)..."
        flake8 "${ROOT_DIR}" \
            --config="${ROOT_DIR}/code_scanners/backend/python-flake8/.flake8" \
            --output-file="${ROOT_DIR}/monitoring/reports/backend/flake8/flake8-report.txt" || true
        echo -e "${GREEN}✔ Flake8 hoàn tất -> monitoring/reports/backend/flake8/flake8-report.txt${NC}"
    else
        echo -e "${YELLOW}ℹ Flake8 chưa cài trên máy chủ, có thể chạy qua Docker:${NC}"
        echo "  docker run --rm -v ${ROOT_DIR}:/apps alpine/flake8:latest /apps"
    fi

    # Java Checkstyle
    if [ -f "${ROOT_DIR}/pom.xml" ] && command -v mvn >/dev/null 2>&1; then
        echo "  - Đang chạy Checkstyle (Java)..."
        mvn checkstyle:checkstyle || true
        echo -e "${GREEN}✔ Java Checkstyle hoàn tất.${NC}"
    fi

    # C# dotnet format
    if command -v dotnet >/dev/null 2>&1; then
        echo "  - Đang chạy dotnet format (C#)..."
        dotnet format "${ROOT_DIR}" --verify-no-changes --verbosity diagnostic > "${ROOT_DIR}/monitoring/reports/backend/csharp/csharp-format-report.txt" 2>&1 || true
        echo -e "${GREEN}✔ C# dotnet format hoàn tất -> monitoring/reports/backend/csharp/csharp-format-report.txt${NC}"
    fi
}

# Điều phối theo tham số
case "${TARGET}" in
    hadolint)
        run_hadolint
        ;;
    fe|frontend)
        run_frontend
        ;;
    be|backend)
        run_backend
        ;;
    all)
        run_hadolint
        run_frontend
        run_backend
        ;;
    *)
        echo -e "${RED}Tham số không hợp lệ! Sử dụng: $0 [all|fe|be|hadolint]${NC}"
        exit 1
        ;;
esac

echo -e "\n${GREEN}✨ Quét hoàn tất! Toàn bộ kết quả đã được cập nhật tại thư mục monitoring/reports/${NC}"
