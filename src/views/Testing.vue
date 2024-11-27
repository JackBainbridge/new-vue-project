<script setup>
import { ref } from 'vue'
const testMessage = ref("")
</script>
<template>
  <input v-model="testMessage" placeholder="Edit me." />
  <p>Message is: {{ testMessage }}</p>
</template>