<template>
  <AppBar />
  <v-container>
    <div class="title">
      <h1 class="test-name">{{ test.name }}</h1>
      <v-btn class="out-btn" size="small" variant="outlined" @click="outBtn">
        Thoát
      </v-btn>
    </div>

    <div class="main">
      <div class="content">
        Hướng dẫn
        <!-- <div>test: {{ test }}</div>
        <div>parts:{{ parts }}</div>
        <br />
        <div>result: {{ result }}</div>
        <br />
        <div>{{ userAnswers }}</div>
        <div>{{ trueAnswers }}</div> -->
        <div v-for="part in parts">
          <audio controls class="mx-3 my-1" v-if="part.id == choosingPart">
            <source
              :src="`/src/assets/audio/CD1/${part.audio}.mp3`"
              type="audio/mp3"
            />
          </audio>
        </div>
        <v-chip-group v-model="choosingPart">
          <v-chip
            variant="outlined"
            v-for="part in parts"
            :key="part.id"
            :value="part.id"
          >
            {{ part.name }}
          </v-chip>
        </v-chip-group>
        <v-card
          class="do-test"
          v-for="(question, idx) in questions"
          :key="question.part_id"
        >
          <v-card
            class="question"
            v-for="(ques, index) in question.data"
            :key="ques.id"
            v-if="choosingPart === question.part_id"
          >
            <v-card-title class="question-number">{{ ques.name }}</v-card-title>
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
          </v-card>
        </v-card>
      </div>
      <v-card class="navigation">
        <div>
          Thời gian làm bài: <span id="m">Phút</span> :
          <span id="s">Giây</span>
        </div>
        <v-btn
          class="submit-btn"
          variant="outlined"
          @click="submitBtn(), checkAnswers()"
        >
          Nộp bài
        </v-btn>
        <v-list class="question-list">
          <div class="question-list-part" v-for="part in parts" :key="part.id">
            <v-card-title class="part-name">{{ part.name }}</v-card-title>
            <v-list-item
              class="question-list-item"
              v-for="question in part.questions"
              variant="outlined"
              :value="question.id"
            >
              {{ question.name }}
            </v-list-item>
          </div>
        </v-list>
      </v-card>
    </div>
  </v-container>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted, computed } from "vue";
// import { useStore } from "@/components/store/users";
import AppBar from "@/components/common/AppBar";
import { useRouter } from "vue-router";

const props = defineProps({
  id: String,
});

// const store = useStore();
// const { user, getUser, userId } = store;
const router = useRouter();
const test = ref({});
const parts = ref([]);
const questions = ref([]);
const userAnswers = ref([]);
const trueAnswers = ref([]);
const result = ref({});
const choosingPart = ref(0);
// const audio = ref("01-AudioTrack 01");

const outBtn = () => {
  const respone = confirm(
    "Bạn có muốn thoát làm bài - Kết quả sẽ không được lưu"
  );
  // cancel -> respone = false
  console.log(respone);
  if (respone) {
    router.replace(`/tests/${props.id}`);
  }
};
const submitBtn = () => {
  const respone = confirm("Bạn có muốn nộp bài làm - Kết quả sẽ được lưu");
  // console.log(JSON.parse(JSON  .stringify(result.value)));
  if (respone) {
    checkAnswers();
    api.post(`/api/histories`, result.value).then((res) => {
      // console.log(res.data);
    });
    router.replace(`/tests/${props.id}`);
  }
};

const checkAnswers = () => {
  const grade = ref(0);
  const tempUserAnswers = JSON.parse(JSON.stringify(userAnswers.value));
  const tempTrueAnswers = JSON.parse(JSON.stringify(trueAnswers.value));
  for (const index in tempTrueAnswers) {
    if (tempTrueAnswers[index] == tempUserAnswers[parseInt(index) + 1]) {
      grade.value += 1;
    }
  }
  result.value.grade = grade.value;
};

onMounted(() => {
  result.value = {
    user_id: localStorage.id,
    test_id: props.id,
    grade: 0,
    time: 0,
  };
  api.get(`/api/tests/${props.id}`).then((res) => {
    test.value = res.data;
  });
  api.get(`/api/tests/${props.id}/parts`).then((res) => {
    for (const part of res.data) {
      api.get(`/api/parts/${part.id}/questions`).then((res) => {
        questions.value.push({ part_id: part.id, data: res.data });
        for (const answer of res.data) {
          trueAnswers.value.push(answer.true_answer);
        }
        part["questions"] = res.data;
      });
    }
    choosingPart.value = res.data[0].id;
    parts.value = res.data;
  });
});
</script>

<style scoped>
.v-container {
  background-color: #f8f9fa;
  margin: 0;
  max-width: 100%;
}
.title {
  display: flex;
  justify-content: center;
}
.test-name {
  margin: 16px;
}
.out-btn {
  margin: auto 4px;
  padding: 0 5px;
  height: 24px;
}
.main {
  display: flex;
  justify-content: space-around;
  width: 90%;
  margin: 0 auto;
}
.content {
  width: 80%;
  margin-right: 284px;
}
.navigation {
  width: 12%;
  padding: 20px;
  height: fit-content;
  position: fixed;
  right: 136px;
}
.do-test {
  max-height: 800px;
  overflow: scroll;
}
.question {
  margin: 8px 0;
  display: flex;
  box-shadow: none;
}
.question-number {
  align-items: normal;
}
.question-content {
  padding: 12px 0;
}
.question-list {
  display: flex;
  flex-wrap: wrap;
}
.question-list .question-list-item {
  border-radius: 3px;
  font-weight: 600;
  margin-right: 4px;
  margin-bottom: 4px;
  width: 32px;
  max-height: 28px;
  min-height: 28px;
  padding: 0 0;
  font-size: 14px;
  display: inline-flex;
  justify-content: center;
  align-items: center;
}
.submit-btn {
  margin: 12px auto;
  width: 100%;
}
.part-name {
  text-transform: capitalize;
  padding-left: 0;
  font-size: 1.1rem;
  font-weight: 600;
}
</style>
