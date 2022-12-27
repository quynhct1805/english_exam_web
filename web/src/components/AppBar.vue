<template>
  <v-app-bar color="#e4bb9a" prominent>
    <v-app-bar-nav-icon
      variant="text"
      @click.stop="hideNav = !hideNav"
    ></v-app-bar-nav-icon>

    <v-toolbar-title>
      <v-avatar>
        <v-img src="/logo.jpg" height="40px" cover></v-img>
      </v-avatar>
      Thư viện
    </v-toolbar-title>
    <slot></slot>

    <v-btn variant="text" icon="mdi-account-circle"></v-btn>
  </v-app-bar>
</template>

<script setup lang="ts">
import { ref } from "vue";

const hideNav = ref(true);
</script>

<style scoped>
/* ToolBar */
.v-toolbar :deep(.v-toolbar-title) {
  font-size: 28px;
  text-transform: uppercase;
  margin-left: 8px;
  line-height: 44px;
}

.v-toolbar-title :deep(.v-avatar) {
  margin-right: 8px;
  margin-top: -4px;
}
</style>
