# Project Architecture & Deployment Guide

## Tech Stack
This project is built using a modern full-stack architecture:
- **Backend**: Laravel (PHP)
- **Frontend**: Vue.js 3
- **Glue/Routing**: Inertia.js (connects Laravel and Vue without needing an API)
- **Styling**: Tailwind CSS (via Vite)

## Why GitHub Pages Won't Work
GitHub Pages is designed **only for static sites** (pure HTML, CSS, and JS). 
Because this application uses Laravel to handle server-side routing, database connections, and Inertia.js to render Vue components, it requires a server capable of running PHP. Therefore, it **cannot** be hosted on GitHub Pages.

## How to Deploy This Project
To successfully deploy this application, you need a hosting environment that supports both PHP and Node.js (for asset building). 

### Recommended Hosting Options:
1. **Laravel Forge / Envoyer**: The official ecosystem tools. Best used with a DigitalOcean or AWS server.
2. **DigitalOcean App Platform**: Great for full-stack apps. You can link your GitHub repo and it will auto-deploy.
3. **Render or Heroku**: Good PaaS (Platform as a Service) options that support PHP and Node.js.
4. **VPS (Virtual Private Server)**: You can rent a droplet from DigitalOcean, install PHP, Nginx, and MySQL, and deploy manually.

### Deployment Steps (General)
When deploying to a server, the general steps run by the server are:
1. `git pull` the latest code.
2. `composer install --no-dev --optimize-autoloader` (Install PHP dependencies)
3. `npm install` (Install Node dependencies)
4. `npm run build` (Compile Vue/Vite assets for production)
5. `php artisan migrate --force` (Run database migrations)
6. `php artisan config:cache`, `route:cache`, `view:cache` (Optimize Laravel)
