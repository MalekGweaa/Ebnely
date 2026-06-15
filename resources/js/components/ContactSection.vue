<script setup lang="ts">
// Simple, clean contact section
</script>

<template>
    <section class="py-32 px-6 bg-secondary text-secondary-foreground" id="contact">
        <div class="max-w-4xl mx-auto text-center">
            <h2 class="text-5xl md:text-7xl font-bold mb-8">Ready to elevate your digital presence?</h2>
            <p class="text-xl opacity-80 mb-12 max-w-2xl mx-auto">
                Let's discuss how our engineering and design expertise can help achieve your business goals.
            </p>
            
            <a
                href="mailto:hello@example.com"
                class="inline-flex items-center justify-center px-10 py-5 bg-primary text-primary-foreground font-bold text-xl rounded-full hover:bg-foreground hover:text-background transition-colors duration-300 shadow-xl shadow-primary/20"
            >
                Start the Conversation
            </a>
            
            <div class="mt-20 pt-10 border-t border-border flex flex-col md:flex-row justify-between items-center text-secondary-foreground/60 text-sm">
                <p>&copy; 2026 Ebnely. All rights reserved.</p>
                <div class="flex space-x-6 mt-4 md:mt-0">
                    <a href="#" class="hover:text-primary transition-colors">Twitter</a>
                    <a href="#" class="hover:text-primary transition-colors">LinkedIn</a>
                    <a href="#" class="hover:text-primary transition-colors">GitHub</a>
                </div>
            </div>
        </div>
    </section>
</template>
