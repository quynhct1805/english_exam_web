<template>
  <AppBar />
  <v-layout class="first-page">
    <v-row style="height: 100%" no-gutters>
      <v-col cols="12">
        <img style="width: 100%" src="@/assets/cover.png" />
      </v-col>
      <v-col cols="12">
        <div class="main">
          <slot name="welcome"></slot>
          <div class="list-test">
            <div class="title text-h5 my-8" v-if="role === 'member'">
              Đề thi mới nhất
            </div>
            <div class="title text-h5 mt-8" v-else>Đề thi</div>
            <v-btn class="btn-display mb-8" size="x-small" variant="outlined" color="#4a7c59" @click="() => changeDisplay('test')">{{labelBtn}}</v-btn>
            <ListTest v-if="showMoreTest"/>
          </div>
          <div class="list-documentation">
            <div class="title text-h5 my-8" v-if="role === 'member'">
              Tài liệu mới nhất
            </div>
            <div class="title text-h5 mt-8" v-else>Tài liệu</div>
            <v-btn class="btn-display mb-8" size="x-small" variant="outlined" color="#4a7c59" @click="() => changeDisplay('doc')">{{labelBtn}}</v-btn>
            <Documentation v-if="showMoreDoc"/>
          </div>
        </div>
      </v-col>
    </v-row>
  </v-layout>
  <v-footer class="text-center d-flex flex-column">
    <div>
      <v-btn v-for="icon in icons" :key="icon" class="mx-2" :icon="icon" variant="text"></v-btn>
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

const showMoreTest = ref(true)
const showMoreDoc = ref(true)
const labelBtn = ref('show less')

const changeDisplay = (field) => {
  field === 'test' ? showMoreTest.value = !showMoreTest.value : showMoreDoc.value = !showMoreDoc.value
  labelBtn.value = (showMoreTest.value || showMoreDoc.value) ? 'show less' : 'show more'
}

onMounted(() => {
  getTests();
});
</script>

<style scoped>
.first {
  display: flex;
}

.welcome {
  font-weight: 500;
  margin-left: 20px;
  margin-top: 20px;
}

/* .test-info,
.documentation-info {
  display: flex;
  justify-content: space-evenly;
} */

.list-test .title,
.list-documentation .title {
  text-align: center;
  font-weight: 500;
}

.v-footer {
  background-color: #4a7c59;
  color: white;
}

.btn-display {
  display: flex;
  margin: auto
}
</style>
