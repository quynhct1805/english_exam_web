<template>
  <AppBar />
  <img style="width: 100%" src="@/assets/3.png" />
  <v-layout style="margin-top: -12px;">
    <div class="main">
      <slot name="welcome"></slot>
      <div class="list-test">
        <div class="title text-h5 my-8" v-if="role === 'member'">
          Đề thi mới nhất
        </div>
        <div class="title text-h5 my-8" v-else>Đề thi</div>
        <ListTest />
      </div>
      <div class="list-documentation">
        <div class="title text-h5 my-8" v-if="role === 'member'">
          Tài liệu mới nhất
        </div>
        <div class="title text-h5 my-8" v-else>Tài liệu</div>
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
const icons = ref([
  "mdi-facebook",
  "mdi-twitter",
  "mdi-linkedin",
  "mdi-instagram",
]);
const role = ref(localStorage.role);

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
  background-color: #4a7c59;
  color: white;
}
</style>
