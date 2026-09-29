# Dozzle - Realtime Docker Log Viewer

Cấu hình Dozzle chính thức từ [Dozzle Official Site](https://dozzle.dev/).

## Tính năng
- Giám sát log thời gian thực của tất cả Docker containers (Jenkins, SonarQube, PostgreSQL, Hadolint, v.v.).
- Rất nhẹ, giao diện Web hiện đại, không cần cấu hình database phức tạp.
- Đọc an toàn read-only qua `/var/run/docker.sock:ro`.

## Khởi động độc lập
```bash
docker network create cicd_pipeline_network || true
docker compose up -d
```
Truy cập giao diện: [http://localhost:8888](http://localhost:8888)
