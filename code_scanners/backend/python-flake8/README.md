# Python Flake8 Scanner (Backend)

Flake8 là công cụ phân tích tĩnh mã nguồn (linter) hàng đầu cho Python, tổng hợp sức mạnh từ:
- **PyFlakes**: Tìm kiếm lỗi cú pháp, biến chưa dùng, import thừa.
- **pycodestyle**: Kiểm tra tuân thủ quy chuẩn phong cách PEP 8.
- **McCabe**: Đo lường và cảnh báo độ phức tạp chu trình (Cyclomatic Complexity).

## Cách chạy và xuất báo cáo vào Monitoring

### 1. Cài đặt
```bash
pip install flake8 flake8-html flake8-json
```

### 2. Quét code và xuất ra monitoring/reports
```bash
# Xuất dạng text log:
flake8 /path/to/python/backend --output-file=../../../monitoring/reports/backend/flake8/flake8-report.txt

# Hoặc xuất dạng HTML report tương tác:
flake8 /path/to/python/backend --format=html --htmldir=../../../monitoring/reports/backend/flake8/html_report
```
