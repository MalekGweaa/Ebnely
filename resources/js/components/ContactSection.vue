<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

const sectionRef = ref<HTMLElement | null>(null);
const headlineRef = ref<HTMLElement | null>(null);
const descRef = ref<HTMLElement | null>(null);
const btn1Ref = ref<HTMLElement | null>(null);
const btn2Ref = ref<HTMLElement | null>(null);
const socialRowRef = ref<HTMLElement | null>(null);
const sigRef = ref<HTMLElement | null>(null);
const footerRef = ref<HTMLElement | null>(null);

const socialLinks = [
    { name: 'WhatsApp', href: '#', icon: '<path stroke-linecap="round" stroke-linejoin="round" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />' },
    { name: 'LinkedIn', href: '#', icon: '<path stroke-linecap="round" stroke-linejoin="round" d="M16 8a6 6 0 016 6v7h-4v-7a2 2 0 00-2-2 2 2 0 00-2 2v7h-4v-7a6 6 0 016-6zM2 9h4v12H2z" /><circle cx="4" cy="4" r="2" />' },
    { name: 'GitHub', href: '#', icon: '<path stroke-linecap="round" stroke-linejoin="round" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" />' },
    { name: 'Facebook', href: '#', icon: '<path stroke-linecap="round" stroke-linejoin="round" d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3z" />' },
    { name: 'Email', href: 'mailto:hello@ebnely.com', icon: '<path stroke-linecap="round" stroke-linejoin="round" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />' },
];

onMounted(() => {
    const tl = gsap.timeline({
        scrollTrigger: {
            trigger: sectionRef.value,
            start: "top 75%",
            once: true
        }
    });

    tl.fromTo(headlineRef.value, 
        { opacity: 0, y: 30 },
        { opacity: 1, y: 0, duration: 0.8, ease: "power3.out" }
    )
    .fromTo(descRef.value,
        { opacity: 0 },
        { opacity: 1, duration: 0.6, ease: "power2.out" },
        "-=0.4"
    )
    .fromTo([btn1Ref.value, btn2Ref.value],
        { opacity: 0, y: 15 },
        { opacity: 1, y: 0, duration: 0.6, stagger: 0.1, ease: "power2.out" },
        "-=0.4"
    )
    .fromTo(socialRowRef.value,
        { opacity: 0, y: 15 },
        { opacity: 1, y: 0, duration: 0.6, ease: "power2.out" },
        "-=0.2"
    )
    .fromTo(sigRef.value,
        { opacity: 0 },
        { opacity: 1, duration: 0.8, ease: "power2.out" },
        "-=0.2"
    )
    .fromTo(footerRef.value,
        { opacity: 0 },
        { opacity: 1, duration: 0.6, ease: "power2.out" },
        "-=0.2"
    );
});
</script>

<template>
    <section ref="sectionRef" class="pt-[140px] lg:pt-[180px] pb-8 px-6 lg:px-12 min-h-screen min-h-dvh flex flex-col" style="background-color: #541A1A; color: #F1E2D1;" id="contact">
        <div class="max-w-[1400px] mx-auto w-full flex-grow flex flex-col justify-center">
            
            <!-- Main CTA Area -->
            <div class="max-w-[1200px] mx-auto text-center relative z-10 mb-20">
                
                <h2 ref="headlineRef" class="text-4xl md:text-5xl lg:text-7xl font-bold tracking-tight mb-8 leading-[1.05]" style="color: #F1E2D1;">
                    Let's Create Something <br class="hidden md:block"/>Worth Remembering.
                </h2>
                
                <p ref="descRef" class="text-lg md:text-xl opacity-80 mb-12 max-w-2xl mx-auto leading-relaxed" style="color: #F1E2D1;">
                    Let's discuss your next idea, product, or digital platform. 
                    From strategy and design to development and launch, every detail is crafted with precision.
                </p>
                
                <div class="flex flex-col sm:flex-row justify-center items-center gap-4 mb-16">
                    <a ref="btn1Ref" href="#" class="w-full sm:w-auto inline-flex items-center justify-center px-10 py-4 font-bold text-lg rounded-full transition-colors duration-300 shadow-xl hover:opacity-90" style="background-color: #F1E2D1; color: #541A1A;">
                        Chat on WhatsApp
                    </a>
                    <a ref="btn2Ref" href="#" class="w-full sm:w-auto inline-flex items-center justify-center px-10 py-4 bg-transparent border-2 border-[#F1E2D1]/30 text-[#F1E2D1] font-bold text-lg rounded-full transition-all duration-300 ease-out hover:bg-[#F1E2D1] hover:text-[#810B38] hover:border-[#810B38]">
                        Explore My Work
                    </a>
                </div>
                
                <!-- Minimalist Social Connection Area -->
                <div ref="socialRowRef" class="flex flex-wrap items-center justify-center gap-x-6 gap-y-4 text-sm md:text-base font-medium opacity-80" style="color: #F1E2D1;">
                    <template v-for="(link, index) in socialLinks" :key="link.name">
                        <a :href="link.href" class="group relative flex items-center gap-2 hover:-translate-y-1 transition-all duration-300">
                            <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" v-html="link.icon"></svg>
                            <span>{{ link.name }}</span>
                            <span class="absolute -bottom-1 left-0 w-full h-px bg-current scale-x-0 origin-right group-hover:scale-x-100 group-hover:origin-left transition-transform duration-300"></span>
                        </a>
                        <span v-if="index < socialLinks.length - 1" class="opacity-30 select-none hidden sm:inline">&bull;</span>
                    </template>
                </div>
                
            </div>
            
            <!-- Agency Signature Block -->
            <div ref="sigRef" class="text-center mb-8" style="color: #F1E2D1;">
                <h3 class="text-2xl font-bold tracking-[0.3em] uppercase mb-3">EBNELY</h3>
                <p class="text-sm opacity-50 tracking-wide">Digital Experiences Crafted With Precision.</p>
            </div>
            
            <!-- Footer Redesign -->
            <div ref="footerRef" class="border-t border-[#F1E2D1]/10 pt-8 flex flex-col md:flex-row justify-between items-center gap-6 text-sm opacity-60">
                <p class="text-center md:text-left leading-relaxed">
                    &copy; 2026 Ebenly.<br class="md:hidden" />
                    Designed, Developed & Crafted by Abdulmalek Gweaa.
                </p>
                <div class="flex flex-wrap justify-center md:justify-end gap-x-6 gap-y-3 font-medium">
                    <a href="#" class="hover:text-primary transition-colors">WhatsApp</a>
                    <a href="#" class="hover:text-primary transition-colors">LinkedIn</a>
                    <a href="#" class="hover:text-primary transition-colors">GitHub</a>
                    <a href="#" class="hover:text-primary transition-colors">Facebook</a>
                </div>
            </div>
            
        </div>
    </section>
</template>
