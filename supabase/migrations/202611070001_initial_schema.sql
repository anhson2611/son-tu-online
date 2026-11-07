-- SON TU ONLINE — Supabase schema (run once in Supabase SQL Editor)
create extension if not exists pgcrypto;

create table if not exists public.profiles (
 id uuid primary key references auth.users(id) on delete cascade,
 display_name text not null default 'Phật tử',
 pháp_danh text,
 avatar_url text,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
create table if not exists public.chat_messages (
 id uuid primary key default gen_random_uuid(),
 user_id uuid references auth.users(id) on delete set null,
 display_name text not null,
 content text not null check (char_length(content) between 1 and 1000),
 created_at timestamptz not null default now()
);
create table if not exists public.ritual_logs (
 id uuid primary key default gen_random_uuid(),
 user_id uuid references auth.users(id) on delete set null,
 display_name text not null,
 ritual_type text not null check (ritual_type in ('le-phat','thap-huong','dang-hoa','thien','cau-an','cau-sieu')),
 intention text,
 created_at timestamptz not null default now()
);
create table if not exists public.prayer_requests (
 id uuid primary key default gen_random_uuid(),
 user_id uuid references auth.users(id) on delete set null,
 display_name text not null,
 content text not null check (char_length(content) between 1 and 1000),
 is_public boolean not null default true,
 created_at timestamptz not null default now()
);
create table if not exists public.temple_presence (
 user_id uuid primary key references auth.users(id) on delete cascade,
 display_name text not null,
 entered_at timestamptz not null default now()
);
alter table public.profiles enable row level security;
alter table public.chat_messages enable row level security;
alter table public.ritual_logs enable row level security;
alter table public.prayer_requests enable row level security;
alter table public.temple_presence enable row level security;

drop policy if exists "profiles readable" on public.profiles;
create policy "profiles readable" on public.profiles for select using (true);
drop policy if exists "profile owner insert" on public.profiles;
create policy "profile owner insert" on public.profiles for insert to authenticated with check (auth.uid()=id);
drop policy if exists "profile owner update" on public.profiles;
create policy "profile owner update" on public.profiles for update to authenticated using (auth.uid()=id) with check (auth.uid()=id);
drop policy if exists "chat read" on public.chat_messages;
create policy "chat read" on public.chat_messages for select using (true);
drop policy if exists "chat insert auth" on public.chat_messages;
create policy "chat insert auth" on public.chat_messages for insert to authenticated with check (auth.uid()=user_id);
drop policy if exists "ritual read own" on public.ritual_logs;
create policy "ritual read own" on public.ritual_logs for select to authenticated using (auth.uid()=user_id);
drop policy if exists "ritual insert auth" on public.ritual_logs;
create policy "ritual insert auth" on public.ritual_logs for insert to authenticated with check (auth.uid()=user_id);
drop policy if exists "prayers public read" on public.prayer_requests;
create policy "prayers public read" on public.prayer_requests for select using (is_public or auth.uid()=user_id);
drop policy if exists "prayers insert auth" on public.prayer_requests;
create policy "prayers insert auth" on public.prayer_requests for insert to authenticated with check (auth.uid()=user_id);
drop policy if exists "presence read" on public.temple_presence;
create policy "presence read" on public.temple_presence for select using (true);
drop policy if exists "presence owner insert" on public.temple_presence;
create policy "presence owner insert" on public.temple_presence for insert to authenticated with check (auth.uid()=user_id);
drop policy if exists "presence owner update" on public.temple_presence;
create policy "presence owner update" on public.temple_presence for update to authenticated using (auth.uid()=user_id) with check (auth.uid()=user_id);
drop policy if exists "presence owner delete" on public.temple_presence;
create policy "presence owner delete" on public.temple_presence for delete to authenticated using (auth.uid()=user_id);

-- Enable Realtime for chat/presence tables in Supabase Dashboard if not already enabled.
