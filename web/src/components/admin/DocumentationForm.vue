<template>
  <v-card class="update-documentation-form">
    <v-card-title v-if="action === 'add'">
      Thêm tài liệu tham khảo
    </v-card-title>
    <v-card-title v-else>Sửa tài liệu tham khảo</v-card-title>
    <v-divider />
    <v-card-text>
      <v-container>
        <v-row>
          <v-col cols="12">
            <v-text-field
              v-model="documentation.name"
              label="Tên tài liệu *"
              placeholder=""
              clearable
              variant="underlined"
              color="black"
              :rules="textRules"
            ></v-text-field>
          </v-col>
          <v-col cols="12" md="4">
            <v-autocomplete
              v-model="documentation.category_id"
              label="Thể loại *"
              :items="categories"
              item-title="code"
              item-value="id"
              variant="underlined"
              :rules="textRules"
            ></v-autocomplete>
          </v-col>
          <v-col cols="12" md="4">
            <v-select
              v-model="documentation.skill"
              :items="skill"
              item-title="name"
              item-value="id"
              label="Kỹ năng *"
              variant="underlined"
              :rules="textRules"
            ></v-select>
          </v-col>
          <v-col cols="12" md="4">
            <v-select
              v-model="documentation.type"
              :items="typeDoc"
              item-title="label"
              item-value="type"
              label="Dạng tài liệu *"
              variant="underlined"
              :rules="textRules"
            ></v-select>
          </v-col>
          <v-col cols="12">
            <v-textarea
              v-model="documentation.description"
              label="Mô tả"
              persistent-hint
              variant="underlined"
              rows="2"
              no-resize
            ></v-textarea>
          </v-col>
          <v-col cols="12">
            <v-textarea
              v-model="documentation.doc"
              label="Tài liệu *"
              persistent-hint
              variant="underlined"
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
        @click="emit('changeDocumentation', false)"
      >
        Hủy
      </v-btn>
      <v-btn color="#4a7c59" text @click="handledClickSave()"> Lưu </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script setup>
import { ref, reactive, onMounted } from "vue";
import api from "@/plugins/url";
import { useStore } from "@/components/store/store";
import { useRules } from "../store/rules";
import _ from "lodash";

const props = defineProps({
  documentationInfo: Object,
  action: String,
});

const documentation = ref(
  _.cloneDeep(JSON.parse(JSON.stringify(props.documentationInfo)))
);

const emit = defineEmits(["changeDocumentation", "infoNewDoc"]);
const categories = ref([]);
const store = useStore();
const skill = store.skill;
const rules = useRules();
const { textRules, fileRules } = rules;

const showAlert = ref(false);
const error = ref("");

const checkFile = () => {
  const file = files.value[0];
  const generatedFile = new File(["Rough Draft ...."], file.name, {
    type: file.type,
    lastModified: file.lastModified,
  });
};

const files = ref([]);

// const typeDoc = ref(["Từ vựng", "Mẫu câu hỏi"]);
const typeDoc = ref([
  {type: 'vocabulary', label: "Từ vựng"},
  {type: 'example', label:"Mẫu câu hỏi"}
]
)

// const time = ref(new Date().getTime());
// const date = ref(new Date());

// const addFiles = () => {
//   // this.files.forEach((file, f) => {
//   //   this.readers[f] = new FileReader();
//   //   this.readers[f].onloadend = (e) => {
//   //     let fileData = this.readers[f].result;
//   //     let imgRef = this.$refs.file[f];
//   //     imgRef.src = fileData;
//   //     // send to server here...
//   //   };

//   //   this.readers[f].readAsDataURL(this.files[f]);
//   // });
// };
onMounted(() => {
  api.get("/api/categories").then((res) => {
    categories.value = res.data;
  });
});

const createDocumentation = (param) => {
  api.post("/api/documentations", param).then((res) => {
    Object.assign(param, res.data);
    const category_code = JSON.parse(JSON.stringify(categories.value)).filter(
      (category) => category.id === param.category_id
    );
    Object.assign(param, { category_code: category_code[0].code });
    emit("infoNewDoc", param);
  });
};

const updateDocumentation = (param) => {
  api
    .patch(`/api/documentations/${documentation.value.id}`, param)
    .then((res) => {
      Object.assign(param, res.data);
      emit("infoNewDoc", param);
    });
};

function handledClickSave() {
  const param = JSON.parse(JSON.stringify(documentation.value));

  for (const file of files.value) {
    param.files.push(file);
  }
  // param.files.push(files.value);
  if (_.isEmpty(param) || !param.name || !param.category_id || !param.skill || !param.type) {
    showAlert.value = true;
    error.value = "Vui lòng nhập thông tin bắt buộc!";
    return;
  } else {
    if (props.action === "add") createDocumentation(param);
    else updateDocumentation(param);

    emit("changeDocumentation", false);
  }
}
</script>

<style scoped>
.update-documentation-form {
  width: 800px;
}
.update-documentation-form .v-card-title {
  text-transform: uppercase;
}
.v-row .v-col-12 {
  padding: 0 12px;
}
</style>
