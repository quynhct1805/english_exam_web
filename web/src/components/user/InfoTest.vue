<template>
  <AppBar />
  <v-layout>
    <div class="main">
      <v-btn
        variant="text"
        color="#4a7c59"
        icon="mdi-arrow-left-thick"
        :to="{ name: 'ListTest' }"
      ></v-btn>
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
      <div>
        <div class="info" v-if="page === 'info'">
          <div class="mb-2">
            <strong>Thể loại</strong>: {{ test.category_code }}
          </div>
          <div class="mb-2"><strong>Kỹ năng</strong>: {{ test.skill }}</div>
          <div class="mb-2">
            <strong>Thời gian làm bài</strong>: {{ test.time }} giây |
            {{ test.total_ques }} câu | {{ test.total_part }} bài
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
            color="#4a7c59"
            @click="checkLogin(logined)"
          >
            Luyện tập
          </v-btn>
          <Review />
        </div>
        <div class="answer" v-else>
          <v-expansion-panels class="mt-4 mb-4">
            <v-expansion-panel
              v-for="part in parts"
              :key="part.id"
              class="mb-2"
            >
              <v-expansion-panel-title>
                <strong style="text-transform: uppercase">{{
                  part.name
                }}</strong>
              </v-expansion-panel-title>
              <v-expansion-panel-text>
                <div
                  class="question mb-3"
                  v-for="(question, index) in part.questions"
                  :key="question.id"
                >
                  <div>
                    <strong>{{ question.name }}</strong
                    >. {{ question.question }}
                  </div>
                  <!-- <div
                class="ml-6"
                :class="{
                  'wrong-answer': !history.answers[index],
                }"
              >
                {{ history.answers[index] ? "" : "Chưa trả lời" }}
              </div> -->
                  <span class="ml-6">Đáp án: &nbsp;</span>
                  <span
                    v-for="(ans, idx) in question.answers"
                    :class="{
                      // 'wrong-answer': idx + 1 == history.answers[index],
                      'true-answer': idx + 1 == question.true_answer,
                    }"
                    >{{ ans }} &emsp;
                  </span>
                  <br />
                  <span
                    class="watch-detail"
                    @click="
                      (openDialog = true),
                        (questionDetail = Object.assign({}, question))
                    "
                  >
                    [Chi tiết]
                  </span>
                </div>
              </v-expansion-panel-text>
            </v-expansion-panel>
          </v-expansion-panels>
        </div>
      </div>
    </div>
    <v-dialog v-model="openDialog" persistent>
      <QuestionDetail
        class="form"
        :question-detail="questionDetail"
        @watchDetail="(res) => (openDialog = res)"
      />
    </v-dialog>
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import AppBar from "@/components/common/AppBar";
// import { useStore } from "@/components/store/store";
import QuestionDetail from "@/components/user/QuestionDetail";
import Review from "@/components/common/Review";

const props = defineProps({
  id: String,
});

// const store = useStore();
// const { user, getUser } = store;
const logined = ref(localStorage.length);
const parts = ref([]);
const test = ref({});
const page = ref("info");
const questions = ref([]);
const history = ref({});
const openDialog = ref(false);
const questionDetail = ref({});
const commentKey = ref(0);

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
  // api.get(`/api/${localStorage.id}/histories/${props.id}`).then((res) => {
  //   console.log(res.data);
  //   history.value = res.data;
  // });
});

const items = ref(["Luyện tập", "Làm full test", "Bình luận"]);
</script>

<style scoped>
.main {
  width: 60%;
  margin: 0px auto;
  padding: 20px 12px;
}
.main .v-chip {
  color: #4a7c59;
  font-weight:500
}
.main .title {
  color: #4a7c59;
  font-size: 2rem;
  text-transform: uppercase;
  font-weight: 600;
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
.wrong-answer {
  color: red;
  font-weight: 600;
}
.true-answer {
  color: green;
  font-weight: 600;
}
.not-answer {
  color: rgb(107, 107, 107);
  font-weight: 600;
}
.watch-detail {
  margin-left: 24px;
  cursor: pointer;
  color: #0d47a1;
}
</style>
