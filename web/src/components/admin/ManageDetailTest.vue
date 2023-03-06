<template>
  <AppBar />
  <v-layout>
    <div class="main px-3">
      <v-btn
        variant="text"
        color="#10294d"
        icon="mdi-arrow-left-thick"
        @click="$router.back()"
      ></v-btn>
      <div class="title">
        <h1 class="test-name">Đề {{ test.name }}</h1>
      </div>
      <div class="content">
        <div>Thể loại: {{ test.category_code }}</div>
        <div>Kỹ năng: {{ test.skill }}</div>
        <div>Thời gian: {{ test.time }}</div>
        <div>Số bài: {{ test.total_part }}</div>
        <div>Mô tả: {{ test.description }}</div>
        <v-expansion-panels variant="popout" class="panel-part my-4">
          <v-expansion-panel
            v-for="part in parts"
            :key="part.id"
            :title="part.name"
            class="question-info"
          >
            <v-expansion-panel-text>
              <div class="question pb-2" v-for="ques in part.questions">
                <v-card-content class="question-content">
                  <div>
                    <strong>Câu {{ ques.name }}</strong>
                    : {{ ques.question }}
                  </div>
                  <span>Đáp án: &nbsp;</span>
                  <span
                    v-for="(ans, idx) in ques.answers"
                    :class="{
                      'true-answer': idx + 1 == ques.true_answer,
                    }"
                    >{{ ans }} &emsp;
                  </span>
                  <div style="font-style: italic">
                    {{ ques.explaination }}
                  </div>
                </v-card-content>
              </div>
              <v-btn
                class="add-btn included"
                variant="text"
                color="#10294d"
                icon="mdi-plus-circle-outline"
                @click="(addQues = true), (newQues.part_id = part.id)"
              ></v-btn>
              <v-form
                class="add-question"
                v-if="addQues"
                v-click-outside="{
                  handler: onClickOutside,
                  include,
                }"
                @submit.prevent
              >
                <v-card-title>Thêm câu hỏi</v-card-title>
                <v-row no-gutters>
                  <v-col cols="2">
                    <v-text-field
                      v-model="newQues.name"
                      variant="outlined"
                      label="Tên"
                      density="compact"
                      :rules="textRules"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-textarea
                      v-model="newQues.question"
                      variant="outlined"
                      label="Câu hỏi"
                      density="compact"
                      rows="2"
                    ></v-textarea>
                  </v-col>
                  <v-col cols="8" class="mr-4">
                    <v-text-field
                      v-model="newQues.answers"
                      variant="outlined"
                      label="Đáp án"
                      density="compact"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="3">
                    <v-text-field
                      v-model="newQues.true_answer"
                      variant="outlined"
                      label="Đáp án đúng"
                      density="compact"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-textarea
                      v-model="newQues.explaination"
                      variant="outlined"
                      label="Giải thích"
                      density="compact"
                      rows="2"
                    ></v-textarea>
                  </v-col>
                </v-row>
                <v-btn class="mr-2" color="red" text @click="addQues = false">
                  Hủy
                </v-btn>

                <v-btn color="success" text @click="saveNewQues" type="submit">
                  Lưu
                </v-btn>
              </v-form>
            </v-expansion-panel-text>
          </v-expansion-panel>
        </v-expansion-panels>
        <v-btn
          class="add-btn included"
          variant="text"
          color="#10294d"
          prepend-icon="mdi-plus"
          @click="addPart = true"
          >Thêm bài
        </v-btn>
        <v-form
          class="add-part"
          v-if="addPart"
          v-click-outside="{
            handler: onClickOutside,
            include,
          }"
          @submit.prevent
        >
          <v-card-title>Thêm bài</v-card-title>
          <v-row no-gutters>
            <v-col cols="2" class="mr-4">
              <v-text-field
                v-model="newPart.name"
                variant="outlined"
                label="Tên *"
                density="compact"
                :rules="textRules"
              ></v-text-field>
            </v-col>
            <v-col cols="2" class="mr-4">
              <v-text-field
                type="number"
                v-model="newPart.total_ques"
                variant="outlined"
                label="Tổng số câu hỏi"
                density="compact"
                :rules="numberRules"
              ></v-text-field>
            </v-col>
            <v-col cols="3" class="mr-4">
              <v-text-field
                v-model="newPart.audio"
                variant="outlined"
                label="Tên file nghe"
                density="compact"
              ></v-text-field>
            </v-col>
            <v-col cols="12" class="mt-3">
              <v-textarea
                v-model="newPart.paragraph"
                variant="outlined"
                label="Đoạn văn"
                density="compact"
                rows="2"
                messages="** Thêm tên file nghe, đoạn văn nếu có"
              ></v-textarea>
            </v-col>
            <v-col cols="12" class="mt-3">
              <v-textarea
                v-model="newPart.description"
                variant="outlined"
                label="Mô tả"
                density="compact"
                rows="2"
              ></v-textarea>
            </v-col>
          </v-row>
          <v-btn class="mr-2" color="red" text @click="addPart = false">
            Hủy
          </v-btn>

          <v-btn color="success" text type="submit" @click="saveNewPart">
            Lưu
          </v-btn>
        </v-form>
        <v-alert class="alert" v-if="showAlert" type="error">
          {{ error }}
        </v-alert>
      </div>
    </div>
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted, computed, reactive } from "vue";
import { useRules } from "@/components/store/rules";
import AppBar from "@/components/admin/AppBar";

const props = defineProps({
  id: String,
});

const rules = useRules();
const { numberRules, textRules } = rules;

const test = ref({});
const parts = ref([]);
const questions = ref([]);
const userAnswers = ref([]);
const result = ref({});
const showAlert = ref(false);
const error = ref("");

const addQues = ref(false);
const newQues = ref({
  name: "",
  part_id: 0,
  question: "",
  answers: [],
  true_answer: "",
  explaination: "",
});
const saveNewQues = () => {
  console.log("save");
  const ans = newQues.value.answers.split(",");
  newQues.value.answers = ans;
  console.log(newQues);
  api.post(`/api/questions`, newQues.value).then((res) => {
    console.log(res.data);
  });
  addQues.value = false;
};

const addPart = ref(false);
const newPart = ref({
  name: "",
  test_id: props.id,
  total_ques: 0,
  description: "",
  audio: "",
  paragraph: "",
});
const saveNewPart = () => {
  if (newPart.value.name === "" || [0, ""].includes(newPart.value.total_ques)) {
    showAlert.value = true;
    error.value = "Vui lòng nhập thông tin!";
    return;
  }
  api.post(`/api/parts`, newPart.value).then((res) => {
    console.log(res.data);
  });
  addPart.value = false;
};

const add = (id) => {
  addQues.value = true;
  newQues.part_id = id;
};

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

const onClickOutside = () => {
  addQues.value = false;
  addPart.value = false;
};

const include = () => {
  return [document.querySelector(".included")];
};

onMounted(() => {
  result.value = { user_id: localStorage.id };
  api.get(`/api/tests/${props.id}`).then((res) => {
    test.value = res.data;
  });
  api.get(`/api/tests/${props.id}/parts`).then((res) => {
    for (const part of res.data) {
      api.get(`/api/parts/${part.id}/questions`).then((res) => {
        part["questions"] = res.data;
      });
    }
    parts.value = res.data;
  });
});
</script>

<style scoped>
.main {
  width: 80%;
  margin: 0px auto;
  padding: 20px 0;
}
.true-answer {
  color: green;
  font-weight: 600;
}
</style>
