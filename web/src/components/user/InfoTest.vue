<template>
  <AppBar />
  <v-layout>
    <div class="main">
      <v-chip-group disabled>
        <v-chip draggable variant="outlined" :value="`${test.id}`">
          {{ test.category_code }}
        </v-chip>
        <v-chip draggable variant="outlined" :value="`${test.id}`">
          {{ test.skill }}
        </v-chip>
      </v-chip-group>
      <span class="title">{{ test.name }}</span>
      <v-chip-group v-model="page">
        <v-chip variant="outlined" value="info"> Thông tin đề thi </v-chip>
        <v-chip variant="outlined" value="answer"> Đáp án/Trancript </v-chip>
      </v-chip-group>
      <div class="my-2">
        <div class="info" v-if="page === 'info'">
          <div class="mb-2">
            <strong>Thể loại</strong>: {{ test.category_code }}
          </div>
          <div class="mb-2"><strong>Kỹ năng</strong>: {{ test.skill }}</div>
          <div class="mb-2">
            <strong>Thời gian làm bài</strong>: {{ test.time }} |
            {{ test.total_part }} |
            {{ test.total_ques }}
          </div>
          <v-alert class="alert" v-if="showAlert" type="warning">
            {{ warning }}
          </v-alert>
          <v-btn
            class="mt-4"
            variant="tonal"
            :to="
              logined > 0
                ? {
                    name: 'Testing',
                    params: { testId: id },
                  }
                : {}
            "
            color="#21385a"
            @click="checkLogin(logined)"
          >
            Luyện tập
          </v-btn>
        </div>
        <div class="answer" v-else>
          <div v-for="part in parts" :key="part.id">
            <strong>{{ part.name }}</strong>
            <div
              class="question"
              v-for="question in part.questions"
              :key="question.id"
            >
              <div>{{ question.name }}</div>
              <div>{{ question.question }}</div>
              <div>{{ question.answers }}</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import AppBar from "@/components/common/AppBar";

const props = defineProps({
  id: String,
});

const logined = ref(localStorage.length);
const parts = ref([]);
const test = ref({});
const tests = ref([
  { id: 1, name: "mot" },
  { id: 2, name: "hai" },
  { id: 3, name: "ba" },
]);
const page = ref("info");
const questions = ref([]);
// console.log(props.id);
// const defaultFilteredCategory = ref("all");
const checkLogin = (param) => {
  if (param > 0) return;
  else {
    showAlert.value = true;
    warning.value =
      "Vui lòng đăng nhập hoặc đăng ký tài khoản để bắt đầu bài thi.";
  }
};
const showAlert = ref(false);
const warning = ref("");

onMounted(() => {
  api.get(`/api/tests/${props.id}`).then((res) => {
    // console.log(res.data);
    test.value = res.data;
  });
  api.get(`/api/tests/${props.id}/parts`).then((res) => {
    for (const part of res.data) {
      api.get(`/api/parts/${part.id}/questions`).then((res) => {
        // for (const question of res.data) questions.value.push(question);
        part["questions"] = res.data;
      });
    }
    parts.value = res.data;
  });
});

// const loaded = ref(false);
// const loading = ref(false);

// const onClick = () => {
//   loading = true;
// };

const items = ref(["Luyện tập", "Làm full test", "Bình luận"]);
</script>

<style scoped>
.main {
  width: 60%;
  margin: 0px auto;
  padding: 20px 12px;
}
.main .v-chip {
  color: #1f3759;
}
.main .title {
  color: #1f3759;
  font-size: 2rem;
  text-transform: uppercase;
  font-weight: 500;
}
.main .search-input {
  width: 50%;
}
.main .select-input {
  width: 20%;
}

.test-info {
  display: flex;
  margin-top: 40px;
}
/* .v-card {
  width: 24%;
  margin-right: 12px;
} */
</style>
