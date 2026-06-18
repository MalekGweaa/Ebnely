<script setup lang="ts">
import { ref, onMounted, onUnmounted, nextTick, watch } from 'vue';
import { gsap } from 'gsap';

const sections = [
    { id: 'home', label: 'Home' },
    { id: 'services', label: 'Services' },
    { id: 'projects', label: 'Projects' },
    { id: 'engineering', label: 'Engineering' },
    { id: 'design-system', label: 'Design' },
    { id: 'creative-lab', label: 'Creative' },
    { id: 'testimonials', label: 'Testimonials' },
    { id: 'contact', label: 'Contact' },
];

const activeTab = ref(sections[0].id);
const navRefs = ref<HTMLElement[]>([]);
const pillStyle = ref<{ width: string; transform: string; opacity: number }>({ width: '0px', transform: 'translateX(0px)', opacity: 0 });

// Mobile menu state
const isMenuOpen = ref(false);
const menuOverlayRef = ref<HTMLElement | null>(null);
const menuItemsRef = ref<HTMLElement[]>([]);
const menuBgRef = ref<HTMLElement | null>(null);

let tl: gsap.core.Timeline | null = null;

const toggleMenu = () => {
    isMenuOpen.value = !isMenuOpen.value;
};

// Handle body scroll
watch(isMenuOpen, (isOpen) => {
    if (isOpen) {
        document.body.style.overflow = 'hidden';
        tl?.play();
    } else {
        document.body.style.overflow = '';
        tl?.reverse();
    }
});

const handleMenuClick = (id: string) => {
    isMenuOpen.value = false; // This triggers the watch which reverses the timeline
    setTimeout(() => {
        scrollTo(id);
    }, 400); // Wait for animation to mostly finish
};

const updatePill = () => {
    const activeIndex = sections.findIndex(s => s.id === activeTab.value);

    if (activeIndex !== -1 && navRefs.value[activeIndex]) {
        const el = navRefs.value[activeIndex];
        pillStyle.value = {
            width: `${el.offsetWidth}px`,
            transform: `translateX(${el.offsetLeft}px)`,
            opacity: 1,
        };
    } else {
        pillStyle.value.opacity = 0;
    }
};

const scrollTo = (id: string) => {
    const element = document.getElementById(id);

    if (element) {
        element.scrollIntoView({ behavior: 'smooth' });
    }
};

let observer: IntersectionObserver;

onMounted(() => {
    observer = new IntersectionObserver((entries) => {
        let hasChanges = false;
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                activeTab.value = entry.target.id;
                hasChanges = true;
            }
        });

        if (hasChanges) {
            nextTick(() => updatePill());
        }
    }, {
        root: null,
        rootMargin: '-40% 0px -60% 0px', 
        threshold: 0
    });

    sections.forEach(section => {
        const el = document.getElementById(section.id);

        if (el) {
            observer.observe(el);
        }
    });

    // Handle initial pill position and window resize
    nextTick(() => updatePill());
    window.addEventListener('resize', updatePill);

    // GSAP Mobile Menu Timeline
    tl = gsap.timeline({ paused: true });
    
    // Background fade
    tl.to(menuBgRef.value, {
        opacity: 1,
        duration: 0.3,
        ease: 'power2.inOut',
    }, 0);
    
    // Panel slide in
    tl.fromTo(menuOverlayRef.value, 
        { x: '100%' },
        {
            x: '0%',
            duration: 0.6,
            ease: 'power4.inOut',
        }, 0
    );
    
    // Stagger items
    tl.fromTo(menuItemsRef.value,
        { y: 30, opacity: 0 },
        {
            y: 0,
            opacity: 1,
            duration: 0.4,
            stagger: 0.05,
            ease: 'power3.out',
        }, 0.3
    );
});

onUnmounted(() => {
    if (observer) {
        observer.disconnect();
    }

    window.removeEventListener('resize', updatePill);
});
</script>

