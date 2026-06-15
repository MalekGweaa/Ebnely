import { createApp } from 'vue';
import { createPinia } from 'pinia';
import router from './router';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import { initializeTheme } from '@/composables/useAppearance';
import App from '../views/App.vue';

import '../css/app.css'; // Adjust CSS import if needed

gsap.registerPlugin(ScrollTrigger);

const app = createApp(App);

app.use(createPinia());
app.use(router);

app.mount('#app');

initializeTheme();
