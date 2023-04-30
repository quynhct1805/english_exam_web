<template>
  <v-form @submit.prevent>
    <v-card class="update-test-form">
      <v-card-title v-if="action === 'add'"> Thêm bài kiểm tra </v-card-title>
      <v-card-title v-else>Sửa bài kiểm tra</v-card-title>
      <v-divider />
      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="12">
              <v-text-field
                v-model="test.name"
                label="Tên đề kiểm tra *"
                clearable
                variant="underlined"
                :rules="textRules"
              ></v-text-field>
            </v-col>
            <v-col cols="12" md="6">
              <v-autocomplete
                v-model="test.category_id"
                :items="categories"
                item-title="code"
                item-value="id"
                label="Thể loại *"
                persistent-hint
                variant="underlined"
                :rules="textRules"
              ></v-autocomplete>
            </v-col>
            <v-col cols="12" md="6">
              <v-select
                v-model="test.skill"
                :items="skill"
                label="Kỹ năng *"
                variant="underlined"
                :rules="textRules"
              ></v-select>
            </v-col>
            <v-col cols="12" md="4">
              <v-text-field
                type="number"
                v-model="test.time"
                label="Thời gian *"
                variant="underlined"
                :rules="numberRules"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6" md="4">
              <v-text-field
                type="number"
                v-model="test.total_part"
                label="Tổng số bài *"
                persistent-hint
                variant="underlined"
                :rules="numberRules"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6" md="4">
              <v-text-field
                type="number"
                v-model="test.total_ques"
                label="Tổng số câu hỏi *"
                persistent-hint
                variant="underlined"
                :rules="numberRules"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-textarea
                v-model="test.description"
                label="Mô tả"
                persistent-hint
                variant="underlined"
                rows="2"
                no-resize
                class="pt-1"
              ></v-textarea>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>

      <v-alert class="alert" v-if="showAlert" type="error">
        {{ error }}
      </v-alert>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="blue darken-4" text @click="emit('changeTest', false)">
          Hủy
        </v-btn>
        <v-btn color="#4a7c59" text @click="handledClickSave"> Lưu </v-btn>
      </v-card-actions>
    </v-card>
  </v-form>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from "vue";
import _ from "lodash";
import api from "@/plugins/url";
import { useStore } from "@/components/store/store";
import { useRules } from "@/components/store/rules";

const props = defineProps({
  testInfo: Object,
  action: String,
});

const store = useStore();
const rules = useRules();
const { textRules, numberRules } = rules;
const skill = store.skill;
const test = ref(_.cloneDeep(JSON.parse(JSON.stringify(props.testInfo))));
const categories = ref([]);

const showAlert = ref(false);
const error = ref("");

const emit = defineEmits(["changeTest", "infoNewTest"]);

onMounted(() => {
  api.get("/api/categories").then((res) => {
    categories.value = res.data;
  });
});

const createTest = (param) => {
  api.post(`/api/tests`, param).then((res) => {
    Object.assign(param, res.data);
    const category_code = JSON.parse(JSON.stringify(categories.value)).filter(
      (category) => category.id === param.category_id
    );
    Object.assign(param, { category_code: category_code[0].code });
    emit("infoNewTest", param);
  });
};

const updateTest = (param) => {
  api.patch(`/api/tests/${test.value.id}`, param).then((res) => {
    Object.assign(param, res.data);
    emit("infoNewTest", param);
  });
};

function handledClickSave() {
  const param = JSON.parse(JSON.stringify(test.value));
  if (
    _.isEmpty(param) ||
    !param.name ||
    !param.category_id ||
    !param.skill ||
    !param.time ||
    !param.total_part ||
    !param.total_ques
  ) {
    showAlert.value = true;
    error.value = "Vui lòng nhập thông tin bắt buộc!";
    return;
  } else {
    if (props.action === "add") createTest(param);
    else updateTest(param);

    emit("changeTest", false);
  }
}
</script>

<style scoped>
.update-test-form {
  width: 800px;
}
.update-test-form .v-card-title {
  text-transform: uppercase;
}
.v-row .v-col-12 {
  padding: 0 12px;
}
</style>
