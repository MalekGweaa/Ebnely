<script setup lang="ts">
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import { onMounted, ref } from 'vue';

gsap.registerPlugin(ScrollTrigger);

const sectionRef = ref<HTMLElement | null>(null);
const authorRef = ref<HTMLElement | null>(null);

const line1 = '“Where design excellence';
const line2 = 'meets engineering precision.”';

const displayedLine1 = ref('');
const displayedLine2 = ref('');
const isTyping = ref(false);

const typeText = async (text: string, displayedRef: any) => {
    for (let i = 0; i <= text.length; i++) {
        displayedRef.value = text.slice(0, i);
        
        // Add natural pauses after specific punctuation (commas, periods, quotes)
        const lastChar = text[i - 1];
        let delay = 25; // default typing speed (20-30ms per character)
        if (lastChar === ',' || lastChar === '،') {
            delay = 300; // pause for comma
        } else if (lastChar === '.' || lastChar === '”' || lastChar === '’') {
            delay = 500; // pause for period or quotes
        }
        
        await new Promise(resolve => setTimeout(resolve, delay));
    }
};

const startAnimation = async () => {
    isTyping.value = true;
    isTyping.value = true;
    
    // Small initial delay before typing starts
    await new Promise(resolve => setTimeout(resolve, 200));
    
    // 2. Type line 1 character-by-character
    await typeText(line1, displayedLine1);
    
    // Small pause between lines
    await new Promise(resolve => setTimeout(resolve, 150));
    
    // Type line 2 character-by-character
    await typeText(line2, displayedLine2);
    
    isTyping.value = false;

    // 3. Author block reveal: opacity 0 -> 1, y 20 -> 0
    gsap.fromTo(authorRef.value,
        { opacity: 0, y: 20 },
        { opacity: 1, y: 0, duration: 0.8, ease: 'power3.out' }
    );
};

onMounted(() => {
    // ScrollTrigger to trigger typing when entering viewport
    ScrollTrigger.create({
        trigger: sectionRef.value,
        start: 'top 60%',
        once: true,
        onEnter: () => {
            startAnimation();
        }
    });
});
</script>

<template>
    <section ref="sectionRef" class="relative w-full min-h-[100dvh] flex items-center justify-center text-center overflow-hidden px-4 md:px-6" style="background-color: #541A1A;" id="testimonials">
        <div class="mx-auto flex flex-col items-center justify-center w-[90%] md:w-full max-w-5xl">
            <!-- Typewriter Quote Block -->
            <blockquote class="text-center mb-10 flex flex-col justify-center items-center select-none w-full" style="color: #F1E2D1; font-size: clamp(2rem, 7vw, 4rem); line-height: 1.05; font-weight: 500; letter-spacing: -0.04em;">
                <span class="inline-block relative">
                    {{ displayedLine1 }}<span v-if="isTyping && displayedLine2 === ''" class="inline-block w-[2px] h-[1em] bg-current ml-1 animate-pulse align-middle"></span>
                </span>
                <br class="hidden md:block" />
                <span class="inline-block relative">
                    {{ displayedLine2 }}<span v-if="isTyping && displayedLine2 !== ''" class="inline-block w-[2px] h-[1em] bg-current ml-1 animate-pulse align-middle"></span>
                </span>
            </blockquote>

            <!-- Author Block -->
            <cite ref="authorRef" class="not-italic flex flex-col items-center opacity-0" style="transform: translateY(20px);">
                <div class="font-bold text-lg md:text-xl mb-1" style="color: #F1E2D1;">Sarah Jenkins</div>
                <div class="text-base md:text-lg font-light tracking-wide" style="color: rgba(241,226,209,0.75);">CTO · Nexus Financial</div>
            </cite>
        </div>
    </section>
</template>
