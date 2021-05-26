<template>
  <confetti />
</template>

<script>
// Async load the Vue 3 APIs we need from the Vue ESM
import { defineComponent } from 'vue';
import Confetti from './components/Confetti.vue';
export default defineComponent({
  components: {
    confetti: Confetti
  }
});
</script>
