<script setup lang="ts">
import { gsap } from 'gsap';
import { onMounted, ref } from 'vue';

const heroRef = ref<HTMLElement | null>(null);
const titleRef = ref<HTMLElement | null>(null);
const subtitleRef = ref<HTMLElement | null>(null);
const btnRef = ref<HTMLElement | null>(null);
const arrowRef = ref<HTMLElement | null>(null);

onMounted(() => {
    const tl = gsap.timeline();
    tl.from(titleRef.value, {
        y: 40,
        opacity: 0,
        duration: 0.7,
        ease: 'power3.out',
    })
    .from(subtitleRef.value, {
        y: 20,
        opacity: 0,
        duration: 0.6,
        ease: 'power3.out',
    }, '<0.2')
    .from(btnRef.value, {
        y: 15,
        opacity: 0,
        duration: 0.5,
        ease: 'power3.out',
    }, '<0.15')
    .from(arrowRef.value, {
        y: -10,
        opacity: 0,
        duration: 0.6,
        ease: 'power3.out',
    }, '<0.15');
});

const scrollToServices = (e: Event) => {
    e.preventDefault();
    const el = document.getElementById('services');
    if (!el) return;
    
    const targetPosition = el.getBoundingClientRect().top + window.scrollY;
    const startPosition = window.scrollY;
    const distance = targetPosition - startPosition;
    const duration = 1200; // 1.2 seconds for a slow, smooth feel
    let start: number | null = null;

    const easeInOutCubic = (t: number, b: number, c: number, d: number) => {
        t /= d / 2;
        if (t < 1) return c / 2 * t * t * t + b;
        t -= 2;
        return c / 2 * (t * t * t + 2) + b;
    };

    const animation = (currentTime: number) => {
        if (start === null) start = currentTime;
        const timeElapsed = currentTime - start;
        const run = easeInOutCubic(timeElapsed, startPosition, distance, duration);
        window.scrollTo(0, run);
        if (timeElapsed < duration) requestAnimationFrame(animation);
    };

    requestAnimationFrame(animation);
};
</script>

<template>
    <section
        id="home"
        ref="heroRef"
        class="relative flex min-h-screen flex-col items-center justify-center overflow-hidden bg-background px-6 pb-32 pt-32 text-foreground"
    >
        <!-- Floating Elements -->
        <div class="absolute -top-40 -right-40 h-96 w-96 rounded-full bg-secondary opacity-30 blur-3xl mix-blend-multiply"></div>
        <div class="absolute -bottom-40 -left-40 h-96 w-96 rounded-full bg-primary opacity-10 blur-3xl mix-blend-multiply"></div>

        <div class="z-10 max-w-4xl text-center mt-20">
            <h1
                ref="titleRef"
                class="mb-6 text-6xl font-bold tracking-tight md:text-8xl"
            >
                We Build Digital <br />
                <span class="text-primary">Experiences</span> That Speak For Themselves.
            </h1>
            <p
                ref="subtitleRef"
                class="mx-auto mb-10 max-w-2xl text-xl text-foreground/80 md:text-2xl"
            >
                A premium digital agency creating modern, elegant, and technically impressive platforms.
            </p>
            <div ref="btnRef">
                <a
                    href="#contact"
                    class="group relative inline-flex items-center justify-center overflow-hidden rounded-full bg-primary px-8 py-4 font-semibold text-primary-foreground transition-transform hover:scale-105"
                >
                    <span class="absolute inset-0 h-full w-full rounded-full bg-foreground opacity-0 transition-opacity duration-300 group-hover:opacity-10"></span>
                    Start a Project
                    <svg class="ml-2 h-5 w-5 transition-transform group-hover:translate-x-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                    </svg>
                </a>
            </div>

            <!-- Scroll Indicator -->
            <div ref="arrowRef" class="mt-12 flex justify-center">
                <a href="#services" @click="scrollToServices" class="animate-bounce flex h-14 w-14 items-center justify-center rounded-full transition-colors hover:bg-foreground/10 group">
                    <svg class="h-6 w-6 text-foreground/50 transition-colors group-hover:text-foreground" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 14l-7 7m0 0l-7-7m7 7V3" />
                    </svg>
                </a>
            </div>
        </div>
    </section>
</template>
