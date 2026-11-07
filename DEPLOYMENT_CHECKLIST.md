# Deployment / acceptance checklist — Sơn Tự Online

## Known GitHub Pages path fix
This repository is published under `/son-tu-online/`, not `/`. `vite.config.js` sets `base: '/son-tu-online/'` so generated JS/CSS assets resolve under the repository path.

## Deploy
1. Commit/push the project to branch `main`.
2. GitHub → Settings → Pages → Build and deployment → Source: **GitHub Actions**.
3. GitHub → Actions → wait for **Deploy Sơn Tự Online to GitHub Pages** to pass (both Build and Deploy green).
4. Open `https://anhson2611.github.io/son-tu-online/` in a private/incognito window; hard refresh (Ctrl+Shift+R).

## Acceptance tests (must be run in a real browser)
- Landing screen renders (no blank page); browser console has no uncaught errors.
- 3D scene renders and camera can orbit/zoom; resize/mobile layout works.
- Keyboard movement and ritual buttons work; modal can be entered/closed.
- Chat, prayers, ritual history and sutra content show expected empty/loading/error states.
- Without Supabase keys, backend features must explicitly show offline/not configured; they must not pretend messages are online/persisted.
- With Supabase configured, test signup/login, RLS, realtime chat, prayer submission, and admin-only content editing using separate normal/admin accounts.

## Current validation status
- Source/config review: done for repository path (`base`) and Pages workflow.
- `npm install` / production build: **not completed in this environment** because DNS/network access to `registry.npmjs.org` failed (`EAI_AGAIN`).
- Browser smoke test and live deployment: **not run**. Do not consider this build accepted until the workflow and browser checks pass.
- Supabase: requires the project URL and anon key in GitHub Actions/runtime environment; service-role key must never be exposed in frontend.
