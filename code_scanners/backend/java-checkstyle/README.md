# Java Checkstyle Scanner (Backend)

**Checkstyle** là công cụ phân tích tĩnh mã nguồn tương đương trực tiếp nhất với **Flake8** trong hệ sinh thái Java:
- Enforce coding standards (naming, indentation, import conventions).
- Kiểm tra độ phức tạp chu trình (Cyclomatic Complexity - tương đương module McCabe của Flake8).
- Có thể kết hợp thêm với **PMD** và **SpotBugs** cho bug detection chuyên sâu.

## Cách chạy trong Pipeline và xuất báo cáo vào Monitoring

### 1. Sử dụng với Maven
Thêm plugin vào `pom.xml`:
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-checkstyle-plugin</artifactId>
    <version>3.3.1</version>
    <configuration>
        <configLocation>code_scanners/backend/java-checkstyle/checkstyle.xml</configLocation>
        <outputFile>monitoring/reports/backend/checkstyle/checkstyle-result.xml</outputFile>
    </configuration>
</plugin>
```
Lệnh thực thi:
```bash
mvn checkstyle:checkstyle
```

### 2. Sử dụng với Gradle
```bash
./gradlew checkstyleMain
# File báo cáo mặc định xuất tại: build/reports/checkstyle/
```

### 3. Sử dụng Checkstyle CLI trực tiếp qua Docker
```bash
docker run --rm -v $(pwd):/src checkstyle/checkstyle:latest -c /src/code_scanners/backend/java-checkstyle/checkstyle.xml /src/backend-java > monitoring/reports/backend/checkstyle/checkstyle-report.txt
```
