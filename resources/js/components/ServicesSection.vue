<script setup lang="ts">
import { gsap } from 'gsap';
import { onMounted, ref } from 'vue';

const sectionRef = ref<HTMLElement | null>(null);
const cardsRef = ref<HTMLElement[]>([]);

const services = [
    {
        title: 'Web Development',
        description: 'High-performance, scalable, and modern web applications built with the latest technologies.',
        icon: 'M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4',
    },
    {
        title: 'Enterprise Solutions',
        description: 'Robust architectures and bespoke software solutions designed for enterprise-scale operations.',
        icon: 'M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4',
    },
    {
        title: 'UI/UX Design',
        description: 'Beautiful, intuitive, and user-centric interfaces that drive engagement and conversions.',
        icon: 'M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01',
    },
    {
        title: 'Digital Products',
        description: 'End-to-end product development from conceptualization to launch and continuous iteration.',
        icon: 'M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z',
    },
];

onMounted(() => {
    gsap.from(cardsRef.value, {
        scrollTrigger: {
            trigger: sectionRef.value,
            start: 'top 75%',
        },
        y: 60,
        opacity: 0,
        duration: 0.6,
        stagger: 0.1,
        ease: 'power3.out',
    });
});
</script>

<template>
    <section ref="sectionRef" class="py-32 px-6 bg-primary text-primary-foreground" id="services">
        <div class="max-w-7xl mx-auto flex flex-col lg:flex-row gap-16 items-center">
            
            <!-- Content Half -->
            <div class="w-full lg:w-1/2">
                <div class="mb-16">
                    <h2 class="text-5xl font-bold mb-6">Our Expertise</h2>
                    <p class="text-xl text-primary-foreground/80">
                        We combine strategic thinking with technical excellence to deliver exceptional results.
                    </p>
                </div>

                <div class="grid grid-cols-1 gap-6">
                    <div
                        v-for="(service, index) in services"
                        :key="index"
                        :ref="el => { if (el) cardsRef[index] = el as HTMLElement }"
                    >
                        <div
                            class="group p-8 rounded-3xl shadow-xl transition-all duration-300 hover:-translate-y-2 hover:shadow-2xl h-full"
                            style="background-color: #F1E2D1; color: #541A1A;"
                        >
                            <div class="flex items-center gap-6 mb-4">
                                <div class="inline-flex h-14 w-14 items-center justify-center rounded-2xl transition-colors group-hover:bg-[#541A1A] group-hover:text-[#F1E2D1]"
                                     style="background-color: rgba(84, 26, 26, 0.1); color: #541A1A;">
                                    <svg class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" :d="service.icon" />
                                    </svg>
                                </div>
                                <h3 class="text-2xl font-semibold">{{ service.title }}</h3>
                            </div>
                            <p class="text-lg leading-relaxed opacity-80">
                                {{ service.description }}
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Image Half -->
            <div class="w-full lg:w-1/2">
                <div class="relative rounded-3xl overflow-hidden shadow-2xl h-[800px]">
                    <img 
                        src="/images/chair.jpg" 
                        alt="Interior Design" 
                        class="absolute inset-0 w-full h-full object-cover hover:scale-105 transition-transform duration-700"
                    />
                </div>
            </div>

        </div>
    </section>
</template>
