# C# / .NET Code Scanner (dotnet format & Roslyn Analyzers)

Trong hệ sinh thái **C# và .NET**, giải pháp tương đương chính thức và chuẩn mực nhất với **Flake8** là:
- **`dotnet format`**: Công cụ tích hợp sẵn trong .NET SDK, kiểm tra syntax format và style theo file `.editorconfig`.
- **Roslyn Analyzers / StyleCop Analyzers**: Tự động kiểm tra chất lượng code, naming rules, anti-patterns ngay trong quá trình build hoặc chạy linter.

## Cách chạy và xuất báo cáo vào Monitoring

```bash
# Kiểm tra code style (dry-run, không tự động sửa, trả về mã lỗi nếu vi phạm)
dotnet format --verify-no-changes --verbosity diagnostic > ../../../monitoring/reports/backend/csharp/csharp-format-report.txt

# Kiểm tra cả analyzers và xuất report chi tiết
dotnet format analyzers --verify-no-changes --report ../../../monitoring/reports/backend/csharp/analyzers-report.json
```
Báo cáo sẽ được lưu tại: `monitoring/reports/backend/csharp/`.
