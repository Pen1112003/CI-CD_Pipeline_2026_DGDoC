# Stylelint - Frontend CSS/SCSS Linter

Stylelint là linter cho stylesheet (CSS, SCSS, Less), giúp ngăn ngừa lỗi và chuẩn hoá coding convention cho giao diện Frontend.

## Cách chạy và xuất báo cáo
```bash
npx stylelint "**/*.css" --custom-formatter=node_modules/stylelint-json-formatter > ../../../monitoring/reports/frontend/stylelint/stylelint-report.json
```
