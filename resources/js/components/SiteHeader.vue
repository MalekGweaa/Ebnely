<script setup lang="ts">
import { ref, onMounted, onUnmounted, nextTick } from 'vue';

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
        if (el) observer.observe(el);
    });

    // Handle initial pill position and window resize
    nextTick(() => updatePill());
    window.addEventListener('resize', updatePill);
});

onUnmounted(() => {
    if (observer) observer.disconnect();
    window.removeEventListener('resize', updatePill);
});
</script>

<template>
    <header class="fixed top-0 left-0 right-0 z-50 px-4 py-4 transition-all duration-300 pointer-events-none">
        <div class="pointer-events-auto mx-auto flex max-w-5xl items-center justify-between rounded-full bg-background/80 px-4 py-4 backdrop-blur-md shadow-[0_4px_30px_rgba(0,0,0,0.1)] border border-border/40">
            <!-- Logo area -->
            <div class="flex items-center gap-2">
                <a href="#home" @click.prevent="scrollTo('home')" class="font-bold text-xl tracking-tight text-foreground px-2">
                    <span class="text-primary">A</span>gency.
                </a>
            </div>

            <!-- Navigation Tabs -->
            <nav class="relative flex items-center max-w-full overflow-x-auto no-scrollbar scroll-smooth px-2">
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

            <!-- CTA -->
            <div class="hidden md:block">
                 <a href="#contact" @click.prevent="scrollTo('contact')" class="inline-flex items-center justify-center rounded-full bg-primary px-5 py-2 text-sm font-semibold text-primary-foreground transition-transform hover:scale-105 shadow-md">
                    Let's Talk
                 </a>
            </div>
        </div>
    </header>
</template>
