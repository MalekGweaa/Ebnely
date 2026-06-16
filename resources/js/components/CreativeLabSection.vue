<script setup lang="ts">
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import { onMounted, onUnmounted, ref, computed, nextTick } from 'vue';

gsap.registerPlugin(ScrollTrigger);

// 1. Data Structure
const concepts = [
    { 
        id: 'micro', 
        number: '01', 
        title: 'Micro Interactions', 
        desc: 'Subtle, tactile feedback that brings interfaces to life.', 
        icon: 'M13 10V3L4 14h7v7l9-11h-7z', // Lightning
        bgClass: 'bg-primary text-primary-foreground',
        env: 'particles'
    },
    { 
        id: 'coding', 
        number: '02', 
        title: 'Creative Coding', 
        desc: 'Code as an expressive medium for generative aesthetics.', 
        icon: 'M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4', // Code
        bgClass: 'bg-secondary text-secondary-foreground',
        env: 'geometry'
    },
    { 
        id: 'motion', 
        number: '03', 
        title: 'Motion Systems', 
        desc: 'Physics-based kinetic layouts that flow naturally.', 
        icon: 'M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15', // Grid/Refresh
        bgClass: 'bg-card text-foreground',
        env: 'grid'
    },
    { 
        id: 'story', 
        number: '04', 
        title: 'Interactive Storytelling', 
        desc: 'Immersive narrative journeys driven by user exploration.', 
        icon: 'M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253', // Book
        bgClass: 'bg-primary text-primary-foreground',
        env: 'lines'
    },
    { 
        id: 'premium', 
        number: '05', 
        title: 'Premium Transitions', 
        desc: 'Seamless visual continuity across digital touchpoints.', 
        icon: 'M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4', // Switch arrows
        bgClass: 'bg-secondary text-secondary-foreground',
        env: 'gradient'
    }
];

const activeIndex = ref(0);
const activeConcept = computed(() => concepts[activeIndex.value]);

// 2. Refs
const containerRef = ref<HTMLElement | null>(null);
const parallaxWrapperRef = ref<HTMLElement | null>(null);
const cardsContainerRef = ref<HTMLElement | null>(null);
const cardRefs = ref<HTMLElement[]>([]);
const titleRef = ref<HTMLElement | null>(null);
const numberRef = ref<HTMLElement | null>(null);

// 3. Animation State
let throwIndex = 0;
let autoPlayTimer: any = null;
let isAnimating = true; // Lock until initial reveal finishes

// 4. Methods
const getRelPos = (i: number) => (i - activeIndex.value + concepts.length) % concepts.length;

const startAutoPlay = () => {
    clearTimeout(autoPlayTimer);
    autoPlayTimer = setTimeout(() => {
        nextCard(true);
    }, 12000); 
};

const pauseAutoPlay = () => {
    clearTimeout(autoPlayTimer);
};

const handleInteraction = () => {
    if (isAnimating) return;
    startAutoPlay();
};

const handleCardClick = (clickedIndex: number) => {
    if (isAnimating) return;
    if (getRelPos(clickedIndex) !== 0) return; // Only click front card
    
    handleInteraction();
    nextCard(false);
};

const nextCard = (isAuto = false) => {
    if (isAnimating) return;
    isAnimating = true;
    
    const throwType = throwIndex % 5;
    throwIndex++;
    
    const oldFrontIndex = activeIndex.value;
    activeIndex.value = (activeIndex.value + 1) % concepts.length;
    
    const durationMultiplier = isAuto ? 1.4 : 1.0;
    
    animateCardOut(oldFrontIndex, throwType, durationMultiplier);
    layoutCards(true, durationMultiplier);
    animateText(durationMultiplier);
    
    if (isAuto) startAutoPlay();
    
    setTimeout(() => {
        isAnimating = false;
    }, 800 * durationMultiplier);
};

const animateText = (durationMultiplier: number) => {
    if (titleRef.value && numberRef.value) {
        const tl = gsap.timeline();
        tl.to([numberRef.value, titleRef.value], {
            y: -15, opacity: 0, duration: 0.3 * durationMultiplier, ease: 'power2.in', stagger: 0.05, overwrite: 'auto'
        }).set([numberRef.value, titleRef.value], {
            y: 15
        }).to([numberRef.value, titleRef.value], {
            y: 0, opacity: 1, duration: 0.4 * durationMultiplier, ease: 'power2.out', stagger: 0.05, overwrite: 'auto'
        });
    }
};

