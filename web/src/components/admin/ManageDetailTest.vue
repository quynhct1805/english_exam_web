<template>
  <AppBar />
  <v-layout>
    <div class="main px-3">
      <v-btn
        variant="text"
        color="#4a7c59"
        icon="mdi-arrow-left-thick"
        @click="$router.back()"
      ></v-btn>
      <div class="title">
        <h1 class="test-name">{{ test.name }}</h1>
      </div>
      <div class="content">
        <v-expansion-panels v-model="panel">
          <v-expansion-panel> 
            <v-expansion-panel-title>
              <strong>Thông tin cơ bản</strong>
            </v-expansion-panel-title>
            <v-expansion-panel-text>
              <div>Thể loại: {{ test.category_code }}</div>
              <div>Kỹ năng: {{ test.skill }}</div>
              <div>Thời gian: {{ test.time }}</div>
              <div>Số bài: {{ test.total_part }}</div>
              <div>Mô tả: {{ test.description }}</div>
            </v-expansion-panel-text>
          </v-expansion-panel>
        </v-expansion-panels>
        <v-expansion-panels variant="popout" class="panel-part my-4">
          <v-expansion-panel
            v-for="(part, indexPart) in parts"
            :key="part.id"
            class="question-info"
          >
            <v-expansion-panel-title expand-icon="mdi-menu-down">
              <strong>{{ part.name }}</strong>
              <v-spacer></v-spacer>
              <v-btn
                variant="text"
                color="error"
                icon="mdi-delete"
                size="small"
                style="height: 18px; width: 18px"
                @click="deletePart(part.id, indexPart)"
              ></v-btn>
            </v-expansion-panel-title>

            <v-expansion-panel-text>
              <div
                class="question pb-2 pt-2"
                v-for="(ques, index) in part.questions"
                :key="ques.id"
              >
                <v-card-content class="question-content" :key="index">
                  <v-row>
                    <v-col cols="auto" class="pe-0">
                      <strong style="font-size: 18px">
                        Câu {{ ques.name }}:
                      </strong>
                    </v-col>
                    <v-col>
                      <div class="question-text">
                        <div style="font-size: 18px">
                          {{ ques.question }}
                        </div>
                        <v-btn
                          variant="text"
                          color="error"
                          icon="mdi-delete"
                          size="small"
                          @click="deleteQuestion(ques.id, indexPart)"
                        ></v-btn>
                      </div>
                      <v-row class="mt-0">
                        <v-col cols="auto" class="pe-0">
                          <strong> Đáp án: &nbsp;</strong>
                        </v-col>
                        <v-col class="ps-0">
                          <span
                            v-for="(ans, idx) in ques.answers"
                            :class="{
                              'true-answer': idx + 1 == ques.true_answer,
                            }"
                            >{{ ans }} <br />
                          </span>
                        </v-col>
                      </v-row>
                      <div class="mt-2" style="font-style: italic">
                        {{ ques.explaination }}
                      </div>
                    </v-col>
                  </v-row>
                </v-card-content>
              </div>
              <v-btn
                class="add-btn included"
                variant="text"
                color="#4a7c59"
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
                  <v-col cols="8" class="mr-4 mb-3">
                    <div
                      v-for="(ans, idx) in newQues.answers"
                      :key="idx"
                      class="answer-input"
                    >
                      <v-text-field
                        v-model="newQues.answers[idx]"
                        class="mb-2"
                        variant="outlined"
                        label="Đáp án"
                        density="compact"
                        hide-details
                      ></v-text-field>
                      <v-btn
                        class="add-ans"
                        variant="text"
                        icon="mdi-close-thick"
                        size="small"
                        @click="removeAnswer(idx)"
                      >
                      </v-btn>
                    </div>
                    <v-btn
                      variant="outlined"
                      color="#4a7c59"
                      @click="addAnswer()"
                    >
                      Thêm đáp án
                    </v-btn>
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

                <v-btn
                  color="success"
                  text
                  @click="saveNewQues(indexPart)"
                  type="submit"
                >
                  Lưu
                </v-btn>
              </v-form>
            </v-expansion-panel-text>
          </v-expansion-panel>
        </v-expansion-panels>
        <v-btn
          class="add-btn included mb-2"
          variant="outlined"
          color="#4a7c59"
          prepend-icon="mdi-plus"
          @click="addPart = true"
          >Thêm bài
        </v-btn>
        <v-card v-if="addPart" class="pt-1 px-4 pb-4">
          <v-form
            class="add-part"
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
                  label="Tổng số câu hỏi *"
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
        </v-card>

        <v-alert class="alert" v-if="showAlert" type="error">
          {{ error }}
        </v-alert>
      </div>
      <v-snackbar v-model="snackbar" timeout="2000">
        Xóa câu hỏi thành công!
        <template v-slot:actions>
          <v-btn color="pink" variant="text" @click="snackbar = false">
            Close
          </v-btn>
        </template>
      </v-snackbar>
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
// const parts = computed(() => {
//   const tempParts = ref([]);
//   api.get(`/api/tests/${props.id}/parts`).then((res) => {
//     for (const part of res.data) {
//       api.get(`/api/parts/${part.id}/questions`).then((res) => {
//         part["questions"] = res.data;
//       });
//     }
//     tempParts.value = res.data;
//   });
//   return tempParts;
// });
// const tempParts = computed(() => parts.value);
const questions = ref([]);
const tempQues = computed(() => questions.value);
const userAnswers = ref([]);
const result = ref({});
const showAlert = ref(false);
const error = ref("");
const panel = ref([0]);
const length = computed(() => {
  return questions.value.length;
});

