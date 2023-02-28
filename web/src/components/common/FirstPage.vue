<template>
  <AppBar />
  <v-layout>
    <div class="main">
      <!-- <div class="welcome text-h5">Xin chào, {{ userName }}!</div> -->
      <slot name="welcome"></slot>
      <div class="list-test">
        <div class="title text-h5 my-8">Đề thi mới nhất</div>
        <ListTest />
      </div>
      <div class="list-documentation">
        <div class="title text-h5 my-8">Tài liệu mới nhất</div>
        <Documentation />
      </div>
    </div>
  </v-layout>
  <v-footer class="text-center d-flex flex-column">
    <div>
      <v-btn
        v-for="icon in icons"
        :key="icon"
        class="mx-2"
        :icon="icon"
        variant="text"
      ></v-btn>
    </div>
    <div>{{ new Date().getFullYear() }} — <strong>STUDYENG</strong></div>
  </v-footer>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useStore } from "@/components/store/store";
import AppBar from "@/components/admin/AppBar.vue";
import ListTest from "@/components/common/ListTest";
import Documentation from "@/components/common/Documentation";

const store = useStore();
const { tests, getTests } = store;
const userName = ref(localStorage.name);
const icons = ref([
  "mdi-facebook",
  "mdi-twitter",
  "mdi-linkedin",
  "mdi-instagram",
]);

onMounted(() => {
  getTests();
});
</script>

<style scoped>
.main {
  width: 60%;
  margin: 0px auto;
  padding: 20px 12px;
}
.welcome {
  font-weight: 500;
  margin-left: 20px;
  margin-top: 20px;
}
.test-info,
.documentation-info {
  display: flex;
  justify-content: space-evenly;
}
.list-test .title,
.list-documentation .title {
  text-align: center;
  font-weight: 500;
}
.v-footer {
  background-color: #e7f0f6;
}
</style>
