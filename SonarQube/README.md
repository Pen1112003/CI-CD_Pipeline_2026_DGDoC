# SonarQube Service

Cấu hình SonarQube LTS Community Edition kết hợp PostgreSQL từ [SonarSource Official Documentation](https://docs.sonarsource.com/sonarqube/latest/setup-and-upgrade/install-the-server/installing-sonarqube-from-docker/).

## Lưu ý hệ điều hành (Linux/Docker Host)
SonarQube tích hợp Elasticsearch bên trong, do đó trên Linux host cần đảm bảo:
```bash
sudo sysctl -w vm.max_map_count=524288
sudo sysctl -w fs.file-max=131072
```

## Khởi động độc lập
```bash
# Tạo network chung nếu chưa có
docker network create cicd_pipeline_network || true

# Khởi động dịch vụ
docker compose up -d
```
Truy cập giao diện: [http://localhost:9000](http://localhost:9000)
- Tài khoản mặc định: `admin` / `admin` (sẽ được yêu cầu đổi mật khẩu ở lần đăng nhập đầu tiên).
- Thư mục log tự động đồng bộ ra `../monitoring/logs/sonarqube`.
