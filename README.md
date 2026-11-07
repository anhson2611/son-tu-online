# SƠN TỰ ONLINE — Web 3D Temple Platform (MVP nền tảng)

Đây là dự án React + Three.js + Supabase, khác với HTML demo đơn file. Có cảnh chùa 3D tương tác, avatar di chuyển, Supabase Auth, chat realtime, Presence/Broadcast (người chơi hiện diện và vị trí), nghi thức, lưu tâm nguyện.

## Cấu hình
1. `npm install`
2. Tạo Supabase project. SQL Editor → chạy `supabase/schema.sql`.
3. Copy `.env.example` thành `.env` và điền `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY` (anon/public key; không dùng service_role).
4. Database → Replication/Realtime: bật `chat_messages`.
5. `npm run dev` để chạy local; `npm run build` để build deploy.

## Deploy
- Vercel: Import repo → framework Vite → add 2 environment variables → Deploy.
- Netlify: build command `npm run build`, publish directory `dist`, add env vars.
- GitHub Pages: cấu hình base path repo trong vite.config.js trước khi deploy.

## Cấu trúc
- `src/components/Temple.jsx`: scene Three.js, kiến trúc chùa và avatar.
- `src/App.jsx`: UI, Auth, chat, Presence, nghi lễ, tâm nguyện.
- `src/lib/supabase.js`: Supabase client.
- `supabase/schema.sql`: tables + RLS.

## Cần minh bạch
Bản này là một nền tảng MVP có chức năng thực thi, không phải bản production đã audit. Mô hình 3D hiện dựng procedural; để đạt giống ChuaOnline ở mức gần như 100% cần asset GLB/GLTF có bản quyền/được cấp phép (kiến trúc, tượng, nhân vật, animations) và tinh chỉnh dựa trên video gốc. Chưa có admin CMS đầy đủ, voice/video, hệ thống giao dịch, moderation nâng cao hay kiểm thử tải. Những phần này không được tuyên bố đã xong.


## Backend hardening (bản tiếp theo)

File `supabase/production.sql` bổ sung:
- Trigger tự tạo hồ sơ khi đăng ký tài khoản.
- Hồ sơ Phật tử, chat, tâm nguyện, lịch sử nghi lễ, thư viện kinh và bài pháp.
- RLS: người dùng chỉ sửa dữ liệu của mình; kinh/pháp thoại chỉ đọc khi đã xuất bản.
- Index cho chat/tâm nguyện/lịch sử.
- Seed 3 mục kinh (đoạn trích/placeholder có ghi rõ cần đối chiếu trước khi xuất bản toàn văn).
- Bật Realtime cho chat và tâm nguyện nếu publication tồn tại.

### Kết nối dự án
1. Supabase → SQL Editor → chạy `supabase/production.sql`.
2. Supabase → Project Settings → API: sao chép **Project URL** và **anon/public key**.
3. Tạo `.env` từ `.env.example`, điền:
   - `VITE_SUPABASE_URL=...`
   - `VITE_SUPABASE_ANON_KEY=...`
4. Không đưa `service_role` vào trình duyệt, GitHub hoặc file `.env` client.
5. Chạy `npm install` rồi `npm run build`; chỉ deploy thư mục `dist`.

### Trạng thái minh bạch
Đây là bản nền tảng phát triển. Trước khi mở công khai cần kiểm thử build, mobile, auth, RLS, realtime, chống spam, quyền quản trị, nội dung kinh có nguồn/bản quyền, và tài sản 3D chính thức. Không coi dữ liệu seed là kinh văn toàn bộ.

### Cấp quyền quản trị an toàn
- Tạo tài khoản chủ website trước.
- Trong SQL Editor, thay email và chạy câu lệnh cuối file `supabase/production.sql` để thêm đúng UID vào `app_admins`.
- Không có nút tự cấp quyền admin trong giao diện; người dùng không thể tự nâng quyền.
