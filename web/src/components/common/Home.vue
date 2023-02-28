<template>
  <FirstPage>
    <template v-slot:welcome>
      <div class="welcome text-h5">Xin chào, {{ userName }}!</div>
    </template>
  </FirstPage>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useStore } from "@/components/store/store";
import FirstPage from "@/components/common/FirstPage";

const userName = ref(localStorage.name);
</script>

<style scoped>
.welcome {
  font-weight: 500;
  margin-left: 20px;
  margin-top: 20px;
}
</style>
