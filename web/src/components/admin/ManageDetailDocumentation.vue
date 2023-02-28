<template>
  <AppBar />
  <v-layout>
    <v-btn variant="outlined" color="#964a27" @click="$router.back()">
      <v-icon icon="mdi-arrow-left-thick"></v-icon>
    </v-btn>
    <v-container>
      <div class="title">
        <h1 class="documentation-name">
          [{{ documentation.category_code }}] {{ documentation.name }}
        </h1>
      </div>
      <span>{{ documentation }}</span>

      <div class="main">
        <div class="content">
          <div>Kỹ năng: {{ documentation.skill }}</div>
          <div>Mô tả: {{ documentation.description }}</div>
          <div>Tài liệu: {{ documentation.files }}</div>
          <!-- <v-card class="question" v-for="ques in questions">
            <v-card-title class="question-number">{{ ques.id }}</v-card-title>
            <v-card-content class="question-content">
              <span>{{ ques.question }}</span>
              <v-radio-group hide-details v-model="userAnswers[ques.id]">
                <v-radio
                  v-for="(ans, idx) in ques.answers"
                  :label="ans"
                  :value="idx + 1"
                ></v-radio>
              </v-radio-group>
            </v-card-content>
          </v-card> -->
        </div>
        <!-- <v-card class="navigation">
          <div>
            Thời gian làm bài: <span id="m">Phút</span> :
            <span id="s">Giây</span>
          </div>
          <v-btn class="submit-btn" variant="outlined" @click="submitBtn">
            Nop bai
          </v-btn>
          <v-list class="question-list">
            <v-list-item
              class="question-list-item"
              v-for="i in questions.length"
              variant="outlined"
              :value="i"
            >
              {{ i }}
            </v-list-item>
          </v-list>
        </v-card> -->
      </div>
    </v-container>
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted, computed } from "vue";
// import { useStore } from "@/components/store/users";
import AppBar from "@/components/admin/AppBar";

const props = defineProps({
  id: String,
});

// const store = useStore();
// const { user, getUser, userId } = store;

const test = ref({});
const parts = ref([]);
const documentation = ref({});
const outBtn = () => {
  const respone = confirm(
    "Bạn có muốn thoát làm bài - Kết quả sẽ không được lưu"
  );
  if (respone) {
    history.back();
  }
};
const submitBtn = () => {
  const respone = confirm("Bạn có muốn nộp bài làm - Kết quả sẽ được lưu");
  if (respone) {
    history.back();
  }
};

const userAnswers = ref([]);

const result = ref({});

onMounted(() => {
  api.get(`/api/documentations/${props.id}`).then((res) => {
    documentation.value = res.data;
  });
});
</script>

<style scoped></style>