const animateCardOut = (index: number, throwType: number, durationMultiplier: number) => {
    const card = cardRefs.value[index];
    if (!card) return;
    
    gsap.killTweensOf(card);
    const tl = gsap.timeline();
    let vars: any = { duration: 0.6 * durationMultiplier, ease: 'power3.in', opacity: 0, overwrite: 'auto' };
    
    switch(throwType) {
        case 0: vars.x = 250; vars.y = -50; vars.rotation = 15; break; 
        case 1: vars.x = -250; vars.y = -50; vars.rotation = -15; break; 
        case 2: vars.y = -350; vars.rotation = 0; break; 
        case 3: vars.x = 200; vars.y = -250; vars.rotation = 25; break; 
        case 4: vars.y = 200; vars.scale = 0.5; vars.rotation = -10; break; 
    }
    
    tl.set(card, { zIndex: 50 })
      .to(card, vars)
      .set(card, { x: 0, y: -165, scale: 0.85, rotation: 0, rotationY: 0, zIndex: 0, opacity: 0 });
};

const layoutCards = (animate = true, durationMultiplier = 1.0) => {
    concepts.forEach((concept, i) => {
        const card = cardRefs.value[i];
        if (!card) return;
        
        const relPos = getRelPos(i);
        
        // Skip the card that just flew out
        if (animate && relPos === concepts.length - 1) return;
        
        let yPos, scaleVal, zIndexVal, opacityVal;
        
        // Stronger Visible Deck Depth
        if (relPos === 0) {
            yPos = 0; scaleVal = 1; zIndexVal = 30; opacityVal = 1;
        } else if (relPos === 1) {
            yPos = -55; scaleVal = 0.95; zIndexVal = 20; opacityVal = 1;
        } else if (relPos === 2) {
            yPos = -110; scaleVal = 0.90; zIndexVal = 10; opacityVal = 1;
        } else {
            yPos = -165; scaleVal = 0.85; zIndexVal = 0; opacityVal = 0;
        }
        
        if (animate) {
            gsap.killTweensOf(card);
            gsap.set(card, { zIndex: zIndexVal });
            gsap.to(card, {
                y: yPos, scale: scaleVal, opacity: opacityVal,
                x: 0, rotation: 0, rotationY: 0,
                duration: 0.7 * durationMultiplier, ease: 'expo.out',
                overwrite: 'auto'
            });
        } else {
            gsap.set(card, { y: yPos, scale: scaleVal, zIndex: zIndexVal, opacity: opacityVal, x: 0, rotation: 0, rotationY: 0 });
        }
    });
};

const triggerRevealAnimation = () => {
    // Hide initially with random rotations
    gsap.set(cardRefs.value, { opacity: 0, scale: 0.92, y: 40, rotation: () => (Math.random() * 8) - 4 });
    
    const tl = gsap.timeline({
        onComplete: () => {
            // Interactive card hint
            gsap.to(cardRefs.value[activeIndex.value], {
                rotation: 2, y: -4, duration: 0.4, ease: 'power2.out',
                yoyo: true, repeat: 1,
                onComplete: () => {
                    isAnimating = false;
                    startAutoPlay();
                }
            });
        }
    });

    const indices = [4, 3, 2, 1, 0]; // Assemble from back to front
    
    indices.forEach((idx, step) => {
        const card = cardRefs.value[idx];
        if (!card) return;
        
        const relPos = getRelPos(idx);
        let yPos, scaleVal, zIndexVal;
        
        if (relPos === 0) {
            yPos = 0; scaleVal = 1; zIndexVal = 30;
        } else if (relPos === 1) {
            yPos = -55; scaleVal = 0.95; zIndexVal = 20;
        } else if (relPos === 2) {
            yPos = -110; scaleVal = 0.90; zIndexVal = 10;
        } else {
            yPos = -165; scaleVal = 0.85; zIndexVal = 0;
        }
        
        gsap.set(card, { zIndex: zIndexVal });
        tl.to(card, {
            opacity: (relPos > 2 ? 0 : 1),
            y: yPos,
            scale: scaleVal,
            rotation: 0, // Settle to 0
            duration: 0.8,
            ease: 'power3.out'
        }, step * 0.15);
    });
};

// 5. Lifecycle
onMounted(() => {
    nextTick(() => {
        ScrollTrigger.create({
            trigger: containerRef.value,
            start: "top 60%",
            once: true,
            onEnter: () => {
                triggerRevealAnimation();
            }
        });
    });
    
    // Isolated Parallax
    const handleMouseMove = (e: MouseEvent) => {
        handleInteraction();
        if (isAnimating || !parallaxWrapperRef.value) return; // Completely disable during transitions
        
        const x = (e.clientX / window.innerWidth - 0.5) * 30;
        const y = (e.clientY / window.innerHeight - 0.5) * 30;

        gsap.to(parallaxWrapperRef.value, {
            x: x, y: y, rotationY: x * 0.2, rotationX: -y * 0.2,
            duration: 1, ease: 'power2.out', overwrite: 'auto'
        });
    };
    
    containerRef.value?.addEventListener('mousemove', handleMouseMove);
});

