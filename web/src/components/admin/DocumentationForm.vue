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
          <v-col cols="12" md="6">
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
          <v-col cols="12" md="6">
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
          <v-col cols="12">
            <v-file-input
              v-model="files"
              density="comfortable"
              accept=".pdf"
              multiple
              chips
              label="Tài liệu *"
              variant="underlined"
              messages="** Định dạng file cho phép *.pdf, *.txt"
              :rules="fileRules"
              @change="checkFile"
            ></v-file-input>
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
      <v-btn color="#62311a" text @click="handledClickSave"> Lưu </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script setup>
import { ref, reactive, onMounted } from "vue";
import api from "@/plugins/url";
import { useStore } from "@/components/store/store";
import { useRules } from "../store/rules";
import _ from "lodash";
// import { DateTime } from "luxon";

const props = defineProps({
  documentationInfo: Object,
  action: String,
});

// const documentationId = props.documentation ? props.documentation.id : "";
const documentation = ref(
  _.cloneDeep(JSON.parse(JSON.stringify(props.documentationInfo)))
);

const emit = defineEmits(["changeDocumentation"]);
const categories = ref([]);
const store = useStore();
const skill = store.skill;
const rules = useRules();
const { textRules, fileRules } = rules;

const showAlert = ref(false);
const error = ref("");

// console.log(documentation.files);

const checkFile = () => {
  console.log("files", files.value[0]);
  const file = files.value[0];
  console.log("file", file.name);
  const generatedFile = new File(["Rough Draft ...."], file.name, {
    type: file.type,
    lastModified: file.lastModified,
  });
  console.log(generatedFile);
};

const files = ref([]);

// const time = ref(new Date().getTime());
// console.log(time.value);
// const date = ref(new Date());
// console.log(date.value.toTimeString());

// const addFiles = () => {
//   console.log("files", files);
//   // this.files.forEach((file, f) => {
//   //   this.readers[f] = new FileReader();
//   //   this.readers[f].onloadend = (e) => {
//   //     let fileData = this.readers[f].result;
//   //     let imgRef = this.$refs.file[f];
//   //     imgRef.src = fileData;
//   //     console.log(fileData);
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
    console.log(res.data);
    // tests.value = res.data;
  });
};

const updateDocumentation = (param) => {
  api
    .patch(`/api/documentations/${documentation.value.id}`, param)
    .then((res) => {
      console.log(res.data);
      // tests.value = res.data;
    });
};

function handledClickSave() {
  const param = JSON.parse(JSON.stringify(documentation.value));
  console.log(files);
  console.log(files.value);
  for (const file of files.value) {
    param.files.push(file);
  }
  // param.files.push(files.value);
  console.log(param.files);
  if (_.isEmpty(param) || !param.name || !param.category_id || !param.skill) {
    showAlert.value = true;
    error.value = "Vui lòng nhập thông tin bắt buộc!";
    return;
  } else {
    console.log(param);

    delete param.category_code;
    delete param.id;
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
