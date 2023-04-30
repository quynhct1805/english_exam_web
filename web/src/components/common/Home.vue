<template>
  <FirstPage>
    <template v-slot:welcome>
      <div style="font-family: 'Lucida Console'" class="welcome text-h5">Xin chào, {{ userName }}!</div>
    </template>
  </FirstPage>
</template>

<script setup>
import { ref } from "vue";
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
