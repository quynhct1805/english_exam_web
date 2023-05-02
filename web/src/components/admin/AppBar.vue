<template>
  <AppBar>
    <template v-slot:admin-management>
      <v-list-item v-for="(page, idx) in managementPages" :key="idx" :value="page" :to="{ name: `${page.page}` }">
        <v-list-item-title>{{ page.label }}</v-list-item-title>
      </v-list-item>
    </template>
  </AppBar>
</template>

<script setup>
import { ref } from "vue";
import AppBar from "@/components/common/AppBar";

const managementPages = ref([
  {
    page: "ManageUser",
    label: "Quản lý người dùng",
  },
  {
    page: "ManageCategory",
    label: "Quản lý thể loại",
  },
]);
</script>

<style scoped></style>
