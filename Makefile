# ==============================================================================
# MAKEFILE - PHÍM TẮT ĐIỀU KHIỂN HỆ THỐNG CI/CD PIPELINE
# ==============================================================================

.PHONY: help setup up down restart logs ps scan scan-fe scan-be scan-docker clean

help:
	@echo "======================================================================"
	@echo "                  HƯỚNG DẪN SỬ DỤNG CI/CD PIPELINE                    "
	@echo "======================================================================"
	@echo "  make setup        : Cấu hình môi trường (.env, thư mục, docker network)"
	@echo "  make up           : Khởi động Jenkins, SonarQube, Postgres, Dozzle"
	@echo "  make down         : Dừng toàn bộ các dịch vụ pipeline"
	@echo "  make restart      : Khởi động lại các dịch vụ"
	@echo "  make ps           : Xem trạng thái các container"
	@echo "  make logs         : Theo dõi logs của các dịch vụ"
	@echo "  make scan         : Chạy toàn bộ rà soát mã nguồn (FE, BE, Hadolint)"
	@echo "  make scan-fe      : Chạy rà soát Frontend (ESLint React, Stylelint)"
	@echo "  make scan-be      : Chạy rà soát Backend (Flake8, Checkstyle, C#)"
	@echo "  make scan-docker  : Chạy rà soát Dockerfile (Hadolint)"
	@echo "  make clean        : Dọn dẹp logs và reports phát sinh"
	@echo "======================================================================"

setup:
	@./scripts/setup-environment.sh

up: setup
	@echo "🚀 Đang khởi động các dịch vụ Pipeline..."
	docker compose up -d
	@echo "✔ Dịch vụ sẵn sàng:"
	@echo "  - Jenkins   : http://localhost:8080"
	@echo "  - SonarQube : http://localhost:9000"
	@echo "  - Dozzle    : http://localhost:8888"

down:
	@echo "🛑 Đang tắt các dịch vụ..."
	docker compose down

restart: down up

ps:
	docker compose ps

logs:
	docker compose logs -f

scan:
	@./scripts/run-scanners.sh all

scan-fe:
	@./scripts/run-scanners.sh fe

scan-be:
	@./scripts/run-scanners.sh be

scan-docker:
	@./scripts/run-scanners.sh hadolint

clean:
	@echo "🧹 Đang dọn dẹp các tệp log và report tạm..."
	@find monitoring/logs -type f -not -name '.gitkeep' -delete 2>/dev/null || true
	@find monitoring/reports -type f -not -name '.gitkeep' -delete 2>/dev/null || true
	@echo "✔ Dọn dẹp hoàn tất!"
