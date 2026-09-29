# Jenkins CI/CD Service

Cấu hình Jenkins LTS chính thức từ [Jenkins Official Documentation](https://www.jenkins.io/doc/book/installing/docker/).

## Tính năng
- Sử dụng Image chính thức: `jenkins/jenkins:lts-jdk17`.
- Hỗ trợ mount Docker socket (`/var/run/docker.sock`) để build Docker image trực tiếp từ Jenkins job (Docker-outside-of-Docker).
- Tích hợp ghi log ra thư mục trung tâm `monitoring/logs/jenkins`.
- Volume persistent cho dữ liệu Jenkins: `jenkins_home_data`.

## Khởi động độc lập
```bash
# Tạo network chung nếu chưa có
docker network create cicd_pipeline_network || true

# Khởi động Jenkins
docker compose up -d

# Lấy mật khẩu ban đầu
docker exec jenkins-lts cat /var/jenkins_home/secrets/initialAdminPassword
```
Truy cập giao diện: [http://localhost:8080](http://localhost:8080)
