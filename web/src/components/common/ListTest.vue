<template>
  <div class="test-info" :class="{ 'test-info-admin': role == 'admin' }">
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
        <v-btn variant="outlined" :to="{
          name: 'InfoTest',
          params: { testId: test.id },
        }">
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
const role = ref(localStorage.role);

onMounted(() => {
  api.get("/api/tests").then((res) => {
    if (
      (["Home", "FirstPage"].includes(router.currentRoute.value.name) &&
        role.value === "member") ||
      !role.value
    ) {
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
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
}

.test-info .v-card {
  margin: 0 32px;
  margin-bottom: 28px;
  transition: transform .4s;
}

@media only screen and (max-width: 1280px) {
  .test-info {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }
}

@media only screen and (max-width: 960px) {
  .test-info {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
  .test-info .v-card {
    margin: 0 40px;
    margin-bottom: 28px;
  }
}

@media only screen and (max-width: 600px) {
  .test-info {
    grid-template-columns: repeat(1, minmax(0, 1fr));
  }
  .test-info .v-card {
    margin: 0 60px;
    margin-bottom: 28px;
  }
}

.test-info .v-card:hover {
  /* background-color: rgb(200, 213, 185, 0.1); */
  background-color: white;
  transform: scale(1.1);
}

.v-card-text {
  padding: 8px 16px;
}

.v-card-actions {
  color: #4a7c59;
}

.test-info-admin {
  justify-content: start !important;
}


.show-btns {
  color: rgba(255, 255, 255, 1) !important;
}
</style>