onUnmounted(() => {
    pauseAutoPlay();
});

</script>

<template>
    <section ref="containerRef" class="relative py-32 lg:py-48 px-6 bg-background text-foreground overflow-hidden" id="creative-lab">
        
        <!-- Dynamic Environment Backgrounds -->
        <div class="absolute inset-0 pointer-events-none transition-opacity duration-1000" :class="activeConcept.env === 'particles' ? 'opacity-100' : 'opacity-0'">
            <div class="absolute top-1/4 left-1/4 w-32 h-32 bg-primary/20 rounded-full blur-3xl animate-pulse"></div>
            <div class="absolute bottom-1/4 right-1/4 w-48 h-48 bg-secondary/20 rounded-full blur-3xl animate-pulse" style="animation-delay: 1s"></div>
            <div class="absolute top-1/2 right-1/3 w-20 h-20 bg-primary/10 rounded-full blur-2xl animate-bounce"></div>
        </div>
        
        <div class="absolute inset-0 pointer-events-none transition-opacity duration-1000 flex items-center justify-center" :class="activeConcept.env === 'geometry' ? 'opacity-100' : 'opacity-0'">
            <svg class="w-full h-full opacity-5" viewBox="0 0 100 100" preserveAspectRatio="none">
                <polygon points="50,10 90,90 10,90" fill="currentColor" class="animate-spin-slow origin-center" />
                <rect x="25" y="25" width="50" height="50" fill="none" stroke="currentColor" stroke-width="0.5" class="animate-ping opacity-20" />
            </svg>
        </div>

        <div class="absolute inset-0 pointer-events-none transition-opacity duration-1000" :class="activeConcept.env === 'grid' ? 'opacity-100' : 'opacity-0'">
            <svg class="w-full h-full opacity-10" fill="none">
                <defs>
                    <pattern id="motion-grid" width="60" height="60" patternUnits="userSpaceOnUse">
                        <path d="M 60 0 L 0 0 0 60" fill="none" stroke="currentColor" stroke-width="1" />
                    </pattern>
                </defs>
                <rect width="100%" height="100%" fill="url(#motion-grid)" class="animate-pan-grid" />
            </svg>
        </div>

        <div class="absolute inset-0 pointer-events-none transition-opacity duration-1000 flex items-center justify-center" :class="activeConcept.env === 'lines' ? 'opacity-100' : 'opacity-0'">
            <svg class="w-[150%] h-[150%] opacity-10 animate-wave origin-center" viewBox="0 0 100 100" preserveAspectRatio="none">
                <path d="M0,50 Q25,25 50,50 T100,50" fill="none" stroke="currentColor" stroke-width="0.5" />
                <path d="M0,60 Q25,35 50,60 T100,60" fill="none" stroke="currentColor" stroke-width="0.3" />
            </svg>
        </div>

        <div class="absolute inset-0 pointer-events-none transition-opacity duration-1000" :class="activeConcept.env === 'gradient' ? 'opacity-100' : 'opacity-0'">
            <div class="absolute inset-0 bg-gradient-to-br from-primary/5 via-transparent to-secondary/10 animate-gradient-shift"></div>
        </div>
        <!-- End Backgrounds -->


        <div class="max-w-7xl mx-auto relative z-10 flex flex-col lg:flex-row items-center justify-between gap-16 lg:gap-24">
            
            <!-- Left Side: Progress & Text -->
            <div class="flex-1 text-left flex flex-col justify-center max-w-xl z-20">
                <span class="text-primary font-bold tracking-[0.2em] uppercase mb-8 flex items-center gap-4">
                    <span class="w-10 h-px bg-primary"></span>
                    Creative Laboratory
                </span>
                
                <h2 class="text-5xl lg:text-7xl font-bold mb-8 leading-[1.05] tracking-tight">
                    Pushing the boundaries<br/>of digital interaction.
                </h2>
                
                <p class="text-2xl font-light opacity-80 mb-16 leading-relaxed max-w-lg">
                    A living showcase of motion design and frontend craftsmanship. Click the deck to explore.
                </p>

                <!-- Enhanced Progress Feedback -->
                <div class="mt-4 border-t border-foreground/10 pt-8">
                    <div class="flex items-center gap-6 mb-3">
                        <div class="text-sm font-mono font-bold tracking-widest text-primary/70 overflow-hidden h-6 flex items-center">
                            <span ref="numberRef" class="inline-block">{{ activeConcept.number }} / 05</span>
                        </div>
                    </div>
                    <div class="overflow-hidden h-12 flex items-center">
                        <h3 ref="titleRef" class="text-3xl font-bold tracking-tight inline-block">{{ activeConcept.title }}</h3>
                    </div>
                </div>
            </div>

            <!-- Right Side: Interactive Deck -->
            <div class="flex-1 w-full flex justify-center lg:justify-end perspective-1000 relative h-[480px]">
                
                <!-- Dedicated Parallax Wrapper -->
                <div ref="parallaxWrapperRef" class="w-full max-w-[380px] h-full" style="transform-style: preserve-3d;">
                    <div ref="cardsContainerRef" class="relative w-full h-full" style="transform-style: preserve-3d;">
                        
                        <div
                            v-for="(concept, i) in concepts"
                            :key="concept.id"
                            :ref="el => { if (el) cardRefs[i] = el as HTMLElement }"
                            class="absolute top-0 left-0 w-full h-[460px] group"
                            :class="getRelPos(i) === 0 ? 'cursor-pointer pointer-events-auto' : 'pointer-events-none'"
                            @click="handleCardClick(i)"
                        >
                            <div 
                                class="relative w-full h-full rounded-[32px] shadow-[0_15px_40px_rgba(0,0,0,0.1)] pt-6 pb-10 px-8 flex flex-col justify-between border border-white/10 overflow-hidden transition-all duration-500 ease-out pointer-events-none"
                                :class="[
                                    concept.bgClass, 
                                    getRelPos(i) === 0 ? 'group-hover:scale-[1.03] group-hover:-translate-y-2 group-hover:shadow-[0_40px_80px_rgba(0,0,0,0.3)] ring-1 ring-white/20' : ''
                                ]"
                            >
                                <!-- Decorative layer opacity reduction for depth (content remains opaque) -->
                                <div class="absolute inset-0 bg-black transition-opacity duration-700 pointer-events-none rounded-[32px]" :class="getRelPos(i) > 0 ? 'opacity-20' : 'opacity-0'"></div>
                                
                                <div class="relative z-10 flex justify-between items-start">
                                    <div class="w-16 h-16 rounded-full bg-white/15 backdrop-blur-md flex items-center justify-center shadow-inner">
                                        <svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                            <path stroke-linecap="round" stroke-linejoin="round" :d="concept.icon" />
                                        </svg>
                                    </div>
                                    <span class="font-mono text-base font-bold opacity-70">{{ concept.number }}</span>
                                </div>
                                
                                <div class="relative z-10 flex flex-col h-full justify-end">
                                    <div>
                                        <h3 class="text-4xl font-bold mb-4 leading-[1.1] tracking-tight">{{ concept.title }}</h3>
                                        <p class="text-lg opacity-85 leading-relaxed font-medium">
                                            {{ concept.desc }}
                                        </p>
                                    </div>
                                    
                                    <!-- Interactive Hint -->
                                    <div 
                                        class="mt-8 flex items-center gap-3 text-sm font-bold tracking-widest uppercase transition-opacity duration-500"
                                        :class="getRelPos(i) === 0 ? 'opacity-90' : 'opacity-0'"
                                    >
                                        <span>Click to Explore</span>
                                        <svg class="w-5 h-5 animate-hint-bounce" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                                        </svg>
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
.perspective-1000 {
    perspective: 1000px;
}
.animate-spin-slow {
    animation: spin 30s linear infinite;
}
.animate-pan-grid {
    animation: panGrid 15s linear infinite;
}
@keyframes panGrid {
    0% { transform: translateY(0); }
    100% { transform: translateY(60px); }
}
.animate-wave {
    animation: wave 12s ease-in-out infinite alternate;
}
@keyframes wave {
    0% { transform: rotate(-5deg) scale(1); }
    100% { transform: rotate(5deg) scale(1.1); }
}
.animate-gradient-shift {
    background-size: 200% 200%;
    animation: gradientShift 15s ease infinite alternate;
}
@keyframes gradientShift {
    0% { background-position: 0% 50%; }
    100% { background-position: 100% 50%; }
}
.animate-hint-bounce {
    animation: hintBounce 1.5s ease-in-out infinite;
}
@keyframes hintBounce {
    0%, 100% {
        transform: translateX(0);
        opacity: 0.5;
    }
    50% {
        transform: translateX(6px);
        opacity: 1;
    }
}
</style>
