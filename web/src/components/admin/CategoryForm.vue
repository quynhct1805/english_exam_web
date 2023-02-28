<template>
  <v-form @submit.prevent>
    <v-card class="update-test-form">
      <v-card-title v-if="action === 'add'"> Thêm thể loại </v-card-title>
      <v-card-title v-else>Sửa thể loại</v-card-title>
      <v-divider />
      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="12" md="6">
              <v-text-field
                v-model="category.code"
                label="Mã thể loại *"
                clearable
                variant="underlined"
                :rules="textRules"
                :readonly="action === 'edit' ? true : false"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="category.name"
                label="Tên thể loại *"
                clearable
                variant="underlined"
                :rules="textRules"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-textarea
                v-model="category.description"
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
        <v-btn
          color="blue darken-4"
          text
          @click="emit('changeCategory', false)"
        >
          Hủy
        </v-btn>
        <v-btn color="#62311a" text @click="handledClickSave"> Lưu </v-btn>
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
  categoryInfo: Object,
  action: String,
});

const store = useStore();
const rules = useRules();
const { textRules } = rules;
const category = ref(
  _.cloneDeep(JSON.parse(JSON.stringify(props.categoryInfo)))
);

const showAlert = ref(false);
const error = ref("");

const emit = defineEmits(["changeCategory"]);

// onMounted(() => {
//   api.get("/api/categories").then((res) => {
//     categories.value = res.data;
//   });
// });

const createCategory = (param) => {
  api.post(`/api/categories`, param).then((res) => {
    console.log(res.data);
    if (res.data.code === 400) {
      showAlert.value = true;
      error.value = res.data.message;
      return;
    }
    emit("changeCategory", false);
  });
};

const updateCategory = (param) => {
  api.patch(`/api/categories/${param.code}`, param).then((res) => {
    console.log(res.data);
    emit("changeCategory", false);
  });
};

function handledClickSave() {
  const param = JSON.parse(JSON.stringify(category.value));
  if (_.isEmpty(param) || !param.name || !param.code) {
    showAlert.value = true;
    error.value = "Vui lòng nhập thông tin bắt buộc!";
    return;
  } else {
    param.code = param.code.toLowerCase();
    if (props.action === "add") createCategory(param);
    else updateCategory(param);
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
