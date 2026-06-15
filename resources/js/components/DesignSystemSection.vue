<script setup lang="ts">
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import { ref, watch, nextTick, onMounted } from 'vue';

gsap.registerPlugin(ScrollTrigger);

const colors = [
    { 
        id: 'primary',
        name: 'Primary Burgundy', 
        hex: '#810B38',
        purpose: 'Signature brand color. Conveys trust, luxury, and decisive action.',
        bgClass: 'bg-primary',
        textClass: 'text-primary',
        contrastText: 'text-primary-foreground',
    },
    { 
        id: 'background',
        name: 'Soft Cream', 
        hex: '#F1E2D1', 
        purpose: 'Primary canvas. Reduces eye strain while maintaining a warm, premium editorial feel.',
        bgClass: 'bg-background',
        textClass: 'text-background',
        contrastText: 'text-foreground',
    },
    { 
        id: 'card',
        name: 'Warm Beige', 
        hex: '#DCC3AA', 
        purpose: 'Elevated surfaces. Provides subtle depth and visual hierarchy without harsh lines.',
        bgClass: 'bg-card',
        textClass: 'text-card',
        contrastText: 'text-foreground',
    },
    { 
        id: 'foreground',
        name: 'Dark Maroon', 
        hex: '#541A1A', 
        purpose: 'Typography and high-contrast accents. Ensures AA accessibility with softer contrast than pure black.',
        bgClass: 'bg-foreground',
        textClass: 'text-foreground',
        contrastText: 'text-background',
    },
];

const selectedColor = ref(colors[0]);

// Refs for GSAP
const sectionRef = ref<HTMLElement | null>(null);
const headerRefs = ref<HTMLElement[]>([]);
const swatchRefs = ref<HTMLElement[]>([]);
const panelRef = ref<HTMLElement | null>(null);

// Right Panel Inner Refs
const panelContentRef = ref<HTMLElement | null>(null);

watch(selectedColor, (newVal, oldVal) => {
    if (newVal.id === oldVal.id) return;
    
    // Smooth transition for the panel content when color changes
    if (panelContentRef.value) {
        gsap.fromTo(panelContentRef.value, 
            { opacity: 0.5, scale: 0.98 }, 
            { opacity: 1, scale: 1, duration: 0.6, ease: 'power2.out' }
        );
    }
});

onMounted(() => {
    nextTick(() => {
        requestAnimationFrame(() => {
            // Entrance animations
            
            // Header
            gsap.from(headerRefs.value, {
                y: 30,
                opacity: 0,
                duration: 0.8,
                stagger: 0.1,
                ease: 'power3.out',
                scrollTrigger: {
                    trigger: sectionRef.value,
                    start: 'top 80%',
                }
            });

            // Swatches
            gsap.from(swatchRefs.value, {
                x: -30,
                opacity: 0,
                duration: 0.8,
                stagger: 0.1,
                ease: 'power3.out',
                scrollTrigger: {
                    trigger: sectionRef.value,
                    start: 'top 75%',
                }
            });

            // Right Panel
            gsap.from(panelRef.value, {
                y: 50,
                opacity: 0,
                duration: 1,
                ease: 'power3.out',
                scrollTrigger: {
                    trigger: sectionRef.value,
                    start: 'top 70%',
                }
            });
            
            // Refresh ScrollTrigger to ensure correct calculations after DOM updates
            ScrollTrigger.refresh();
        });
    });
});
</script>

