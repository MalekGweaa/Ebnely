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
        purpose: 'Bold Luxury Presentation. High-contrast signature canvas expressing heritage and authority.',
        bgClass: 'bg-primary',
        textClass: 'text-primary',
        contrastText: 'text-primary-foreground',
    },
    { 
        id: 'background',
        name: 'Soft Cream', 
        hex: '#F1E2D1', 
        purpose: 'Light Editorial Presentation. Warm, minimalist canvas emphasizing whitespace and delicate structure.',
        bgClass: 'bg-background',
        textClass: 'text-background',
        contrastText: 'text-foreground',
    },
];

const selectedColor = ref(colors[0]);

// Refs for GSAP
const sectionRef = ref<HTMLElement | null>(null);
const titleRef = ref<HTMLElement | null>(null);
const descRef = ref<HTMLElement | null>(null);
const swatchRefs = ref<HTMLElement[]>([]);
const panelRef = ref<HTMLElement | null>(null);

// Themes values mapping
const themes = {
    primary: {
        background: '#810B38',
        text: '#F1E2D1',
        textMuted: 'rgba(241, 226, 209, 0.75)',
        button: '#F1E2D1',
        buttonText: '#810B38',
        border: 'rgba(241, 226, 209, 0.15)',
        card: '#F1E2D1',
        cardText: '#541A1A',
        cardTextMuted: 'rgba(84, 26, 26, 0.75)',
        cardBorder: 'rgba(84, 26, 26, 0.08)',
        cardButton: '#810B38',
        cardButtonText: '#F1E2D1',
        accent: '#810B38',
        glow: 'rgba(255, 255, 255, 0.1)',
    },
    background: {
        background: '#F1E2D1',
        text: '#541A1A',
        textMuted: '#6B5A4A',
        button: '#810B38',
        buttonText: '#F1E2D1',
        border: 'rgba(84, 26, 26, 0.08)',
        card: '#FFFFFF',
        cardText: '#541A1A',
        cardTextMuted: 'rgba(84, 26, 26, 0.75)',
        cardBorder: 'rgba(84, 26, 26, 0.08)',
        cardButton: '#810B38',
        cardButtonText: '#F1E2D1',
        accent: '#810B38',
        glow: 'rgba(84, 26, 26, 0.1)',
    }
};

watch(selectedColor, (newVal) => {
    const theme = themes[newVal.id as keyof typeof themes];
    if (!theme || !sectionRef.value) return;
    
    // Transition theme variables dynamically on the root section element
    gsap.to(sectionRef.value, {
        '--theme-bg': theme.background,
        '--theme-text': theme.text,
        '--theme-text-muted': theme.textMuted,
        '--theme-button': theme.button,
        '--theme-button-text': theme.buttonText,
        '--theme-border': theme.border,
        '--theme-card': theme.card,
        '--theme-card-text': theme.cardText,
        '--theme-card-text-muted': theme.cardTextMuted,
        '--theme-card-border': theme.cardBorder,
        '--theme-card-button': theme.cardButton,
        '--theme-card-button-text': theme.cardButtonText,
        '--theme-accent': theme.accent,
        '--theme-glow': theme.glow,
        duration: 0.8,
        ease: 'power2.out'
    });
});

