# Kết nối Supabase — Sơn Tự Online

Project URL đã xác định: https://iotrbyvenbdcbvqknhh.supabase.co

## 1. Chạy schema
Mở Supabase Dashboard → SQL Editor → New query. Dán và chạy toàn bộ:
`supabase/migrations/202611070001_initial_schema.sql`.

Schema tạo profiles, chat_messages, ritual_logs, prayer_requests, temple_presence cùng Row Level Security.

## 2. Bật Realtime
Database → Publications (hoặc Database → Replication), bật Realtime cho `chat_messages` và `temple_presence`. Presence realtime nên dùng Supabase Realtime Presence channel; bảng temple_presence là dữ liệu trạng thái bền.

## 3. Cấu hình GitHub Pages
Repository → Settings → Secrets and variables → Actions → New repository secret:
- `VITE_SUPABASE_URL` = `https://iotrbyvenbdcbvqknhh.supabase.co`
- `VITE_SUPABASE_ANON_KEY` = anon/publishable key trong Project Settings → API Keys.

Không dùng service_role key trong frontend hoặc GitHub Pages.

## 4. Auth
Supabase Dashboard → Authentication → URL Configuration:
- Site URL: `https://anhson2611.github.io/son-tu-online/`
- Redirect URL: `https://anhson2611.github.io/son-tu-online/**`

Sau khi thêm secrets, chạy Actions → Deploy để build lại.

## Trạng thái
Việc tạo migration trong GitHub không tự chạy SQL trên Supabase. Cần chạy migration trong SQL Editor và thêm GitHub Actions secrets bằng tài khoản có quyền; các bước này không thể thực hiện từ kết nối GitHub hiện có.
