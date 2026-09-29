# Code Scanners & Linters: Phân biệt Frontend (FE) & Backend (BE)

Bảng đối chiếu các công cụ kiểm tra tĩnh mã nguồn (Linters/Static Analyzers) tương đương với **Flake8** (Python):

| Phân tầng | Ngôn ngữ / Nền tảng | Công cụ tương đương Flake8 | Mục đích chính | Thư mục cấu hình |
| :--- | :--- | :--- | :--- | :--- |
| **Frontend** | **React / JS / TS** | **ESLint** (+ React & Hooks plugins) | Kiểm tra syntax, best practices, rules của hooks, accessibility JSX | `frontend/react-eslint` |
| **Frontend** | **CSS / SCSS** | **Stylelint** | Chuẩn hoá cú pháp, tránh selector lỗi và trùng lặp style | `frontend/stylelint` |
| **Backend** | **Python** | **Flake8** | PEP 8, syntax error, Cyclomatic Complexity | `backend/python-flake8` |
| **Backend** | **Java** | **Checkstyle** (+ PMD / SpotBugs) | Coding convention, naming rules, import thừa, độ phức tạp | `backend/java-checkstyle` |
| **Backend** | **C# / .NET** | **dotnet format & Roslyn Analyzers** | Chuẩn hoá định dạng, syntax rules qua `.editorconfig` chuẩn Microsoft | `backend/csharp-dotnet-format` |
| **Backend** | **Node.js** | **ESLint** (+ Node & Security plugins) | Phát hiện anti-patterns, callback/async bugs, security traversal | `backend/nodejs-eslint` |

Tất cả các scanner trên đều được cấu hình xuất kết quả trực tiếp về thư mục trung tâm `../../monitoring/reports/`.
