<template>
  <AppBar />
  <v-layout>
    <div class="main">
      <DetailDocumentation :id="id" />
    </div>
  </v-layout>
</template>

<script setup>
import AppBar from "@/components/admin/AppBar";
import DetailDocumentation from "../common/DetailDocumentation.vue";

const props = defineProps({
  id: String,
});
</script>

<style scoped></style>