const addQues = ref(false);
const newQues = ref({
  name: "",
  part_id: 0,
  question: "",
  answers: [],
  true_answer: "",
  explaination: "",
});
const saveNewQues = (index) => {
  console.log(index);
  api.post(`/api/questions`, newQues.value).then((res) => {
    Object.assign(newQues.value, res.data);
    parts.value[index].questions.push(
      JSON.parse(JSON.stringify(newQues.value))
    );
    console.log(res.data);
  });
  addQues.value = false;
};

const snackbar = ref(false);
const deleteQuestion = (questionId, index) => {
  const respone = confirm("Bạn có muốn xóa câu hỏi?");
  if (respone) {
    // console.log(questionId, index);
    parts.value[index].questions = parts.value[index].questions.filter(
      (object) => {
        return object.id !== questionId;
      }
    );
    // console.log(JSON.parse(JSON.stringify(parts.value[index].questions)));
    api.delete(`/api/questions/${questionId}`).then((res) => {
      snackbar.value = true;
    });
  }
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
    Object.assign(newPart.value, res.data);
    parts.value.push(
      JSON.parse(JSON.stringify(newPart.value))
    );
    console.log(res.data);
    console.log(res.data);
    newPart.value = {
      name: "",
      test_id: props.id,
      total_ques: 0,
      description: "",
      audio: "",
      paragraph: "",
    };
  });
  addPart.value = false;
  showAlert.value = false;
};
const deletePart = (partId, index) => {
  const respone = confirm("Bạn có muốn xóa bài?");
  if (respone) {
    // console.log(questionId, index);
    parts.value = parts.value.filter(
      (object) => {
        return object.id !== partId;
      }
    );
    console.log(JSON.parse(JSON.stringify(parts.value)));
    api.delete(`/api/parts/${partId}`).then((res) => {
      snackbar.value = true;
    });
  }
};

const add = (id) => {
  addQues.value = true;
  newQues.part_id = id;
};

// const outBtn = () => {
//   const respone = confirm(
//     "Bạn có muốn thoát làm bài - Kết quả sẽ không được lưu"
//   );
//   if (respone) {
//     history.back();
//   }
// };
// const submitBtn = () => {
//   const respone = confirm("Bạn có muốn nộp bài làm - Kết quả sẽ được lưu");
//   if (respone) {
//     history.back();
//   }
// };

const onClickOutside = () => {
  addQues.value = false;
  addPart.value = false;
};

const include = () => {
  return [document.querySelector(".included")];
};

const addAnswer = () => {
  newQues.value.answers.push("");
};

const removeAnswer = (index) => {
  newQues.value.answers.splice(index, 1);
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
.title {
  text-align: center;
  margin-bottom: 4px;
}
.true-answer {
  color: green;
  font-weight: 600;
}
.answer-input {
  display: flex;
}
.question-text {
  display: flex;
  justify-content: space-between;
}
</style>
