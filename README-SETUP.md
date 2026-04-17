# Hướng dẫn setup demo CI/CD Pipeline

## 1. Mục tiêu

Mục tiêu của demo này là thiết lập toàn bộ:

- Ứng dụng Python nhỏ
- Docker container
- GitHub Actions CI/CD
- Kiểm tra syntax + unit test
- Build image và đẩy lên GitHub Container Registry
- Deploy staging và production theo workflow

## 2. Cấu trúc hiện tại

- `demo-app/app.py` - ứng dụng Flask đơn giản
- `demo-app/requirements.txt` - thư viện cần thiết
- `demo-app/Dockerfile` - cách đóng gói Docker
- `demo-app/tests/test_app.py` - unit test
- `.github/workflows/demo-ci-cd.yml` - pipeline GitHub Actions

## 3. Các bước hoàn thành

### Bước 1: Kiểm tra local

1. Mở terminal ở thư mục `c:\Users\Tra Thanh Trung\Downloads\TraThanhTrung`
2. Cài thư viện vào môi trường ảo hoặc global:
   ```powershell
   python -m venv .venv
   .\.venv\Scripts\Activate.ps1
   python -m pip install --upgrade pip
   python -m pip install -r demo-app/requirements.txt
   ```
3. Chạy app local:
   ```powershell
   python demo-app/app.py
   ```
4. Thử mở `http://127.0.0.1:5000/` trong trình duyệt hoặc dùng:
   ```powershell
   curl http://127.0.0.1:5000/
   ```

### Bước 2: Chạy kiểm tra

1. Chạy lint/compile:
   ```powershell
   python -m py_compile demo-app/app.py demo-app/tests/test_app.py
   ```
2. Chạy unit test:
   ```powershell
   cd demo-app
   pytest
   ```

### Bước 3: Build Docker local

> Lưu ý: Docker daemon phải đang chạy. Nếu bạn dùng Docker Desktop, hãy mở và chờ trạng thái Ready.

1. Tạo image:
   ```powershell
   docker build -t demo-app:local demo-app
   ```
2. Chạy container:
   ```powershell
   docker run -p 5000:5000 demo-app:local
   ```
3. Kiểm tra `http://127.0.0.1:5000/`

### Bước 4: Push repository lên GitHub

1. Khởi tạo Git nếu cần:
   ```powershell
   git init
   git add .
   git commit -m "Add demo CI/CD pipeline"
   ```
2. Tạo repository trên GitHub và đẩy code lên.
3. Kích hoạt GitHub Actions trong tab `Actions`.

### Bước 5: Thực hành trên GitHub

1. Tạo branch `develop` và push code.
2. Tạo Pull Request vào `develop`.
3. Quan sát pipeline chạy qua 3 job:
   - `lint`
   - `test`
   - `build`
   - `deploy-staging`
4. Nếu merge vào `main`, job `deploy-prod` sẽ chạy.

## 4. Minh chứng

- Ảnh chụp màn hình tab `Actions` của repo:
  - `lint` màu xanh
  - `test` màu xanh
  - `build` màu xanh
  - `deploy-staging` màu xanh
- Nếu có lỗi, ảnh chụp job đỏ sẽ làm báo cáo thuyết phục.

## 5. Rollback và release

- Pipeline dùng `deploy-staging` trước, sau đó mới deploy `deploy-prod` khi merge vào `main`.
- Release stable: build image, push image, deploy từng bước.
- Rollback nhanh: nếu production lỗi, quay lại image cũ bằng cách dùng tag trước đó hoặc dùng container registry.
- Cơ chế khuyến nghị:
  - `rolling update` để không downtime
  - nếu hệ thống báo lỗi sau deploy, revert sang image cũ

## 6. Lưu ý cần cấu hình trên GitHub

- Nếu dùng GHCR để push image, bật `GitHub Container Registry` cho repo.
- Môi trường `production` có thể được bảo vệ bằng `environments` và `required reviewers`.
