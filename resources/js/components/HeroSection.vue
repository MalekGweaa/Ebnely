<script setup lang="ts">
import { gsap } from 'gsap';
import { ScrollToPlugin } from 'gsap/ScrollToPlugin';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import { onMounted, onUnmounted, ref } from 'vue';

gsap.registerPlugin(ScrollToPlugin, ScrollTrigger);

const heroRef = ref<HTMLElement | null>(null);
const contentRef = ref<HTMLElement | null>(null);
const titleRef = ref<HTMLElement | null>(null);
const subtitleRef = ref<HTMLElement | null>(null);
const arrowRef = ref<HTMLElement | null>(null);
const rippleRef = ref<HTMLElement | null>(null);

let isScrolling = false;
let ctx: gsap.Context;

onMounted(() => {
    ctx = gsap.context(() => {
    // Initial Reveal Animation
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
    .from(arrowRef.value, {
        y: -10,
        opacity: 0,
        duration: 0.6,
        ease: 'power3.out',
    }, '<0.15');

    // Scroll Journey Parallax Animation
    if (heroRef.value && contentRef.value) {
        gsap.to(contentRef.value, {
            scrollTrigger: {
                trigger: heroRef.value,
                start: "top top",
                end: "bottom top",
                scrub: true,
            },
            y: -100, // Move upward slightly while scrolling
        });
    }
    });
});

onUnmounted(() => {
    if (ctx) ctx.revert();
});

const scrollToServices = () => {
    if (isScrolling) return;

    const el = document.getElementById('services');
    if (!el) return;

    isScrolling = true;

    // Arrow click animation (instant feedback)
    if (arrowRef.value) {
        gsap.to(arrowRef.value, {
            scale: 0.85,
            duration: 0.075,
            yoyo: true,
            repeat: 1,
            ease: 'power1.inOut'
        });
    }

    const header = document.querySelector('header');
    const headerHeight = header ? header.offsetHeight + 20 : 100;

    // Cinematic Smooth Scroll
    gsap.killTweensOf(window); // Prevent duplicate conflicting tweens
    gsap.to(window, {
        duration: 1.3,
        scrollTo: { y: el, autoKill: false },
        ease: 'expo.inOut',
        onComplete: () => {
            isScrolling = false;
        }
    });
};
</script>

<template>
    <section
        id="home"
        ref="heroRef"
        class="relative flex flex-col items-center justify-center min-h-[100dvh] overflow-hidden bg-background px-4 lg:px-6 pt-24 pb-16 text-foreground"
    >
        <!-- Floating Elements -->
        <div class="absolute -top-40 -right-40 h-96 w-96 rounded-full bg-secondary opacity-30 blur-3xl mix-blend-multiply"></div>
        <div class="absolute -bottom-40 -left-40 h-96 w-96 rounded-full bg-primary opacity-10 blur-3xl mix-blend-multiply"></div>

        <div ref="contentRef" class="z-10 max-w-4xl text-center -mt-20 md:-mt-24 lg:-mt-16">
            <h1
                ref="titleRef"
                class="mb-4 lg:mb-6 text-[2.5rem] leading-[1.05] sm:text-5xl md:text-6xl lg:text-8xl font-bold tracking-tight"
            >
                We Build Digital <br />
                <span class="text-primary">Experiences</span> That Speak For Themselves.
            </h1>
            <p
                ref="subtitleRef"
                class="mx-auto max-w-2xl text-lg text-foreground/80 md:text-2xl font-light"
            >
                Elegant digital products built with precision and purpose.
            </p>
        </div>

        <!-- Scroll Indicator (Absolute Bottom) -->
        <div class="absolute bottom-8 lg:bottom-12 left-1/2 -translate-x-1/2 z-20 flex justify-center">
            <a 
                ref="arrowRef"
                role="button"
                tabindex="0"
                @click.prevent="scrollToServices" 
                class="group flex flex-col items-center justify-center transition-transform duration-[250ms] hover:-translate-y-[2px] cursor-pointer"
            >
                <svg class="h-8 w-8 animate-bounce-subtle transition-opacity duration-[250ms] group-hover:opacity-100" style="color: #810B38; opacity: 0.5;" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19 14l-7 7m0 0l-7-7m7 7V3" />
                </svg>
            </a>
        </div>
    </section>
</template>

<style scoped>
@keyframes bounceSubtle {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(8px); }
}
.animate-bounce-subtle {
  animation: bounceSubtle 1.8s ease-in-out infinite;
}
</style>