<template>
    <section ref="sectionRef" class="py-32 px-6 bg-secondary text-secondary-foreground" id="design-system">
        <div class="max-w-7xl mx-auto">
            <div class="mb-24 md:w-2/3">
                <h2 :ref="el => { if (el) headerRefs[0] = el as HTMLElement }" class="text-5xl lg:text-6xl font-bold mb-6 tracking-tight text-foreground">
                    Design DNA
                </h2>
                <p :ref="el => { if (el) headerRefs[1] = el as HTMLElement }" class="text-2xl text-foreground/80 font-light leading-relaxed">
                    Every exceptional digital experience starts with a carefully crafted visual language.
                </p>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-start">
                
                <!-- Left Side: Interactive Swatches -->
                <div class="flex flex-col gap-6">
                    <button
                        v-for="(color, index) in colors"
                        :key="color.id"
                        :ref="el => { if (el) swatchRefs[index] = el as HTMLElement }"
                        @click="selectedColor = color"
                        class="group relative w-full text-left rounded-3xl p-8 transition-all duration-500 overflow-hidden border focus:outline-none"
                        :class="selectedColor.id === color.id 
                            ? 'bg-card border-border shadow-[0_8px_30px_rgba(0,0,0,0.12)] ring-1 ring-border/50 scale-[1.02]' 
                            : 'bg-card/40 border-transparent hover:bg-card/70 hover:border-border/40 shadow-sm'"
                    >
                        <div class="flex flex-col sm:flex-row sm:items-start gap-8">
                            <!-- Large Color Circle -->
                            <div 
                                class="h-24 w-24 shrink-0 rounded-full shadow-inner border border-foreground/10 transition-transform duration-500"
                                :class="[color.bgClass, selectedColor.id === color.id ? 'scale-110' : 'group-hover:scale-105']"
                            ></div>
                            
                            <!-- Content -->
                            <div class="flex-1 pt-2">
                                <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-4 sm:mb-2 gap-2">
                                    <h3 class="text-2xl font-bold text-foreground">{{ color.name }}</h3>
                                    <span class="font-mono text-sm tracking-wider text-foreground/50 uppercase bg-foreground/5 px-3 py-1 rounded-full">{{ color.hex }}</span>
                                </div>
                                <p class="text-lg text-foreground/70 leading-relaxed font-light">
                                    {{ color.purpose }}
                                </p>
                            </div>
                        </div>
                    </button>
                </div>

                <!-- Right Side: Editorial Showcase Panel (macOS Window) -->
                <div 
                    ref="panelRef"
                    class="rounded-3xl border shadow-2xl transition-colors duration-700 ease-in-out relative overflow-hidden flex flex-col"
                    :class="[selectedColor.bgClass, selectedColor.id === 'background' || selectedColor.id === 'card' ? 'border-border' : 'border-transparent']"
                >
                    <!-- macOS top bar -->
                    <div class="px-6 py-4 flex items-center gap-2 border-b transition-colors duration-700 backdrop-blur-sm z-20"
                         :class="selectedColor.id === 'primary' || selectedColor.id === 'foreground' ? 'border-white/10 bg-white/5' : 'border-foreground/10 bg-card/50'">
                        <div class="flex gap-2">
                            <div class="h-3.5 w-3.5 rounded-full bg-[#FF5F56] border border-[#E0443E]"></div>
                            <div class="h-3.5 w-3.5 rounded-full bg-[#FFBD2E] border border-[#DEA123]"></div>
                            <div class="h-3.5 w-3.5 rounded-full bg-[#27C93F] border border-[#1AAB29]"></div>
                        </div>
                        <div class="ml-4 text-xs font-bold tracking-widest uppercase transition-colors duration-700"
                             :class="selectedColor.contrastText" :style="{ opacity: 0.5 }">
                            Live Showcase
                        </div>
                    </div>

                    <!-- Panel Content -->
                    <div class="p-10 sm:p-12 lg:p-16 relative flex-grow">
                        <!-- Decorative subtle background pattern/gradient based on color -->
                        <div class="absolute top-0 right-0 w-64 h-64 bg-white opacity-[0.03] rounded-full blur-3xl -translate-y-1/2 translate-x-1/4"></div>
                        
                        <div ref="panelContentRef" class="relative z-10 flex flex-col h-full min-h-[450px]">
                        <!-- Top Tag -->
                        <div class="mb-16">
                            <span 
                                class="inline-block px-4 py-1.5 rounded-full text-xs font-bold tracking-widest uppercase transition-colors duration-700"
                                :class="selectedColor.id === 'primary' || selectedColor.id === 'foreground' ? 'bg-white/20 text-white' : 'bg-foreground/10 text-foreground'"
                            >
                                Brand Guideline
                            </span>
                        </div>

                        <!-- Editorial Typography -->
                        <div class="flex-grow space-y-8">
                            <h3 
                                class="text-5xl sm:text-6xl font-extrabold tracking-tighter leading-[1.05] transition-colors duration-700"
                                :class="selectedColor.contrastText"
                            >
                                Visual<br/>Hierarchy.
                            </h3>
                            
                            <p 
                                class="text-xl sm:text-2xl font-light leading-relaxed max-w-md transition-colors duration-700"
                                :class="selectedColor.contrastText"
                                :style="{ opacity: 0.85 }"
                            >
                                Consistent application of color defines relationships and guides the user's eye naturally through the digital landscape.
                            </p>
                        </div>

                        <!-- Bottom Elements -->
                        <div class="mt-20 pt-10 border-t transition-colors duration-700 flex flex-col sm:flex-row sm:justify-between sm:items-end gap-8"
                             :class="selectedColor.id === 'primary' || selectedColor.id === 'foreground' ? 'border-white/20' : 'border-foreground/10'">
                            <div class="space-y-3">
                                <div class="text-sm font-bold uppercase tracking-widest transition-colors duration-700" :class="selectedColor.contrastText" :style="{ opacity: 0.6 }">Token Identity</div>
                                <div class="text-2xl font-mono transition-colors duration-700" :class="selectedColor.contrastText">{{ selectedColor.name }}</div>
                            </div>
                            
                            <!-- Abstract composition of shapes -->
                            <div class="flex gap-4 items-end">
                                <div class="w-16 h-16 rounded-full transition-colors duration-700" :class="selectedColor.id === 'primary' ? 'bg-background' : 'bg-primary'"></div>
                                <div class="w-12 h-12 rounded-full transition-colors duration-700 opacity-50" :class="selectedColor.id === 'card' ? 'bg-foreground' : 'bg-card'"></div>
                                <div class="w-8 h-8 rounded-full transition-colors duration-700" :class="selectedColor.id === 'foreground' ? 'bg-background' : 'bg-foreground'"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </section>
</template>
