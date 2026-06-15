<script setup lang="ts">
import { gsap } from 'gsap';
import { onMounted, ref } from 'vue';

const sectionRef = ref<HTMLElement | null>(null);
const headingRef = ref<HTMLElement | null>(null);
const descRef = ref<HTMLElement | null>(null);
const cardsRef = ref<HTMLElement[]>([]);
const imageContainerRef = ref<HTMLElement | null>(null);
const imageRef = ref<HTMLElement | null>(null);

const services = [
    {
        title: 'Web Development',
        description: 'Build faster, scale confidently, and deliver exceptional digital experiences.',
        icon: 'M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4',
    },
    {
        title: 'Enterprise Solutions',
        description: 'Streamline operations with secure, scalable systems designed for long-term growth.',
        icon: 'M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4',
    },
    {
        title: 'UI/UX Design',
        description: 'Create intuitive user experiences that improve engagement, usability, and customer satisfaction.',
        icon: 'M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01',
    },
    {
        title: 'Digital Products',
        description: 'Transform ideas into successful digital products from concept to launch.',
        icon: 'M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z',
    },
];

onMounted(() => {
    // Heading reveal
    gsap.from(headingRef.value, {
        scrollTrigger: {
            trigger: sectionRef.value,
            start: 'top 75%',
        },
        y: 40,
        opacity: 0,
        duration: 0.8,
        ease: 'power3.out',
    });

    // Description fade in
    gsap.from(descRef.value, {
        scrollTrigger: {
            trigger: sectionRef.value,
            start: 'top 75%',
        },
        opacity: 0,
        duration: 0.8,
        delay: 0.3,
        ease: 'power2.out',
    });

    // Service cards staggered reveal
    gsap.from(cardsRef.value, {
        scrollTrigger: {
            trigger: sectionRef.value,
            start: 'top 65%',
        },
        y: 50,
        opacity: 0,
        duration: 0.7,
        stagger: 0.15,
        ease: 'power3.out',
    });

    // Image scale from 0.95 to 1
    gsap.from(imageRef.value, {
        scrollTrigger: {
            trigger: imageContainerRef.value,
            start: 'top 70%',
        },
        scale: 0.95,
        opacity: 0,
        duration: 1.2,
        ease: 'power2.out',
    });
});
</script>

<template>
    <section ref="sectionRef" class="py-32 px-6 bg-primary text-primary-foreground" id="services">
        <div class="max-w-7xl mx-auto flex flex-col lg:flex-row gap-20 items-stretch">
            
            <!-- Content Half -->
            <div class="w-full lg:w-1/2">
                <div class="mb-20">
                    <div ref="headingRef" class="overflow-hidden">
                        <h2 class="text-5xl lg:text-6xl font-bold mb-4 leading-tight">Focus On Growing Your Business.</h2>
                        <h3 class="text-3xl lg:text-4xl font-light text-[#DCC3AA] mb-8">We'll Handle The Technology.</h3>
                    </div>
                    <p ref="descRef" class="text-xl leading-relaxed text-[#F1E2D1]/90 max-w-lg font-light tracking-wide">
                        From planning and design to development, deployment, and ongoing support, we manage every step of the digital process so you can focus on customers, growth, and business success.
                    </p>
                </div>

                <div class="grid grid-cols-1 gap-8">
                    <div
                        v-for="(service, index) in services"
                        :key="index"
                        :ref="el => { if (el) cardsRef[index] = el as HTMLElement }"
                    >
                        <div
                            class="group p-10 rounded-2xl transition-all duration-500 hover:-translate-y-1 h-full shadow-[0_4px_20px_rgba(0,0,0,0.05)] hover:shadow-[0_12px_30px_rgba(0,0,0,0.15)] border border-transparent hover:border-[#DCC3AA]/20"
                            style="background-color: #F1E2D1; color: #541A1A;"
                        >
                            <div class="flex items-center gap-6 mb-5">
                                <div class="inline-flex h-14 w-14 items-center justify-center rounded-xl transition-colors duration-500 group-hover:bg-[#541A1A] group-hover:text-[#F1E2D1]"
                                     style="background-color: rgba(84, 26, 26, 0.08); color: #541A1A;">
                                    <svg class="h-6 w-6 stroke-[1.5]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" :d="service.icon" />
                                    </svg>
                                </div>
                                <h3 class="text-2xl font-bold tracking-tight">{{ service.title }}</h3>
                            </div>
                            <p class="text-lg leading-relaxed opacity-85 font-medium">
                                {{ service.description }}
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Image Half -->
            <div class="w-full lg:w-1/2 relative" ref="imageContainerRef">
                <div class="relative rounded-2xl overflow-hidden h-full shadow-[0_20px_40px_rgba(0,0,0,0.2)]">
                    <img 
                        ref="imageRef"
                        src="/images/chair.jpg" 
                        alt="Comfortable seating symbolizing peace of mind" 
                        class="absolute inset-0 w-full h-full object-cover object-left transform-origin-center"
                    />
                </div>
            </div>

        </div>
    </section>
</template>
