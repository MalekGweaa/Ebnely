<script setup lang="ts">
import { gsap } from 'gsap';
import { onMounted, ref } from 'vue';

const gridRef = ref<HTMLElement | null>(null);
const blocksRef = ref<HTMLElement[]>([]);

const cols = 12;
const rows = 8;
const totalBlocks = cols * rows;

const colors = [
    'bg-primary', 
    'bg-foreground', 
    'bg-card', 
    'bg-background',
    'bg-[#541A1A]', // Dark red/brown
    'bg-[#DCC3AA]'  // Tan
];

const blocks = Array.from({ length: totalBlocks }).map((_, i) => {
    // 25% chance to be an empty space to match the pattern in the screenshot
    const isVisible = Math.random() > 0.25;
    const color = colors[Math.floor(Math.random() * colors.length)];

    return { id: i, isVisible, color };
});

onMounted(() => {
    // Initial reveal animation
    gsap.fromTo(blocksRef.value, 
        { scale: 0, opacity: 0 },
        {
            scale: 1,
            opacity: (index) => blocks[index].isVisible ? 1 : 0,
            duration: 1.2,
            stagger: {
                each: 0.02,
                from: "random",
                grid: [rows, cols]
            },
            ease: "back.out(1.5)"
        }
    );

    // Continuous pulsing animation
    blocksRef.value.forEach((block, index) => {
        if (blocks[index].isVisible) {
            gsap.to(block, {
                opacity: 0.5 + Math.random() * 0.5,
                scale: 0.85 + Math.random() * 0.15,
                duration: 1.5 + Math.random() * 2,
                repeat: -1,
                yoyo: true,
                ease: "sine.inOut",
                delay: Math.random() * 2
            });
        }
    });
});
</script>

<template>
    <div 
        ref="gridRef" 
        class="absolute inset-0 w-full h-full p-4 md:p-8 grid gap-3 md:gap-4" 
        :style="{ gridTemplateColumns: `repeat(${cols}, minmax(0, 1fr))`, gridTemplateRows: `repeat(${rows}, minmax(0, 1fr))` }"
    >
        <div
            v-for="block in blocks"
            :key="block.id"
            ref="blocksRef"
            class="rounded-md md:rounded-xl w-full h-full shadow-sm"
            :class="[block.isVisible ? block.color : 'bg-transparent', 'opacity-0']"
        ></div>
    </div>
</template>
