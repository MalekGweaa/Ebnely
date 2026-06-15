<script setup lang="ts">
import { gsap } from 'gsap';
import { onMounted, ref } from 'vue';

const containerRef = ref<HTMLElement | null>(null);
const cardsRef = ref<HTMLElement[]>([]);

onMounted(() => {
    // Parallax effect on mouse move
    const handleMouseMove = (e: MouseEvent) => {
        const x = (e.clientX / window.innerWidth - 0.5) * 20;
        const y = (e.clientY / window.innerHeight - 0.5) * 20;

        gsap.to(cardsRef.value, {
            x: x,
            y: y,
            duration: 1,
            ease: 'power2.out',
            stagger: 0.05,
        });
    };

    containerRef.value?.addEventListener('mousemove', handleMouseMove);
});
</script>

<template>
    <section ref="containerRef" class="relative py-40 px-6 bg-background text-foreground overflow-hidden" id="creative-lab">
        <div class="max-w-7xl mx-auto relative z-10 flex flex-col items-center text-center">
            <span class="text-primary font-bold tracking-[0.2em] uppercase mb-4 block">Creative Laboratory</span>
            <h2 class="text-5xl md:text-7xl font-bold mb-8">Pushing the boundaries<br/>of digital interaction.</h2>
            <p class="text-xl opacity-80 max-w-2xl mb-16">
                Move your cursor to experience fluid, hardware-accelerated animations powered by GSAP.
            </p>

            <div class="relative w-full max-w-4xl aspect-[2/1] md:aspect-[3/1] perspective-1000">
                <div
                    ref="cardsRef"
                    class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-64 h-40 bg-card rounded-2xl shadow-2xl opacity-80 border border-primary/20"
                    style="transform-origin: center center; margin-left: -100px; margin-top: -20px; z-index: 1"
                ></div>
                <div
                    ref="cardsRef"
                    class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-64 h-40 bg-secondary rounded-2xl shadow-2xl opacity-90 border border-primary/30"
                    style="transform-origin: center center; margin-left: 0; margin-top: 0; z-index: 2"
                ></div>
                <div
                    ref="cardsRef"
                    class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-64 h-40 bg-primary rounded-2xl shadow-2xl opacity-100 border border-background/20"
                    style="transform-origin: center center; margin-left: 100px; margin-top: 20px; z-index: 3"
                >
                    <div class="h-full w-full flex items-center justify-center font-bold text-primary-foreground">
                        Micro-Interactions
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Abstract background elements -->
        <div class="absolute top-0 right-0 w-[800px] h-[800px] bg-primary/10 rounded-full blur-[120px] -translate-y-1/2 translate-x-1/3 pointer-events-none"></div>
    </section>
</template>
