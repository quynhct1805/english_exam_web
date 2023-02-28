<template>
  <v-navigation-drawer permanent location="left" v-model="hideNav">
    <v-divider></v-divider>

    <v-list density="compact" nav>
      <v-list-item
        prepend-icon="mdi-home-outline"
        value="home"
        :to="{ name: 'ListBooks' }"
      >
        Trang chủ
      </v-list-item>
      <v-list-item prepend-icon="mdi-book-clock-outline" value="account"
        >Đang mượn</v-list-item
      >
      <v-list-item prepend-icon="mdi-history" value="users"
        >Lịch sử</v-list-item
      >

      <v-list-item><v-divider></v-divider></v-list-item>

      <v-list-item prepend-icon="mdi-bookmark-multiple-outline" value="rules"
        >Nội quy</v-list-item
      >
      <v-list-item
        prepend-icon="mdi-book-open-page-variant-outline"
        value="intro"
        >Giới thiệu</v-list-item
      >

      <v-list-item prepend-icon="mdi-cog-outline" value="intro"
        >Cài đặt</v-list-item
      >
    </v-list>
  </v-navigation-drawer>
</template>

<script setup>
import { ref } from "vue";

const hideNav = ref(true);
</script>

<style scoped>
/* NavBar */
.v-list :deep .v-list-item--nav:not(:only-child) {
  height: 50px;
  font-size: 24px;
  padding-left: 16px;
  margin-bottom: 8px;
}

.v-list-item :deep .v-icon {
  margin-right: 16px;
}
</style>
