<script setup lang="ts">
import { Head } from '@inertiajs/vue3';
import ContactSection from '@/components/ContactSection.vue';
import CreativeLabSection from '@/components/CreativeLabSection.vue';
import DesignSystemSection from '@/components/DesignSystemSection.vue';
import EngineeringSection from '@/components/EngineeringSection.vue';
import HeroSection from '@/components/HeroSection.vue';
import ProjectsSection from '@/components/ProjectsSection.vue';
import ServicesSection from '@/components/ServicesSection.vue';
import TestimonialsSection from '@/components/TestimonialsSection.vue';
import SiteHeader from '@/components/SiteHeader.vue';
import BackToTop from '@/components/BackToTop.vue';
</script>

<template>
    <Head title="Premium Digital Agency" />
    
    <div class="min-h-screen bg-background text-foreground antialiased selection:bg-primary selection:text-primary-foreground font-sans">
        <SiteHeader />
        <HeroSection />
        <ServicesSection />
        <ProjectsSection />
        <EngineeringSection />
        <DesignSystemSection />
        <CreativeLabSection />
        <TestimonialsSection />
        <ContactSection />
        <BackToTop />
    </div>
</template>

<style>
/* Smooth scrolling behavior for anchor links */
html {
    scroll-behavior: smooth;
}

/* Base instrument sans font configuration is handled via Tailwind */
</style>
