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
        <div v-for="part in parts" class="mb-4">
          <v-card
            v-if="part.paragraph && part.id == choosingPart"
            class="py-4 px-6"
          >
            {{ part.paragraph }}
          </v-card>
        </div>
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
              <v-radio-group
                hide-details
                v-model="userAnswers[parseInt(ques.name)]"
              >
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
          Thời gian còn lại:
          <div class="time-left-container">
            <span class="time-left-label">{{ timeLeftString }}</span>
          </div>
        </div>
        <v-btn class="submit-btn" variant="outlined" @click="submitBtn()">
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
              :class="{ choosen: !!userAnswers[question.name] }"
            >
              {{ question.name }}
            </v-list-item>
          </div>
        </v-list>
      </v-card>
    </div>
  </v-container>
  <v-snackbar v-model="snackbar" :timeout="timeout">
    {{ noti }}
    <template v-slot:actions>
      <v-btn color="blue" variant="text" @click="snackbar = false">
        Đóng
      </v-btn>
    </template>
  </v-snackbar>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted, computed } from "vue";
// import { useStore } from "@/components/store/store";
import AppBar from "@/components/common/AppBar";
import { useRouter } from "vue-router";

const props = defineProps({
  id: String,
});

// const store = useStore();
// const { user, getUser } = store;
const router = useRouter();
const test = ref({});
const parts = ref([]);
const questions = ref([]);
const userAnswers = ref([]);
const trueAnswers = ref([]);
const result = ref({});
const choosingPart = ref(0);

// remind about time
const snackbar = ref(false);
const noti = ref("Thời gian làm bài sắp hết!");
const timeout = ref(3000);

// the timer
const timeElapsed = ref(0);
const timerInterval = ref(undefined);
const timeLimit = ref(20);

const padToTwo = (num) => {
  // e.g. 4 -> '04'
  return String(num).padStart(2, "0");
};
const timeLeft = computed(() => {
  return timeLimit.value - timeElapsed.value;
});

const timeLeftString = computed(() => {
  const minutes = Math.floor(timeLeft.value / 60);
  const seconds = timeLeft.value % 60;
  return `${padToTwo(minutes)}:${padToTwo(seconds)}`;
});

const startTimer = () => {
  timerInterval.value = setInterval(() => {
    // Stop counting when there is no more time left
    if (++timeElapsed.value === timeLimit.value) {
      clearInterval(timerInterval.value);
      checkAnswers();
      api.post(`/api/histories`, result.value);
      router.replace(`/tests/${props.id}`);
    }
    if (timeLeft.value === 300) snackbar.value = true;
  }, 1000);
};

// out do test not save grade
const outBtn = () => {
  const respone = confirm(
    "Bạn có muốn thoát làm bài - Kết quả sẽ không được lưu"
  );
  // cancel -> respone = false
  if (respone) {
    clearInterval(timerInterval.value);
    router.replace(`/tests/${props.id}`);
  }
};

// submit test
const submitBtn = () => {
  const respone = confirm("Bạn có muốn nộp bài làm - Kết quả sẽ được lưu");
  if (respone) {
    checkAnswers();
    const newHistory = ref(0);
    api.post(`/api/histories`, result.value).then((res) => {
      newHistory.value = res.data;
      console.log(newHistory.value, res.data);
      clearInterval(timerInterval.value);
      router.replace(`/history/${res.data.id}`);
    });
  }
};

// check answers of user
const checkAnswers = () => {
  const totalQues = JSON.parse(JSON.stringify(test.value)).total_ques;
  const grade = ref(0);
  const tempUserAnswers = JSON.parse(JSON.stringify(userAnswers.value));
  const tempTrueAnswers = JSON.parse(JSON.stringify(trueAnswers.value));
  for (const index in tempTrueAnswers) {
    if (tempTrueAnswers[index] == tempUserAnswers[parseInt(index) + 1]) {
      grade.value += 1;
    }
  }
  result.value.time = timeElapsed.value;
  result.value.grade = `${grade.value}/${totalQues}`;
  result.value.answers = tempUserAnswers.slice(1, tempUserAnswers.length);
};

onMounted(() => {
  startTimer();
  result.value = {
    user_id: localStorage.id,
    test_id: props.id,
    grade: "",
    time: 0,
  };
  api.get(`/api/tests/${props.id}`).then((res) => {
    timeLimit.value = res.data.time;
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
  margin-top: 28px;
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
.time-left-container {
  font-weight: 600;
  font-size: 1.2rem;
}
.choosen {
  background-color: #bbbb;
}
</style>
