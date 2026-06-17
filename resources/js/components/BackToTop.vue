<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

const isVisible = ref(false);
const buttonRef = ref<HTMLElement | null>(null);

const handleScroll = () => {
    isVisible.value = window.scrollY > 300;
};

const scrollToTop = () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
};

const isColorDark = (colorStr: string) => {
    const match = colorStr.match(/rgba?\((\d+),\s*(\d+),\s*(\d+)/);
    if (!match) return false;
    const r = parseInt(match[1]);
    const g = parseInt(match[2]);
    const b = parseInt(match[3]);
    const luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255;
    return luminance < 0.5;
};

let triggers: ScrollTrigger[] = [];

onMounted(() => {
    window.addEventListener('scroll', handleScroll);

    // Initialize button colors
    if (buttonRef.value) {
        gsap.set(buttonRef.value, {
            backgroundColor: '#541A1A',
            color: '#F1E2D1'
        });
    }

    const updateTheme = (section: Element) => {
        if (!buttonRef.value) return;
        
        const bgColor = window.getComputedStyle(section).backgroundColor;
        const isDark = isColorDark(bgColor);
        
        if (isDark) {
            gsap.to(buttonRef.value, {
                backgroundColor: '#F1E2D1',
                color: '#541A1A',
                duration: 0.4,
                ease: 'power2.out'
            });
        } else {
            gsap.to(buttonRef.value, {
                backgroundColor: '#541A1A',
                color: '#F1E2D1',
                duration: 0.4,
                ease: 'power2.out'
            });
        }
    };

    // Create ScrollTriggers for all sections to detect which one is at the button's position
    document.querySelectorAll('section').forEach((section) => {
        const st = ScrollTrigger.create({
            trigger: section,
            start: 'top 95%', // Trigger when section top enters the bottom 5% of viewport
            end: 'bottom 95%', // Trigger when section bottom leaves the bottom 5% of viewport
            onEnter: () => updateTheme(section),
            onEnterBack: () => updateTheme(section),
        });
        triggers.push(st);
    });
    
    // Set initial theme based on current scroll position
    const elements = document.elementsFromPoint(window.innerWidth - 32, window.innerHeight - 32);
    const initialSection = elements.find(el => el.tagName.toLowerCase() === 'section');
    if (initialSection) {
        updateTheme(initialSection);
    }
});

onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
    triggers.forEach(t => t.kill());
});
</script>

<template>
    <button
        ref="buttonRef"
        @click="scrollToTop"
        class="fixed bottom-8 right-8 z-50 p-4 md:p-5 rounded-full shadow-2xl transition-transform duration-300 hover:scale-110 focus:outline-none focus:ring-4 focus:ring-[#541A1A]/30"
        :class="isVisible ? 'opacity-100 translate-y-0 pointer-events-auto' : 'opacity-0 translate-y-10 pointer-events-none'"
        aria-label="Back to top"
    >
        <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M5 10l7-7m0 0l7 7m-7-7v18" />
        </svg>
    </button>
</template>
