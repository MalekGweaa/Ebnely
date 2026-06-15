<script setup lang="ts">
import { gsap } from 'gsap';
import { onMounted, ref } from 'vue';
import AnimatedGrid from './AnimatedGrid.vue';

const sectionRef = ref<HTMLElement | null>(null);
const projectRefs = ref<HTMLElement[]>([]);

const projects = [
    {
        id: 1,
        title: 'Nexus Financial',
        category: 'Enterprise Fintech Dashboard',
        image: 'images/project1.png',
        tech: ['Vue 3', 'Laravel', 'Tailwind CSS'],
        results: 'Increased transaction speed by 40%',
    },
    {
        id: 2,
        title: 'Lumina Health',
        category: 'Telemedicine Platform',
        image: 'images/lumina-health.jpg',
        tech: ['React', 'Node.js', 'WebRTC'],
        results: 'Connected 10,000+ patients securely',
    },
];

onMounted(() => {
    projectRefs.value.forEach((el, index) => {
        const isEven = index % 2 === 0;
        gsap.from(el, {
            scrollTrigger: {
                trigger: el,
                start: 'top 80%',
            },
            x: isEven ? -50 : 50,
            opacity: 0,
            duration: 1,
            ease: 'power3.out',
        });
    });
});
</script>

<template>
    <section ref="sectionRef" class="py-32 px-6 bg-secondary text-secondary-foreground" id="projects">
        <div class="max-w-7xl mx-auto">
            <div class="mb-24 text-center md:text-left">
                <h2 class="text-5xl font-bold mb-6">Featured Projects</h2>
                <p class="text-xl text-secondary-foreground/80 max-w-2xl">
                    A selection of our most impactful work, demonstrating our engineering and design capabilities.
                </p>
            </div>

            <div class="space-y-32">
                <div
                    v-for="(project, index) in projects"
                    :key="project.id"
                    ref="projectRefs"
                    class="group relative flex flex-col md:flex-row items-center gap-12"
                    :class="{ 'md:flex-row-reverse': index % 2 !== 0 }"
                >
                    <!-- Project Image / Grid -->
                    <div 
                        class="w-full md:w-3/5 overflow-hidden"
                        :class="index === 0 ? '' : 'rounded-3xl shadow-2xl'"
                    >
                        <div class="relative pb-[60%]">
                            <AnimatedGrid v-if="index === 0" />
                            <template v-else>
                                <img
                                    :src="project.image"
                                    :alt="project.title"
                                    class="absolute inset-0 h-full w-full object-cover"
                                />
                            </template>
                        </div>
                    </div>

                    <!-- Project Info -->
                    <div class="w-full md:w-2/5 flex flex-col justify-center">
                        <span class="text-primary font-bold tracking-wider uppercase mb-2">{{ project.category }}</span>
                        <h3 class="text-4xl font-bold mb-6 text-foreground">{{ project.title }}</h3>
                        
                        <div class="space-y-4 mb-8">
                            <div>
                                <h4 class="text-sm text-foreground/50 uppercase tracking-wide mb-1">Technologies</h4>
                                <div class="flex flex-wrap gap-2">
                                    <span
                                        v-for="tech in project.tech"
                                        :key="tech"
                                        class="px-3 py-1 rounded-full bg-background/50 text-foreground text-sm font-medium border border-border"
                                    >
                                        {{ tech }}
                                    </span>
                                </div>
                            </div>
                            <div>
                                <h4 class="text-sm text-foreground/50 uppercase tracking-wide mb-1">Results</h4>
                                <p class="text-lg text-foreground/80 font-medium">{{ project.results }}</p>
                            </div>
                        </div>

                        <a href="#" class="inline-flex items-center text-primary font-bold hover:text-primary/80 transition-colors">
                            View Case Study
                            <svg class="ml-2 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>
