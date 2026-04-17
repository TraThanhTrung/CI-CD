# Release và Rollback Demo

## Cách tạo Release trên GitHub

1. Trên GitHub repository, click tab "Releases"
2. Click "Create a new release"
3. Chọn tag version (ví dụ: v1.0.0)
4. Điền title và description
5. Click "Publish release"

## Workflow sẽ tự động chạy job "release" khi publish release.

## Demo Rollback

Khi deploy production thất bại, workflow sẽ chạy job "rollback":

1. Phát hiện lỗi trong deploy-prod
2. Tự động chạy rollback job
3. Quay về image trước đó
4. Thông báo rollback thành công

### Chạy rollback script local:

```bash
chmod +x rollback-demo.sh
./rollback-demo.sh
```

## Minh chứng

- **Pipeline xanh**: Lint, Test, Build, Deploy thành công
- **Pipeline đỏ**: Khi có lỗi, rollback tự động
- **Release**: Tạo tag và publish release

Screenshots nên chụp:
- Tab Actions với jobs xanh
- Tab Releases với version mới
- Logs của rollback job