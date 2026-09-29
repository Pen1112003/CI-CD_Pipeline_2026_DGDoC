# React / Frontend Code Scanner (ESLint)

**ESLint** là công cụ tương đương và vượt trội so với **Flake8** trong thế giới JavaScript/TypeScript và React:
- Kiểm tra quy chuẩn code style và syntax error (tương đương Flake8/pycodestyle).
- Phát hiện các vi phạm quy tắc React Hooks (`react-hooks/rules-of-hooks`, `exhaustive-deps`).
- Kiểm tra tiêu chuẩn tiếp cận giao diện người dùng (`jsx-a11y`).

## Cách chạy và xuất báo cáo vào Monitoring

```bash
cd code_scanners/frontend/react-eslint
npm install

# Xuất báo cáo dạng JSON vào monitoring/reports
npm run lint:report:json

# Xuất báo cáo HTML trực quan
npm run lint:report:html
```
Báo cáo sẽ được lưu tại: `monitoring/reports/frontend/eslint/`.
