# Ebnely Website - Project Reference

## Overview
This project is the Ebnely website built to showcase development, design, and engineering capabilities through its exceptional user experience. It avoids generic marketing claims and instead relies on technical excellence, smooth animations, and a cohesive design system.

## Technology Stack
- **Frontend Framework**: Vue 3 (Composition API)
- **Routing & State**: Laravel Inertia.js, Pinia (State Management)
- **Styling**: Tailwind CSS v4
- **Animations**: GSAP (GreenSock Animation Platform) + ScrollTrigger
- **Backend**: Laravel 11

## Design Philosophy & Aesthetics
The site communicates professionalism through an immersive and dynamic UI.
- **Vibe**: Bright, warm, luxurious, modern, and elegant.
- **Color Palette**:
  - **Soft Cream (`#F1E2D1`)**: Used for 60% of the site (Primary page backgrounds).
  - **Warm Beige (`#DCC3AA`)**: Used for 25% of the site (Cards, containers, subtle accents).
  - **Dark Maroon (`#541A1A`)**: Used for 10% of the site (Headings, primary readable text, navigation).
  - **Primary Burgundy (`#810B38`)**: Used for 5% of the site (Highlights, CTA buttons, specific active states).

*(Note: The Tailwind `.dark` mode logic was overridden to ensure the bright/warm aesthetic is strictly preserved regardless of the user's system preferences.)*

## Components & Architecture
The landing page (`Welcome.vue`) is constructed using a modular, component-driven architecture located in `resources/js/components/`:

1. **HeroSection**: Immersive hero text with GSAP reveal animations.
2. **ServicesSection ("Our Expertise")**: A 50/50 split layout. The left side holds Warm Beige (`#DCC3AA`) cards listing the services, and the right side features a highly aesthetic image (e.g., a modern chair). The section background is Primary Burgundy (`#810B38`).
3. **ProjectsSection**: Horizontal scroll or interactive project showcase.
4. **EngineeringSection**: Highlights technical stacks with fluid animations.
5. **CreativeLabSection**: A hardware-accelerated GSAP playground area showcasing fluid interactions.
6. **DesignSystemSection**: Interactive showcase of the typography and colors.
7. **TestimonialsSection**: Client reviews.
8. **ContactSection**: Final CTA and form.

## Key Decisions
- **Inertia.js over Vue Router**: We opted for Laravel Inertia to keep the backend tightly coupled with the frontend without building a separate API layer.
- **GSAP ScrollTrigger**: Used extensively instead of CSS animations to ensure high-performance, scroll-linked animations that feel premium.
- **Tailwind v4 Setup**: Colors are managed directly via CSS variables in `resources/css/app.css` to integrate smoothly with Shadcn-like components while avoiding HSL parsing bugs.

## How to Run & Build
- **Development**: `npm run dev` (Runs Vite with hot-module replacement).
- **Production Build**: `npm run build` (Compiles assets to `public/build`).
- **Backend**: `php artisan serve` (or served via Laravel Valet / Herd).
