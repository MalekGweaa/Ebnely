<script setup lang="ts">
import { gsap } from 'gsap';
import { onMounted, ref } from 'vue';

const quoteRef = ref<HTMLElement | null>(null);

onMounted(() => {
    gsap.from(quoteRef.value, {
        scrollTrigger: {
            trigger: quoteRef.value,
            start: 'top 80%',
        },
        y: 40,
        opacity: 0,
        duration: 1,
        ease: 'power2.out',
    });
});
</script>

<template>
    <section class="py-40 px-6 bg-background text-foreground flex items-center justify-center text-center" id="testimonials">
        <div class="max-w-4xl mx-auto" ref="quoteRef">
            <svg class="h-16 w-16 text-primary mx-auto mb-8" fill="currentColor" stroke="currentColor" stroke-width="1" viewBox="0 0 32 32" aria-hidden="true">
                <path d="M9.352 4C4.456 7.456 1 13.12 1 19.36c0 5.088 3.072 8.064 6.624 8.064 3.36 0 5.856-2.688 5.856-5.856 0-3.168-2.208-5.472-5.088-5.472-.576 0-1.344.096-1.536.192.48-3.264 3.552-7.104 6.624-9.024L9.352 4zm16.512 0c-4.8 3.456-8.256 9.12-8.256 15.36 0 5.088 3.072 8.064 6.624 8.064 3.264 0 5.856-2.688 5.856-5.856 0-3.168-2.304-5.472-5.184-5.472-.576 0-1.248.096-1.44.192.48-3.264 3.456-7.104 6.528-9.024L25.864 4z" />
            </svg>
            <blockquote class="text-3xl md:text-5xl font-medium leading-tight mb-12">
                "They didn't just build a website; they transformed our entire digital presence. The quality of engineering and attention to detail is truly world-class."
            </blockquote>
            <cite class="not-italic">
                <div class="font-bold text-xl text-primary">Sarah Jenkins</div>
                <div class="text-foreground/60 text-lg">CTO, Nexus Financial</div>
            </cite>
        </div>
    </section>
</template>
