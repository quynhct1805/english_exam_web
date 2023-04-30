<template>
  <AppBar>
    <template v-slot:admin-management>
      <v-list-item
        v-for="(page, idx) in managementPages"
        :key="idx"
        :value="page"
        :to="{ name: `${page.page}` }"
      >
        <v-list-item-title>{{ page.label }}</v-list-item-title>
      </v-list-item>
    </template>
  </AppBar>
</template>

<script setup>
import { ref, onMounted } from "vue";
import AppBar from "@/components/common/AppBar";
// import api from "@/plugins/url";
// import { useStore } from "@/components/store/users";

// const store = useStore(1);
const logined = ref(localStorage.length);
const role = ref(localStorage.role);
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

const profile = ref([
  { title: "Trang cá nhân" },
  { title: "Đăng xuất" },
  // { title: "Click Me" },
  // { title: "Click Me 2" },
]);
// const { user, getUser } = store;
// // userId.value = user_id.value;
const logout = () => localStorage.clear();
// onMounted(() => {
//   getUser(1);
// });
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
  /* background-color: #283c74; */
  background-color: #4a7c59;
  color: white;
  text-transform: none;
  padding: 0 12px;
  margin-right: 12px;
}
.menu-profile {
  margin-top: 4px;
}
</style>
