<template>
  <v-app-bar color="#E7F0F6" class="appbar">
    <router-link
      :to="logined > 0 ? { name: 'Home' } : { name: 'FirstPage' }"
      class="logo"
    >
      <img src="@/assets/StudyTestlogo.png" height="48" />
    </router-link>
    <v-spacer />

    <v-list-item v-for="page of pages" :to="{ name: `${page.page}` }">{{
      page.label
    }}</v-list-item>

    <v-menu v-if="logined > 0">
      <template v-slot:activator="{ props }">
        <v-btn
          variant="text"
          size="large"
          icon="mdi-account-circle"
          v-bind="props"
        ></v-btn>
      </template>
      <v-list class="menu-profile">
        <v-list-item :to="{ name: 'ProfilePage', params: { userId: userId } }">
          <v-list-item-title> Trang cá nhân </v-list-item-title>
        </v-list-item>
        <slot name="admin-management"></slot>
        <v-list-item @click="logout" :to="{ name: 'FirstPage' }">
          <v-list-item-title>Đăng xuất</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>

    <v-btn v-else class="login-btn" rounded="pill" :to="{ name: 'Login' }">
      Đăng nhập
    </v-btn>
  </v-app-bar>
</template>

<script setup>
import { ref, onMounted } from "vue";

const logined = ref(localStorage.length);
const role = ref(localStorage.role);
const userId = ref(localStorage.id);
const pages = ref([
  {
    page: role.value === "admin" ? "ManageTest" : "ListTest",
    label: "Đề thi online",
  },
  {
    page: role.value === "admin" ? "ManageDocumentation" : "Documentation",
    label: "Tài liệu tham khảo",
  },
]);

const profile = ref([{ title: "Trang cá nhân" }, { title: "Đăng xuất" }]);
const logout = () => localStorage.clear();
</script>

<style scoped>
.appbar .v-list-item {
  height: 100%;
  font-weight: 500;
}

.appbar .logo {
  margin-left: 12px;
}
.login-btn {
  background-color: #283c74;
  color: white;
  text-transform: none;
  padding: 0 12px;
  margin-right: 12px;
}
.menu-profile {
  margin-top: 4px;
}
</style>
