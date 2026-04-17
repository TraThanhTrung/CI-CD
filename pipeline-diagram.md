# CI/CD Pipeline Diagram

```mermaid
graph TD
    A[Trigger: Push/PR] --> B[Lint: Syntax Check]
    B --> C[Test: Unit Tests]
    C --> D[Build: Docker Image]
    D --> E[Deploy Staging]
    E --> F[Deploy Production]
    F --> G[Monitor & Notify]
    G --> H{Health Check OK?}
    H -->|Yes| I[Success]
    H -->|No| J[Rollback]
    J --> K[Revert to Previous Image]
```

## Giải thích
- **Trigger**: Khi push code hoặc tạo PR
- **Lint**: Kiểm tra cú pháp
- **Test**: Chạy unit test
- **Build**: Tạo Docker image
- **Deploy Staging**: Triển khai lên môi trường thử nghiệm
- **Deploy Production**: Triển khai lên production
- **Monitor**: Giám sát và thông báo
- **Health Check**: Kiểm tra sức khỏe hệ thống
- **Rollback**: Quay về phiên bản trước nếu có lỗi