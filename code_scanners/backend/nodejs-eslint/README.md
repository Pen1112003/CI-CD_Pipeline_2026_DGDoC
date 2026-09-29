# Node.js Backend Code Scanner (ESLint + Security)

Cấu hình ESLint dành riêng cho Backend Node.js (tương đương Flake8 + Flake8-bandit trong Python):
- Kiểm tra syntax, biến không sử dụng, memory leaks.
- Tích hợp `eslint-plugin-security` phát hiện các lỗ hổng bảo mật đặc thù của Node.js (injection, file system path traversal).

## Cách chạy và xuất báo cáo vào Monitoring

```bash
cd code_scanners/backend/nodejs-eslint
npm install

# Xuất báo cáo dạng JSON
npm run lint:report:json

# Xuất báo cáo dạng HTML
npm run lint:report:html
```
Báo cáo sẽ được lưu tại: `monitoring/reports/backend/nodejs/`.