onMounted(() => {
    // Set initial theme values immediately on the root section element
    const initTheme = themes[selectedColor.value.id as keyof typeof themes];
    if (sectionRef.value && initTheme) {
        gsap.set(sectionRef.value, {
            '--theme-bg': initTheme.background,
            '--theme-text': initTheme.text,
            '--theme-text-muted': initTheme.textMuted,
            '--theme-button': initTheme.button,
            '--theme-button-text': initTheme.buttonText,
            '--theme-border': initTheme.border,
            '--theme-card': initTheme.card,
            '--theme-card-text': initTheme.cardText,
            '--theme-card-text-muted': initTheme.cardTextMuted,
            '--theme-card-border': initTheme.cardBorder,
            '--theme-card-button': initTheme.cardButton,
            '--theme-card-button-text': initTheme.cardButtonText,
            '--theme-accent': initTheme.accent,
            '--theme-glow': initTheme.glow,
        });
    }

    nextTick(() => {
        requestAnimationFrame(() => {
            // Header elements entrance
            const headerElements = [titleRef.value, descRef.value].filter(Boolean);
            if (headerElements.length > 0) {
                gsap.from(headerElements, {
                    y: 30,
                    opacity: 0,
                    duration: 0.8,
                    stagger: 0.15,
                    ease: 'power3.out',
                    scrollTrigger: {
                        trigger: sectionRef.value,
                        start: 'top 85%',
                    }
                });
            }

            // Swatches (Left cards) entrance
            if (swatchRefs.value && swatchRefs.value.length > 0) {
                const validSwatches = swatchRefs.value.filter(Boolean);
                gsap.from(validSwatches, {
                    x: -30,
                    opacity: 0,
                    duration: 0.8,
                    stagger: 0.1,
                    ease: 'power3.out',
                    scrollTrigger: {
                        trigger: sectionRef.value,
                        start: 'top 80%',
                    }
                });
            }

            // Right Panel (macOS Window) entrance
            if (panelRef.value) {
                gsap.from(panelRef.value, {
                    y: 50,
                    opacity: 0,
                    duration: 1,
                    ease: 'power3.out',
                    scrollTrigger: {
                        trigger: sectionRef.value,
                        start: 'top 75%',
                    }
                });
            }
            
            ScrollTrigger.refresh();
        });
    });
});
</script>

