# Central Monitoring: Logs & Code Scan Reports

Thư mục quản lý tập trung toàn bộ nhật ký (Logs) của các dịch vụ CI/CD và các báo cáo rà soát mã nguồn (Reports) cho cả Frontend và Backend.

## Cấu trúc thư mục

```
monitoring/
├── logs/                      # Nhật ký hoạt động của các dịch vụ Pipeline
│   ├── jenkins/               # Log từ container Jenkins LTS
│   ├── sonarqube/             # Log từ SonarQube & Elasticsearch
│   └── dozzle/                # Log hoạt động của log viewer Dozzle
└── reports/                   # Báo cáo phân tích chất lượng code (Linters & SAST)
    ├── frontend/
    │   ├── eslint/            # Báo cáo scan React / JS / TS (JSON, HTML)
    │   └── stylelint/         # Báo cáo CSS/SCSS
    ├── backend/
    │   ├── flake8/            # Báo cáo Python Flake8
    │   ├── checkstyle/        # Báo cáo Java Checkstyle (XML, TXT)
    │   ├── csharp/            # Báo cáo C# dotnet format / analyzers
    │   └── nodejs/            # Báo cáo Node.js backend ESLint
    └── hadolint/              # Báo cáo rà soát Dockerfile
```

## Cách xem nhanh qua Dozzle
Khi khởi chạy Dozzle trên cổng `8888`, bạn có thể theo dõi realtime logs của tất cả container:
👉 [http://localhost:8888](http://localhost:8888)
