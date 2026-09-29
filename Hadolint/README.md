# Hadolint - Dockerfile Linter

Cấu hình Hadolint chính thức từ [Hadolint Official Repository](https://github.com/hadolint/hadolint).

## Công dụng
Hadolint phân tích cú pháp Dockerfile theo chuẩn AST và kiểm tra các best practice của Docker theo các quy tắc DLxxxx.

## Cách sử dụng

### 1. Quét nhanh Dockerfile qua Docker Compose
```bash
docker compose run --rm hadolint hadolint /workspace/Jenkins/Dockerfile
```

### 2. Xuất báo cáo JSON ra thư mục monitoring
```bash
docker compose run --rm hadolint hadolint -f json /workspace/Dockerfile > ../monitoring/reports/hadolint/dockerfile-lint-report.json
```