<template>
    <section 
        ref="sectionRef" 
        class="theme-container py-32 px-6 relative overflow-hidden border-t border-b" 
        style="background-color: var(--theme-bg); border-color: var(--theme-border);"
        id="design-system"
    >
        <!-- Section-Wide Floating Background Elements (react to theme) -->
        <div class="absolute top-1/4 left-10 w-96 h-96 rounded-full blur-3xl opacity-15 pointer-events-none" style="background-color: var(--theme-accent);"></div>
        <div class="absolute bottom-1/4 right-10 w-[450px] h-[450px] rounded-full blur-3xl opacity-10 pointer-events-none" style="background-color: var(--theme-button);"></div>
        
        <!-- Section-Wide Ambient Grid Overlay -->
        <div class="absolute inset-0 opacity-10 pointer-events-none">
            <svg class="w-full h-full" fill="none">
                <defs>
                    <pattern id="section-grid" width="60" height="60" patternUnits="userSpaceOnUse">
                        <path d="M 60 0 L 0 0 0 60" fill="none" stroke="var(--theme-border)" stroke-width="0.5" />
                    </pattern>
                </defs>
                <rect width="100%" height="100%" fill="url(#section-grid)" />
            </svg>
        </div>

        <div class="max-w-7xl mx-auto relative z-10">
            <!-- Section Header (Adapts to Active Theme Colors) -->
            <div class="mb-20 md:w-2/3">
                <h2 ref="titleRef" class="text-5xl lg:text-6xl font-bold mb-6 tracking-tight theme-text">
                    Design DNA
                </h2>
                <p ref="descRef" class="text-2xl font-light leading-relaxed theme-text-muted">
                    Every exceptional digital experience starts with a carefully crafted visual language.
                </p>
            </div>

            <!-- Theme Engine Content Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-[1fr_1.1fr] gap-12 items-stretch">
                
                <!-- Left Side: Interactive Token Cards -->
                <div class="flex flex-col gap-5 justify-center">
                    <button
                        v-for="color in colors"
                        :key="color.id"
                        ref="swatchRefs"
                        @click="selectedColor = color"
                        class="token-card group relative w-full text-left p-7 focus:outline-none flex cursor-pointer overflow-hidden"
                        :class="{ 'active': selectedColor.id === color.id }"
                    >
                        <!-- Left Accent Indicator Bar -->
                        <div 
                            class="absolute left-0 top-0 bottom-0 w-1.5 transition-transform duration-500 origin-top"
                            :style="{
                                backgroundColor: 'var(--theme-accent)',
                                transform: selectedColor.id === color.id ? 'scaleY(1)' : 'scaleY(0)'
                            }"
                        ></div>
                        
                        <div class="flex flex-col sm:flex-row sm:items-start gap-6 relative z-10 w-full">
                            <!-- Color Circle (Always shows the token's specific color) -->
                            <div 
                                class="h-20 w-20 shrink-0 rounded-full shadow-inner border border-black/10 transition-transform duration-500"
                                :style="{ backgroundColor: color.hex }"
                                :class="[selectedColor.id === color.id ? 'scale-110' : 'group-hover:scale-105']"
                            ></div>
                            
                            <!-- Content -->
                            <div class="flex-1 pt-1">
                                <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 gap-2">
                                    <h3 class="text-xl font-bold theme-card-text leading-none">{{ color.name }}</h3>
                                    <span 
                                        class="font-mono text-xs tracking-wider uppercase px-3 py-1 rounded-full text-center"
                                        style="background-color: var(--theme-bg); color: var(--theme-text)"
                                    >
                                        {{ color.hex }}
                                    </span>
                                </div>
                                <p class="text-base leading-relaxed font-light theme-card-text-muted">
                                    {{ color.purpose }}
                                </p>
                            </div>
                        </div>
                    </button>
                </div>

                <!-- Right Side: High-Fidelity macOS Preview Window -->
                <div 
                    ref="panelRef"
                    class="preview-window flex flex-col overflow-hidden relative min-h-[560px]"
                >
                    <!-- macOS title bar with gradient sheen -->
                    <div 
                        class="h-12 flex items-center justify-center relative z-20 border-b shrink-0"
                        style="background-color: var(--theme-bg); border-color: var(--theme-border);"
                    >
                        <!-- Subtle metallic gradient sheen -->
                        <div class="absolute inset-0 bg-gradient-to-b from-white/10 to-transparent pointer-events-none"></div>
                        
                        <!-- Traffic Lights -->
                        <div class="flex gap-2 absolute left-4">
                            <div class="h-3 w-3 rounded-full bg-[#FF5F56] border border-black/15 shadow-sm"></div>
                            <div class="h-3 w-3 rounded-full bg-[#FFBD2E] border border-black/15 shadow-sm"></div>
                            <div class="h-3 w-3 rounded-full bg-[#27C93F] border border-black/15 shadow-sm"></div>
                        </div>
                        
                        <!-- Title -->
                        <div class="text-[10px] font-mono font-bold tracking-[0.25em] uppercase theme-text opacity-70">
                            Ebnely Engine - Live Studio
                        </div>
                    </div>

                    <!-- Panel Content Area -->
                    <div class="relative flex-grow flex flex-col justify-between p-8 sm:p-10 overflow-hidden">
                        
                        <!-- Floating Background Elements inside Mockup (react to theme) -->
                        <div class="absolute -top-16 -right-16 w-40 h-40 rounded-full blur-3xl opacity-20 pointer-events-none" style="background-color: var(--theme-accent);"></div>
                        <div class="absolute -bottom-20 -left-12 w-48 h-48 rounded-full blur-3xl opacity-25 pointer-events-none" style="background-color: var(--theme-button);"></div>
                        
                        <!-- Subtle Background Grid Pattern inside Mockup -->
                        <svg class="absolute inset-0 w-full h-full opacity-10 pointer-events-none" fill="none">
                            <defs>
                                <pattern id="preview-grid" width="24" height="24" patternUnits="userSpaceOnUse">
                                    <path d="M 24 0 L 0 0 0 24" fill="none" stroke="var(--theme-accent)" stroke-width="0.75" />
                                </pattern>
                            </defs>
                            <rect width="100%" height="100%" fill="url(#preview-grid)" />
                        </svg>

                        <!-- Mockup Header -->
                        <div class="flex justify-between items-center relative z-10 mb-8 shrink-0">
                            <div class="text-2xl font-black tracking-tighter theme-text">
                                Ebnely.
                            </div>
                            <div class="hidden sm:flex gap-6 text-sm font-semibold theme-text">
                                <span class="border-b-2 pb-0.5" style="border-color: var(--theme-accent)">Dashboard</span>
                                <span class="opacity-70 hover:opacity-100 cursor-pointer transition-opacity">Work</span>
                                <span class="opacity-70 hover:opacity-100 cursor-pointer transition-opacity">System</span>
                            </div>
                        </div>

                        <!-- Mockup Content Grid -->
                        <div class="grid grid-cols-1 xl:grid-cols-[1.1fr_0.9fr] gap-8 items-center flex-grow relative z-10">
                            
                            <!-- Hero Block (Left Column) -->
                            <div class="space-y-6">
                                <!-- Live Mode Badge -->
                                <div 
                                    class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[10px] font-bold tracking-wider uppercase"
                                    style="background-color: var(--theme-accent); color: var(--theme-bg)"
                                >
                                    <span class="w-1.5 h-1.5 rounded-full" style="background-color: var(--theme-button)"></span>
                                    Adaptive System
                                </div>
                                
                                <h3 class="text-3xl sm:text-4xl lg:text-5xl font-extrabold tracking-tight theme-text leading-[1.1]">
                                    Build Faster.
                                </h3>
                                <p class="text-base leading-relaxed theme-text-muted max-w-sm">
                                    A cohesive design system allows you to scale rapidly without losing brand consistency. Watch every element adapt instantly.
                                </p>
                                
                                <!-- Dynamic CTA Buttons -->
                                <div class="flex flex-wrap gap-3 pt-2">
                                    <button class="theme-button-primary px-6 py-3 rounded-full text-sm font-bold shadow-md">
                                        Get Started
                                    </button>
                                    <button class="theme-button-secondary px-6 py-3 rounded-full text-sm font-bold shadow-sm">
                                        Learn More
                                    </button>
                                </div>
                            </div>

                            <!-- Component Card & Interactive Controls (Right Column) -->
                            <div class="space-y-5">
                                <!-- Mockup Card -->
                                <div class="theme-card-inner p-5 shadow-lg relative overflow-hidden group/card" style="background-color: var(--theme-card); border-color: var(--theme-card-border);">
                                    <!-- Image / Canvas Overlay Placeholder -->
                                    <div class="w-full aspect-[16/10] rounded-xl mb-4 flex items-center justify-center relative overflow-hidden bg-black/10 dark:bg-white/5">
                                        <!-- Interactive dots grid -->
                                        <svg class="absolute inset-0 w-full h-full opacity-20" fill="none">
                                            <defs>
                                                <pattern id="card-dot-grid" width="12" height="12" patternUnits="userSpaceOnUse">
                                                    <circle cx="2" cy="2" r="1.5" fill="var(--theme-accent)" />
                                                </pattern>
                                            </defs>
                                            <rect width="100%" height="100%" fill="url(#card-dot-grid)" />
                                        </svg>
                                        
                                        <!-- Gradient overlay -->
                                        <div class="absolute inset-0 image-overlay mix-blend-multiply opacity-25"></div>
                                        <div class="absolute inset-0 bg-gradient-to-tr from-black/20 via-transparent to-white/10 pointer-events-none"></div>
                                        
                                        <svg class="w-10 h-10 relative z-10 transition-transform duration-500 group-hover/card:scale-110" style="color: var(--theme-accent);" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                                        </svg>
                                    </div>
                                    
                                    <h4 class="text-base font-bold theme-card-text mb-1">Interactive Card</h4>
                                    <p class="text-xs theme-card-text-muted leading-relaxed mb-4">
                                        Cards group related information in a cohesive, responsive container.
                                    </p>
                                    
                                    <button class="w-full py-2.5 rounded-lg text-xs font-bold theme-card-button-primary shadow-sm">
                                        Action Trigger
                                    </button>
                                </div>

                                <!-- Dynamic Interactive Widgets (Slider & Toggle) -->
                                <div class="theme-card-inner p-4 shadow-md space-y-4" style="background-color: var(--theme-card); border-color: var(--theme-card-border);">
                                    <!-- Slider -->
                                    <div class="space-y-1.5">
                                        <div class="flex justify-between text-[11px] font-bold uppercase tracking-wider theme-card-text opacity-70">
                                            <span>Dynamic Contrast</span>
                                            <span>85%</span>
                                        </div>
                                        <div class="h-2 w-full rounded-full relative overflow-hidden" style="background-color: var(--theme-card-border)">
                                            <div class="h-full absolute left-0 top-0 rounded-full" style="width: 85%; background-color: var(--theme-card-button)"></div>
                                        </div>
                                    </div>
                                    
                                    <!-- Switch -->
                                    <div class="flex items-center justify-between">
                                        <span class="text-[11px] font-bold uppercase tracking-wider theme-card-text opacity-70">Live Synchronization</span>
                                        <div 
                                            class="w-9 h-5 rounded-full p-0.5 cursor-pointer flex items-center justify-end" 
                                            style="background-color: var(--theme-card-button)"
                                        >
                                            <div 
                                                class="w-3 h-3 rounded-full shadow-sm"
                                                style="background-color: var(--theme-card)"
                                            ></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<style scoped>
.theme-container {
    /* Safe CSS variables default fallback */
    --theme-bg: #810B38;
    --theme-text: #F1E2D1;
    --theme-text-muted: rgba(241, 226, 209, 0.75);
    --theme-button: #F1E2D1;
    --theme-button-text: #810B38;
    --theme-border: rgba(241, 226, 209, 0.15);
    --theme-card: #F1E2D1;
    --theme-card-text: #541A1A;
    --theme-card-text-muted: rgba(84, 26, 26, 0.75);
    --theme-card-border: rgba(84, 26, 26, 0.08);
    --theme-card-button: #810B38;
    --theme-card-button-text: #F1E2D1;
    --theme-accent: #810B38;
    --theme-glow: rgba(255, 255, 255, 0.1);
}

.token-card {
    background-color: var(--theme-card);
    border: 2px solid var(--theme-card-border);
    border-radius: 1rem;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
    transform: scale(1);
    z-index: 1;
    transition: 
        transform 0.4s cubic-bezier(0.16, 1, 0.3, 1),
        box-shadow 0.4s cubic-bezier(0.16, 1, 0.3, 1),
        border-color 0.4s ease,
        background-color 0.4s ease,
        color 0.4s ease;
}

.token-card.active {
    transform: scale(1.02);
    border-color: var(--theme-accent);
    box-shadow: 
        0 12px 30px -10px rgba(0, 0, 0, 0.15),
        0 4px 12px -4px rgba(0, 0, 0, 0.1);
    z-index: 10;
}

.token-card:not(.active):hover {
    transform: scale(1.01);
    box-shadow: 
        0 12px 24px -10px rgba(0, 0, 0, 0.08);
}

.preview-window {
    background-color: var(--theme-bg);
    border: 1px solid var(--theme-border);
    border-radius: 1rem;
    box-shadow: 
        0 30px 60px -15px rgba(0, 0, 0, 0.2),
        inset 0 1px 0 rgba(255, 255, 255, 0.08);
}

.theme-text {
    color: var(--theme-text);
}

.theme-text-muted {
    color: var(--theme-text-muted);
}

.theme-card-text {
    color: var(--theme-card-text);
}

.theme-card-text-muted {
    color: var(--theme-card-text-muted);
}

.theme-button-primary {
    background-color: var(--theme-button);
    color: var(--theme-button-text);
    transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.theme-button-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px -6px rgba(0, 0, 0, 0.12);
}

.theme-button-secondary {
    border: 1px solid var(--theme-border);
    color: var(--theme-text);
    background-color: rgba(255, 255, 255, 0.05);
    transition: 
        transform 0.3s cubic-bezier(0.16, 1, 0.3, 1),
        background-color 0.3s ease;
}

.theme-button-secondary:hover {
    transform: translateY(-2px);
    background-color: rgba(255, 255, 255, 0.1);
}

.theme-card-button-primary {
    background-color: var(--theme-card-button);
    color: var(--theme-card-button-text);
    transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.theme-card-button-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px -6px rgba(0, 0, 0, 0.08);
}

.theme-card-inner {
    background-color: var(--theme-card);
    border: 1px solid var(--theme-card-border);
    border-radius: 1rem;
}

.image-overlay {
    background: linear-gradient(135deg, var(--theme-accent) 0%, var(--theme-button) 100%);
}
</style>
