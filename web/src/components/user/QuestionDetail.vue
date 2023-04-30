<template>
  <v-card class="question-detail">
    <v-btn
      class="close-btn"
      variant="text"
      icon="mdi-close-thick"
      size="x-small"
      color="#c8d5b9"
      @click="emit('watchDetail', false)"
    ></v-btn>
    <v-card-content class="px-6 py-10">
      <div class="title text-h5">
        Đáp án chi tiết #{{ questionDetail.name }}
      </div>
      <v-chip class="my-2" size="small">{{ questionDetail.part_name }}</v-chip>
      <div class="mt-5">{{ questionDetail.question }}</div>
      <v-radio-group hide-details disabled>
        <v-radio
          v-for="(ans, idx) in questionDetail.answers"
          :label="ans"
          :value="idx + 1"
        ></v-radio>
      </v-radio-group>
      <div style="color: green">
        Đáp án đúng:
        <span v-for="(ans, idx) in questionDetail.answers">
          <span v-if="idx + 1 == questionDetail.true_answer">
            {{ ans }}
          </span>
        </span>
      </div>
      <div class="mt-4">Giải thích chi tiết đáp án:</div>
      <div>{{ questionDetail.explaination }}</div>
      <!-- <div>{{ questionDetail }}</div> -->
    </v-card-content>
  </v-card>
</template>

<script setup>
// import { ref, reactive, onMounted, computed } from "vue";
// import _ from "lodash";
// import api from "@/plugins/url";
// import { useStore } from "@/components/store/store";
// import { useRules } from "@/components/store/rules";

const props = defineProps({
  questionDetail: Object,
});

// const store = useStore();
// const rules = useRules();
// const { textRules, numberRules } = rules;
// const skill = store.skill;
// const test = ref(_.cloneDeep(JSON.parse(JSON.stringify(props.testInfo))));
// const categories = ref([]);

// const showAlert = ref(false);
// const error = ref("");

const emit = defineEmits(["watchDetail"]);

// onMounted(() => {
//   api.get("/api/categories").then((res) => {
//     categories.value = res.data;
//   });
// });

// const createTest = (param) => {
//   api.post(`/api/tests`, param).then((res) => {
//     console.log(res.data);

//     // tests.value = res.data;
//   });
// };

// const updateTest = (param) => {
//   api.patch(`/api/tests/${test.value.id}`, param).then((res) => {
//     console.log(res.data);
//     // tests.value = res.data;
//   });
// };

// function handledClickSave() {
//   console.log(JSON.parse(JSON.stringify(test.value)));
//   const param = JSON.parse(JSON.stringify(test.value));
//   if (
//     _.isEmpty(param) ||
//     !param.name ||
//     !param.category_id ||
//     !param.skill ||
//     !param.time ||
//     !param.total_part ||
//     !param.total_ques
//   ) {
//     showAlert.value = true;
//     error.value = "Vui lòng nhập thông tin bắt buộc!";
//     return;
//   } else {
//     delete param.category_code;
//     delete param.id;
//     if (props.action === "add") createTest(param);
//     else updateTest(param);

//     emit("changeTest", false);
//   }
// }
</script>

<style scoped>
.question-detail {
  width: 700px;
}
.question-detail .v-card-title {
  text-transform: uppercase;
}
.v-row .v-col-12 {
  padding: 0 12px;
}
.close-btn {
  position: absolute;
  top: 8px;
  right: 10px;
  z-index: 99;
}
.title {
  font-weight: 500;
}
</style>
