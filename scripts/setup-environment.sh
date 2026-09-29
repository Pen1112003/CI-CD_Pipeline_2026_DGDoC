#!/usr/bin/env bash
# ==============================================================================
# Script tự động khởi tạo môi trường CI/CD Pipeline
# Sử dụng: ./scripts/setup-environment.sh
# ==============================================================================

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}=== [1/4] Khởi tạo tệp cấu hình môi trường (.env) ===${NC}"
if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo -e "${GREEN}✔ Đã tạo file .env từ .env.example${NC}"
    else
        echo -e "${YELLOW}⚠ Không tìm thấy .env.example, giữ nguyên trạng thái.${NC}"
    fi
else
    echo -e "${GREEN}✔ File .env đã tồn tại.${NC}"
fi

echo -e "${BLUE}=== [2/4] Tạo cấu trúc thư mục monitoring (logs & reports) ===${NC}"
mkdir -p monitoring/logs/jenkins
mkdir -p monitoring/logs/sonarqube
mkdir -p monitoring/logs/dozzle
mkdir -p monitoring/reports/frontend/eslint
mkdir -p monitoring/reports/frontend/stylelint
mkdir -p monitoring/reports/backend/flake8
mkdir -p monitoring/reports/backend/checkstyle
mkdir -p monitoring/reports/backend/csharp
mkdir -p monitoring/reports/backend/nodejs
mkdir -p monitoring/reports/hadolint

# Cấp quyền ghi cho các container nếu chạy trên Linux
chmod -R 777 monitoring/logs monitoring/reports 2>/dev/null || true
echo -e "${GREEN}✔ Đã thiết lập xong các thư mục monitoring logs và reports.${NC}"

echo -e "${BLUE}=== [3/4] Khởi tạo Docker Network chung cho Pipeline ===${NC}"
NETWORK_NAME=$(grep '^PIPELINE_NETWORK_NAME=' .env | cut -d '=' -f2 2>/dev/null || echo "cicd_pipeline_network")
if docker info >/dev/null 2>&1; then
    if docker network inspect "${NETWORK_NAME}" >/dev/null 2>&1; then
        echo -e "${GREEN}✔ Docker Network '${NETWORK_NAME}' đã tồn tại.${NC}"
    else
        docker network create "${NETWORK_NAME}" || true
        echo -e "${GREEN}✔ Đã tạo mới Docker Network '${NETWORK_NAME}'.${NC}"
    fi
else
    echo -e "${YELLOW}ℹ Docker daemon chưa chạy, sẽ tự động tạo network khi khởi động compose.${NC}"
fi

echo -e "${BLUE}=== [4/4] Kiểm tra các công cụ hệ thống ===${NC}"
for cmd in docker docker-compose; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}✔ Tìm thấy $cmd: $(command -v "$cmd")${NC}"
    else
        echo -e "${YELLOW}⚠ Cảnh báo: Chưa tìm thấy $cmd trên máy.${NC}"
    fi
done

echo ""
echo -e "${GREEN}🎉 Hoàn tất chuẩn bị môi trường! Bạn có thể khởi chạy bằng:${NC}"
echo "    docker compose up -d"
echo "  hoặc gõ lệnh:"
echo "    make up"
