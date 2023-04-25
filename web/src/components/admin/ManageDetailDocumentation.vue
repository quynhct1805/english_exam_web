<template>
  <AppBar />
  <v-layout>
    <div class="main">
      <v-btn
        variant="text"
        color="#10294d"
        icon="mdi-arrow-left-thick"
        @click="$router.back()"
      ></v-btn>
      <div class="title mb-3">
        <h1 class="documentation-name">
          [{{ documentation.category_code }}] {{ documentation.name }}
        </h1>
      </div>
      <div class="content">
        <v-expansion-panels v-model="panel" class="mb-4">
          <v-expansion-panel>
            <v-expansion-panel-title>
              <strong>Thông tin</strong>
            </v-expansion-panel-title>
            <v-expansion-panel-text>
              <div class="mb-1">
                <strong>Kỹ năng:</strong> {{ documentation.skill }}
              </div>
              <div class="mb-1">
                <strong>Mô tả:</strong> {{ documentation.description }}
              </div>
            </v-expansion-panel-text>
          </v-expansion-panel>
        </v-expansion-panels>
        <div>{{ documentation.type }}</div>
        <v-expansion-panels>
          <v-expansion-panel>
            <v-expansion-panel-title>
              <strong>Tài liệu</strong>
            </v-expansion-panel-title>
            <v-expansion-panel-text>
              <div v-for="doc in docs">{{ doc }}</div>
            </v-expansion-panel-text>
          </v-expansion-panel>
        </v-expansion-panels>

        <!-- <div>Tài liệu: {{ documentation.files }}</div> -->
      </div>
    </div>
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
const panel = ref([0]);

const userAnswers = ref([]);

const result = ref({});

const docs = ref([]);

onMounted(() => {
  api.get(`/api/documentations/${props.id}`).then((res) => {
    documentation.value = res.data;
    docs.value = res.data.doc.split(";");
  });
});
</script>

<style scoped>
.main {
  width: 60%;
  margin: 0px auto;
  padding: 20px 12px;
}
</style>
