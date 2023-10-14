<template>
  <v-card class="question-detail">
    <v-btn class="close-btn" variant="text" icon="mdi-close-thick" size="x-small" color="#c8d5b9"
      @click="emit('watchDetail', false)"></v-btn>
    <v-card-content class="px-6 py-10">
      <div class="title text-h5">
        Đáp án chi tiết #{{ questionDetail.name }}
      </div>
      <v-chip class="my-2" size="small">{{ questionDetail.part_name }}</v-chip>
      <div class="mt-5">{{ questionDetail.question }}</div>
      <v-radio-group hide-details disabled>
        <v-radio v-for="(ans, idx) in questionDetail.answers" :label="ans" :value="idx + 1"></v-radio>
      </v-radio-group>
      <div style="color: green">
        Đáp án đúng:
        <span v-for="(ans, idx) in questionDetail.answers">
          <span v-if="ans.toLowerCase().split(/\.\s|\./).includes(questionDetail.true_answer.toLowerCase())">
            {{ ans }}
          </span>
        </span>
      </div>
      <div class="mt-4">Giải thích chi tiết đáp án:</div>
      <div>{{ questionDetail.explaination }}</div>
    </v-card-content>
  </v-card>
</template>

<script setup>
const props = defineProps({
  questionDetail: Object,
});

const emit = defineEmits(["watchDetail"]);
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
