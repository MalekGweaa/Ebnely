<script setup lang="ts">
import { gsap } from 'gsap';
import { onMounted, ref } from 'vue';

const sectionRef = ref<HTMLElement | null>(null);
const statsRefs = ref<HTMLElement[]>([]);

const stats = ref([
    { label: 'Uptime SLA', prefix: '', current: 0, target: 99.99, suffix: '%', isFloat: true },
    { label: 'Global Latency', prefix: '<', current: 0, target: 50, suffix: 'ms', isFloat: false },
    { label: 'Lines of Code', prefix: '', current: 0, target: 1, suffix: 'M+', isFloat: false },
    { label: 'API Requests/sec', prefix: '', current: 0, target: 10, suffix: 'k+', isFloat: false },
]);

onMounted(() => {
    const stConfig = {
        trigger: sectionRef.value,
        start: 'top 70%',
    };

    gsap.from(statsRefs.value, {
        scrollTrigger: stConfig,
        scale: 0.8,
        opacity: 0,
        duration: 0.6,
        stagger: 0.15,
        ease: 'back.out(1.7)',
    });

    stats.value.forEach((stat, index) => {
        gsap.to(stat, {
            scrollTrigger: stConfig,
            current: stat.target,
            duration: 2,
            delay: index * 0.15,
            ease: 'power2.out',
        });
    });
});
</script>

<template>
    <section ref="sectionRef" class="py-32 px-6 bg-background text-foreground" id="engineering">
        <div class="max-w-7xl mx-auto flex flex-col lg:flex-row items-center gap-16">
            <!-- Text Content -->
            <div class="w-full lg:w-1/2">
                <h2 class="text-4xl md:text-5xl font-bold mb-6">Engineering Excellence</h2>
                <p class="text-xl text-foreground/80 mb-8 leading-relaxed">
                    We don't just build websites; we engineer robust, scalable systems capable of handling enterprise demands. Our architecture ensures maximum performance, security, and maintainability.
                </p>
                <ul class="space-y-4 mb-10">
                    <li class="flex items-center text-lg">
                        <svg class="h-6 w-6 text-primary mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                        Scalable Microservices Architecture
                    </li>
                    <li class="flex items-center text-lg">
                        <svg class="h-6 w-6 text-primary mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                        Advanced State Management
                    </li>
                    <li class="flex items-center text-lg">
                        <svg class="h-6 w-6 text-primary mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                        Automated CI/CD Pipelines
                    </li>
                </ul>
            </div>

            <!-- Stats Grid -->
            <div class="w-full lg:w-1/2 grid grid-cols-2 gap-6">
                <div
                    v-for="(stat, index) in stats"
                    :key="index"
                    ref="statsRefs"
                    class="bg-card text-card-foreground p-8 rounded-3xl border border-border flex flex-col items-center justify-center text-center shadow-sm"
                >
                    <span class="text-4xl md:text-5xl font-black text-primary mb-2">
                        {{ stat.prefix }}{{ stat.isFloat ? stat.current.toFixed(2) : Math.round(stat.current) }}{{ stat.suffix }}
                    </span>
                    <span class="text-sm uppercase tracking-widest text-card-foreground/70 font-semibold">{{ stat.label }}</span>
                </div>
            </div>
        </div>
    </section>
</template>
