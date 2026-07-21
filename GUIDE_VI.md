<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Hướng dẫn SAIPEN (Tiếng Việt)

SAIPEN là sổ ghi nhớ trong thư mục `.saipen/` cho các tác nhân AI.

## Khởi đầu nhanh

1. **Cài đặt một lần cho mỗi máy:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Khởi động dự án:**
> `saipen set`

3. **Làm việc:**
> `saipen`

## Lệnh

| Lệnh | Hành động |
|---|---|
| `saipen set` | Khởi tạo thư mục bộ nhớ `.saipen/` |
| `saipen continue` | Tiếp tục công việc từ ghi chú |
| `saipen stop` | Lưu tiến trình & dừng lại |
| `saipen status` | Đọc bảng & trạng thái |
| `saipen goal <text>` | Chuyển sang mục tiêu mới |
| `saipen clean` | Dọn dẹp sâu kho lưu trữ |
| `saipen translate` | Xây dựng bản dịch 22 ngôn ngữ cô lập |
| `saipen ship` | Kích hoạt quy trình phát hành |
