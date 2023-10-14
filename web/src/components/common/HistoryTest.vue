<template>
  <AppBar v-if="role === 'user'" />
  <AppBar1 v-else/>
  <v-layout>
    <div class="main">
      <v-btn
        variant="text"
        color="#4a7c59"
        icon="mdi-arrow-left-thick"
        @click="$router.replace(`/profile/${userId}`)"
      ></v-btn>
      <div class="title my-3 mx-2">Lịch sử kiểm tra</div>
      <div class="info" style="font-size: 1.2rem">
        <div>
          Đề: <strong>{{ history.test }}</strong>
        </div>
        <div>Kết quả (số câu đúng): {{ history.grade }}</div>
        <div>Tổng thời gian làm bài: {{ history.time }} giây</div>
        <div>Ngày làm bài: {{ history.created_at }}</div>
      </div>
      <v-btn class="my-3" variant="outlined" @click="watchDetail = !watchDetail" color="#4a7c59">
        Chi tiết
      </v-btn>
      <div class="detail" v-if="watchDetail">
        <span class="test-name">{{ history.test }}</span>
        <div>
          <div v-for="part in parts" :key="part.id" class="mb-5 mt-2">
            <strong style="text-transform: uppercase">{{ part.name }}</strong>
            <div
            class="question mb-3"
            v-for="(question, index) in part.questions"
            :key="question.id"
            >
            <div>
              <strong>{{ question.name }}</strong
                >. {{ question.question }}
              </div>
              <div
                class="ml-6"
                :class="{
                  'wrong-answer': !history.answers[parseInt(question.name) - 1],
                }"
              >
                {{
                  history.answers[parseInt(question.name) - 1]
                    ? ""
                    : "Chưa trả lời"
                }}
              </div>
              <span class="ml-6">Đáp án: &nbsp;</span>
              <span
                v-for="(ans, idx) in question.answers"
                :class="{
                  'wrong-answer':
                    ans === history.answers[parseInt(question.name) - 1],
                  'true-answer': (ans.toLowerCase().split(/\.\s|\./).includes(question.true_answer.toLowerCase())),
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
          </div>
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
import AppBar1 from "@/components/admin/AppBar.vue";
import QuestionDetail from "@/components/user/QuestionDetail";

const props = defineProps({
  id: String,
});

const parts = ref([]);
const history = ref({});
const watchDetail = ref(false);
const openDialog = ref(false);
const questionDetail = ref({});
const userId = ref(localStorage.id);
const role = ref(localStorage.role)

onMounted(() => {
  api.get(`/api/histories/${props.id}`).then((res) => {
    // console.log(res.data);
    history.value = res.data;
    api.get(`/api/tests/${res.data.test_id}/parts`).then((res) => {
      for (const part of res.data) {
        api.get(`/api/parts/${part.id}/questions`).then((res) => {
          // for (const question of res.data) questions.value.push(question);
          part["questions"] = res.data;
        });
      }
      parts.value = res.data;
    });
  });
});
</script>

<style scoped>
.main .v-chip {
  color: #4a7c59;
  font-weight:500
}
.main .title {
  font-size: 2rem;
  text-transform: uppercase;
  font-weight: 500;
}
.detail .test-name {
  color: #4a7c59;
  font-size: 1.4rem;
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
