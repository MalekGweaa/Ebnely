<script setup lang="ts">
import { gsap } from 'gsap';
import { ref, watch, nextTick, onMounted } from 'vue';

const colors = [
    { 
        id: 'primary',
        name: 'Primary Burgundy', 
        hex: '#810B38', 
        class: 'bg-primary',
        usage: 'Used for CTAs, active states, and important actions.'
    },
    { 
        id: 'background',
        name: 'Soft Cream', 
        hex: '#F1E2D1', 
        class: 'bg-background',
        usage: 'Used for overall page backgrounds.'
    },
    { 
        id: 'card',
        name: 'Warm Beige', 
        hex: '#DCC3AA', 
        class: 'bg-card',
        usage: 'Used for cards and elevated surfaces.'
    },
    { 
        id: 'foreground',
        name: 'Dark Maroon', 
        hex: '#541A1A', 
        class: 'bg-foreground',
        usage: 'Used for headings and high-contrast elements.'
    },
];

const selectedColor = ref(colors[0]);
const previewContainerRef = ref<HTMLElement | null>(null);

const triggerHighlightAnimation = () => {
    if (!previewContainerRef.value) {
return;
}

    // First, clear any existing animations
    gsap.killTweensOf('.preview-element');
    
    // Reset all elements to full opacity and scale
    gsap.set('.preview-element', { opacity: 1, scale: 1 });

    // Determine the target class based on the selected color
    let targetClass = '';

    if (selectedColor.value.id === 'primary') {
targetClass = '.preview-primary';
} else if (selectedColor.value.id === 'background') {
targetClass = '.preview-background';
} else if (selectedColor.value.id === 'card') {
targetClass = '.preview-card';
} else if (selectedColor.value.id === 'foreground') {
targetClass = '.preview-foreground';
}

    // Dim non-target elements slightly to create contrast
    gsap.to('.preview-element:not(' + targetClass + ')', {
        opacity: 0.3,
        duration: 0.5,
        ease: 'power2.out'
    });

    // Animate target elements (Pulse/Highlight)
    gsap.fromTo(targetClass, 
        { scale: 0.95 }, 
        { 
            scale: 1.03, 
            opacity: 1,
            duration: 0.3,
            yoyo: true,
            repeat: 1,
            ease: 'power2.out',
            onComplete: () => {
                gsap.to(targetClass, { scale: 1, duration: 0.2 });
            }
        }
    );
};

watch(selectedColor, () => {
    nextTick(() => {
        triggerHighlightAnimation();
    });
});

onMounted(() => {
    // Initial entrance animations for the cards
    gsap.from('.token-card', {
        y: 40,
        opacity: 0,
        stagger: 0.1,
        duration: 0.8,
        ease: 'power3.out',
        scrollTrigger: {
            trigger: '#design-system',
            start: 'top 75%'
        }
    });
    
    // Initial preview entrance
    gsap.from(previewContainerRef.value, {
        x: 40,
        opacity: 0,
        duration: 1,
        delay: 0.3,
        ease: 'power3.out',
        scrollTrigger: {
            trigger: '#design-system',
            start: 'top 75%'
        }
    });
});
</script>

