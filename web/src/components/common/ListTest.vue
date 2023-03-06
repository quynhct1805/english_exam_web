<template>
  <div class="test-info">
    <v-card v-for="test in !!items ? items : tests">
      <v-card-title style="text-transform: uppercase">{{
        test.name
      }}</v-card-title>
      <v-card-text>{{ test.category_code }}</v-card-text>
      <v-card-text>{{ test.skill }}</v-card-text>
      <v-card-text>{{ test.time }} phút</v-card-text>
      <v-card-text>
        {{ test.total_part }} phần thi | {{ test.total_ques }} câu hỏi
      </v-card-text>
      <v-card-actions>
        <v-spacer />
        <v-btn
          variant="outlined"
          :to="{
            name: 'InfoTest',
            params: { testId: test.id },
          }"
        >
          Chi tiết
        </v-btn>
      </v-card-actions>
    </v-card>
  </div>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";

const props = defineProps({
  items: { type: Object, required: false },
});

const categories = ref([]);
const tests = ref([]);

const router = useRouter();

onMounted(() => {
  api.get("/api/tests").then((res) => {
    if (["Home", "FirstPage"].includes(router.currentRoute.value.name)) {
      res.data = res.data.slice(-3);
    }
    tests.value = res.data;
  });
  api.get("/api/categories").then((res) => {
    categories.value = res.data;
  });
});
</script>

<style scoped>
.test-info {
  display: flex;
  margin-top: 40px;
  padding: 0 20px;
  justify-content: start;
  flex-wrap: wrap;
}
.test-info .v-card {
  width: 28%;
  margin: 0 19px;
  margin-bottom: 20px;
}
.v-card-text {
  padding: 8px 16px;
}
.v-card-actions {
  color: #21385a;
}
</style>
