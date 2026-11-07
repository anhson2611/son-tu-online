# 🪷 Sơn Tự Online — Chùa Việt 3D

Không gian chùa 3D trên trình duyệt: đi lại, lễ Phật, thiền, thắp hương, dâng hoa và giao lưu.

## Chạy thử
- [Mở GitHub Pages](https://anhson2611.github.io/son-tu-online/)
- PC: WASD/mũi tên di chuyển; kéo chuột xoay góc nhìn.
- Điện thoại: dùng nút điều khiển.
- Nhập pháp danh và bấm **Vào chùa**.

## Trạng thái hiện tại — minh bạch
Bản hiện tại là **3D client demo**. Chat/nghi lễ chỉ hiển thị trên máy đang mở; chưa có xác thực tài khoản, lưu dữ liệu hay multiplayer thật. Không nhập mật khẩu ở bản demo.

## Chuẩn bị backend Supabase
1. Mở Supabase SQL Editor, chạy `supabase/schema.sql`.
2. Lấy Project URL + **anon/public key** (không dùng service_role key trên trình duyệt).
3. Điền vào `config.js`.
4. Bật Realtime cho các bảng cần thiết và kiểm thử chính sách RLS trước khi phát hành.

## Cấu trúc
- `index.html`: cảnh 3D, điều khiển và nghi lễ.
- `supabase/schema.sql`: bảng profiles, chat, lời nguyện, nghi lễ + RLS.
- `config.js`: cấu hình public phía trình duyệt (placeholder).

**Lưu ý:** schema là nền tảng backend, chưa đồng nghĩa frontend đã kết nối realtime/auth.
