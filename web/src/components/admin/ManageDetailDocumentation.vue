<template>
  <AppBar />
  <v-layout>
    <div class="main">
      <DetailDocumentation :id="id" :editDoc="documentation.doc" :key="openDialog">
        <v-expansion-panel-title>
          <strong>Tài liệu</strong>
          <v-spacer></v-spacer>
          <v-btn variant="text" color="warning" icon="mdi-pencil-outline" size="small" style="height: 24px; width: 24px"
            @click="openDialog = true"></v-btn>
        </v-expansion-panel-title>
      </DetailDocumentation>

      <v-dialog v-model="openDialog" persistent>
        <v-card class="update-documentation-form">
          <v-card-title>Sửa tài liệu tham khảo</v-card-title>
          <v-divider />
          <v-card-text>
            <v-container class="pa-0">
              <v-row>
                <v-col cols="12">
                  <v-textarea v-model="documentation.doc" label="Tài liệu *" persistent-hint variant="underlined"
                    rows="22" no-resize hide-details></v-textarea>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>

          <v-alert class="alert" v-if="showAlert" type="error">
            {{ error }}
          </v-alert>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue darken-4" text @click="openDialog = false">
              Hủy
            </v-btn>
            <v-btn color="#4a7c59" text @click="handledClickSave()"> Lưu </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from 'vue'
import AppBar from "@/components/admin/AppBar";
import DetailDocumentation from "../common/DetailDocumentation.vue";
import _ from "lodash";

const props = defineProps({
  id: String,
});

const openDialog = ref(false);

const documentation = ref({});
const docs = ref([]);

const updateDocumentation = (param) => {
  api
    .patch(`/api/documentations/${documentation.value.id}`, param)
    .then((res) => {
      documentation.value = Object.assign(documentation.value, res.data);
    });
};

function handledClickSave() {
  const param = JSON.parse(JSON.stringify(documentation.value));
  if (_.isEmpty(param) || !param.name || !param.category_id || !param.skill || !param.type) {
    showAlert.value = true;
    error.value = "Vui lòng nhập thông tin bắt buộc!";
    return;
  } else {
    if (props.action === "add") createDocumentation(param);
    else updateDocumentation(param);

    // emit("changeDocumentation", false);
    openDialog.value = false;
  }
}

onMounted(() => {
  api.get(`/api/documentations/${props.id}`).then((res) => {
    documentation.value = res.data;
    if (res.data.type === 'vocabulary') docs.value = res.data.doc.split(";");
    else {
      docs.value = res.data.doc.split("\n\n\n")
      for (const [idx, doc] of docs.value.entries()) {
        docs.value[idx] = doc.split(";")
      }
    }
  });
});
</script>

<style scoped>

.update-documentation-form {
  width: 70vw;
  height: 70vh;
  overflow-y: hidden !important;
}

.update-documentation-form .v-card-title {
  text-transform: uppercase;
}
</style>