<template>
    <section class="py-32 px-6 bg-secondary text-secondary-foreground" id="design-system">
        <div class="max-w-7xl mx-auto">
            <div class="text-center mb-20">
                <h2 class="text-5xl font-bold mb-6">Live Palette Explorer</h2>
                <p class="text-xl text-secondary-foreground/80 max-w-2xl mx-auto">
                    Experience our meticulously crafted component architecture. See exactly how our design tokens build the interface.
                </p>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-start">
                
                <!-- Left Side: Interactive Token Cards (5 cols) -->
                <div class="lg:col-span-5 flex flex-col gap-4">
                    <button
                        v-for="color in colors"
                        :key="color.id"
                        @click="selectedColor = color"
                        class="token-card group relative overflow-hidden text-left w-full rounded-2xl p-6 transition-all duration-300 border focus:outline-none"
                        :class="selectedColor.id === color.id 
                            ? 'bg-card border-primary/40 shadow-2xl scale-[1.02] ring-2 ring-primary/20' 
                            : 'bg-card/50 border-border shadow-sm hover:bg-card hover:border-primary/20 hover:scale-[1.01] opacity-60 hover:opacity-100'"
                    >
                        <div class="flex items-center gap-6">
                            <!-- Color Swatch -->
                            <div 
                                class="h-16 w-16 shrink-0 rounded-full shadow-inner border border-border/50"
                                :class="color.class"
                            ></div>
                            
                            <!-- Token Info -->
                            <div>
                                <h3 class="text-xl font-bold text-foreground flex items-center gap-2">
                                    {{ color.name }}
                                    <span 
                                        v-if="selectedColor.id === color.id" 
                                        class="inline-flex h-2 w-2 rounded-full bg-primary"
                                    ></span>
                                </h3>
                                <p class="text-sm font-mono text-foreground/60 mb-2">{{ color.hex }}</p>
                                <p class="text-sm text-foreground/80 leading-relaxed">{{ color.usage }}</p>
                            </div>
                        </div>
                    </button>
                </div>

                <!-- Right Side: Live Component Preview (7 cols) -->
                <div class="lg:col-span-7 bg-background rounded-3xl border border-border shadow-2xl overflow-hidden preview-element preview-background relative" ref="previewContainerRef">
                    
                    <!-- MacOS style top bar just for aesthetic -->
                    <div class="bg-card/80 backdrop-blur px-6 py-4 border-b border-border flex items-center gap-2 preview-element preview-card">
                        <div class="h-3 w-3 rounded-full bg-foreground/20"></div>
                        <div class="h-3 w-3 rounded-full bg-foreground/20"></div>
                        <div class="h-3 w-3 rounded-full bg-foreground/20"></div>
                        <div class="ml-4 text-xs font-bold text-foreground/40 tracking-widest uppercase">Live Component Preview</div>
                    </div>

                    <div class="p-8 md:p-12">
                        <!-- Navigation Preview -->
                        <nav class="flex items-center justify-between mb-16">
                            <div class="text-2xl font-bold text-foreground preview-element preview-foreground">
                                <span class="text-primary preview-element preview-primary">A</span>gency.
                            </div>
                            <ul class="flex items-center gap-6 text-sm font-semibold text-foreground/60 preview-element preview-foreground">
                                <li class="text-primary preview-element preview-primary">Home</li>
                                <li>About</li>
                                <li>Services</li>
                            </ul>
                        </nav>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-12">
                            <!-- Typography & Buttons -->
                            <div class="space-y-10">
                                <div class="space-y-4">
                                    <h1 class="text-4xl font-extrabold text-foreground tracking-tight preview-element preview-foreground leading-tight">
                                        Build Faster.
                                    </h1>
                                    <p class="text-foreground/80 leading-relaxed preview-element preview-foreground">
                                        A cohesive design system allows you to scale rapidly without losing brand consistency.
                                    </p>
                                </div>
                                
                                <div class="flex flex-col sm:flex-row items-start sm:items-center gap-4">
                                    <button class="px-6 py-3 rounded-full bg-primary text-primary-foreground font-semibold shadow-lg hover:opacity-90 transition-opacity preview-element preview-primary">
                                        Get Started
                                    </button>
                                    <button class="px-6 py-3 rounded-full bg-card border border-border text-foreground font-semibold hover:bg-card/80 transition-colors preview-element preview-card">
                                        Learn More
                                    </button>
                                </div>
                            </div>

                            <!-- Component Card -->
                            <div>
                                <div class="bg-card rounded-2xl p-6 border border-border shadow-lg flex flex-col h-full preview-element preview-card">
                                    <div class="h-32 rounded-xl bg-background border border-border mb-6 flex items-center justify-center preview-element preview-background overflow-hidden relative">
                                        <!-- Abstract pattern for image placeholder -->
                                        <div class="absolute inset-0 opacity-10 bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI4IiBoZWlnaHQ9IjgiPgo8cmVjdCB3aWR0aD0iOCIgaGVpZ2h0PSI4IiBmaWxsPSIjZmZmIj48L3JlY3Q+CjxwYXRoIGQ9Ik0wIDBMOCA4Wk04IDBMMCA4WiIgc3Ryb2tlPSIjMDAwIiBzdHJva2Utd2lkdGg9IjEiPjwvcGF0aD4KPC9zdmc+')]"></div>
                                        <svg class="h-10 w-10 text-foreground/20 relative z-10" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                        </svg>
                                    </div>
                                    <h3 class="text-xl font-bold text-foreground mb-3 preview-element preview-foreground">Component Card</h3>
                                    <p class="text-sm text-foreground/70 mb-8 flex-grow leading-relaxed preview-element preview-foreground">
                                        Cards group related information in a flexible, highly readable format.
                                    </p>
                                    <div class="w-full py-3 rounded-xl bg-primary/10 text-primary flex items-center justify-center font-bold text-sm preview-element preview-primary hover:bg-primary/20 transition-colors cursor-pointer">
                                        Action
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
