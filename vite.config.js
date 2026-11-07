import {defineConfig} from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  // GitHub Pages serves this repository under /son-tu-online/ (not the domain root).
  base: '/son-tu-online/',
  plugins: [react()],
});
