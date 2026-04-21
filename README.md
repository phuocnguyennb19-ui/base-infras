# Base Infrastructure Foundation

Repository này chứa **Infrastructure Layer** (Lớp hạ tầng nền móng). Nó chịu trách nhiệm thiết lập các thành phần cơ bản mà mọi ứng dụng đều cần.

## 🏗️ Kiến trúc & Liên kết

Đây là repo "đi trước" trong quy trình triển khai. Nó cung cấp các thông tin nền tảng cho lớp ứng dụng.

### Cách liên kết (Linking)

1. **Source Layer (`terraform-module`)**: 
   - Repo này gọi code từ `terraform-module` để tạo tài nguyên.
   - Ví dụ: `source = "git::https://github.com/.../terraform-module.git//modules/vpc?ref=master"`

2. **Application Layer (`aws-services-app`)**:
   - `base-infras` **xuất dữ liệu** thông qua Terraform Outputs và lưu vào Remote State (S3).
   - `aws-services-app` sẽ đọc các dữ liệu này (VPC ID, Subnet IDs) để triển khai các dịch vụ app.

## 📂 Các tài nguyên quản lý

- **Mạng**: VPC, Subnets, Internet Gateway.
- **Bảo mật**: IAM Roles, KMS Keys, WAF.
- **Lưu trữ**: S3 Buckets, ECR Repositories.
- **Tên miền**: Route53 Zones, ACM Certificates.

## 🚀 Cách triển khai

1. Chỉnh sửa cấu hình trong thư mục `deployments/dev/` hoặc `deployments/prod/`.
2. Pipeline sẽ tự động chạy `terraform plan` và chờ phê duyệt để `apply`.

> [!IMPORTANT]
> Mọi thay đổi ở đây có thể ảnh hưởng đến toàn bộ các ứng dụng chạy phía trên. Hãy cẩn trọng khi chỉnh sửa VPC hoặc IAM.