<template>
    <header class="fixed top-0 left-0 right-0 z-50 px-4 py-2 md:py-4 transition-all duration-300 pointer-events-none">
        <div class="pointer-events-auto mx-auto flex max-w-5xl items-center justify-between rounded-full bg-background/80 px-3 py-2 md:px-4 md:py-4 backdrop-blur-md shadow-[0_4px_30px_rgba(0,0,0,0.1)] border border-border/40 relative z-[60]">
            <!-- Logo area -->
            <div class="flex items-center gap-2">
                <a href="#home" @click.prevent="scrollTo('home')" class="font-bold text-lg md:text-xl tracking-tight text-[#541A1A] px-2">
                    <span class="text-primary">E</span>bnely.
                </a>
            </div>

            <!-- Desktop Navigation Tabs -->
            <nav class="relative hidden lg:flex items-center max-w-full overflow-x-auto no-scrollbar scroll-smooth px-2">
                <ul class="relative z-10 flex items-center space-x-1 whitespace-nowrap">
                    <!-- Animated Background Pill -->
                    <div 
                        class="absolute inset-y-1 left-0 rounded-full bg-foreground/10 transition-all duration-300 ease-out z-0 shadow-sm"
                        :style="{
                            width: pillStyle.width,
                            transform: pillStyle.transform,
                            opacity: pillStyle.opacity
                        }"
                    ></div>

                    <li v-for="(section, index) in sections" :key="section.id">
                        <a
                            :ref="el => { if (el) navRefs[index] = el as HTMLElement }"
                            :href="`#${section.id}`"
                            @click.prevent="scrollTo(section.id)"
                            class="relative block px-3 py-1.5 md:px-4 md:py-2 text-sm font-medium transition-colors duration-300"
                            :class="activeTab === section.id ? 'text-foreground font-semibold' : 'text-foreground/70 hover:text-foreground'"
                        >
                            {{ section.label }}
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Desktop CTA -->
            <div class="hidden lg:block">
                 <a href="#contact" @click.prevent="scrollTo('contact')" class="inline-flex items-center justify-center rounded-full bg-primary px-5 py-2 text-sm font-semibold text-primary-foreground transition-transform hover:scale-105 shadow-md">
                    Let's Talk
                 </a>
            </div>
            
            <!-- Mobile Hamburger Menu Button -->
            <div class="block lg:hidden">
                <button @click="toggleMenu" class="p-1.5 md:p-2 text-[#541A1A] focus:outline-none hover:bg-black/5 rounded-full transition-colors" aria-label="Toggle Menu">
                    <svg v-if="!isMenuOpen" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                    </svg>
                    <svg v-else class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
        </div>
        
        <!-- Mobile Menu Overlay -->
        <div class="fixed inset-0 z-50 pointer-events-none" :class="{ 'pointer-events-auto': isMenuOpen }">
            <!-- Backdrop fade -->
            <div ref="menuBgRef" class="absolute inset-0 bg-black/30 backdrop-blur-sm opacity-0" @click="toggleMenu" :class="{ 'hidden': !isMenuOpen && !tl?.isActive() }"></div>
            
            <!-- Slide panel -->
            <div ref="menuOverlayRef" class="absolute inset-y-0 right-0 w-full sm:w-[400px] bg-[#F1E2D1] shadow-2xl flex flex-col justify-center px-12 transform translate-x-full border-l border-[rgba(84,26,26,0.1)]">
                
                <nav class="flex flex-col space-y-8 mt-16">
                    <a
                        v-for="(section, index) in sections"
                        :key="section.id"
                        :href="`#${section.id}`"
                        @click.prevent="handleMenuClick(section.id)"
                        :ref="el => { if (el) menuItemsRef[index] = el as HTMLElement }"
                        class="text-4xl font-bold text-[#541A1A] transition-colors duration-300 hover:text-[#810B38]"
                        :class="activeTab === section.id ? 'text-[#810B38]' : ''"
                    >
                        {{ section.label }}
                    </a>
                </nav>
                
                <div :ref="el => { if (el) menuItemsRef[sections.length] = el as HTMLElement }" class="mt-16 mb-8">
                     <a href="#contact" @click.prevent="handleMenuClick('contact')" class="inline-flex w-full items-center justify-center rounded-full bg-[#810B38] px-8 py-5 text-xl font-bold text-white transition-transform hover:scale-[1.02] shadow-xl">
                        Start A Project
                     </a>
                </div>
            </div>
        </div>
    </header>
</template>
