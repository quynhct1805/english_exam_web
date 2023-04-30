<template>
  <AppBar />
  <v-layout>
    <!-- <span>List documentation</span> -->
    <div class="main manage-document">
      <div class="content-header">
        <v-chip-group>
          <router-link
            v-for="category in categories"
            :key="category.id"
            :to="{ name: 'ListTest' }"
          >
            <v-chip variant="outlined" :value="`${category.id}`">
              {{ category.code }}
            </v-chip>
          </router-link>
        </v-chip-group>
        <v-container style="display: flex; align-items: center">
          <v-text-field
            class="search-input"
            :loading="loading"
            variant="underlined"
            label="Nhập từ khoá tìm kiếm: tên đề, kỹ năng"
            prepend-inner-icon="mdi-magnify"
            single-line
            hide-details
            @click:append-inner="onClick"
          ></v-text-field>
        </v-container>
        <v-container
          style="display: flex; margin-bottom: 12px; align-items: end"
        >
          <v-spacer />
          <v-btn
            variant="outlined"
            color="success"
            @click="
              (openDialog = true),
                (action = 'add'),
                (documentationInfo = Object.assign({}, {}))
            "
          >
            Thêm
          </v-btn>
        </v-container>
      </div>

      <v-card>
        <v-table class="manage-documentation">
          <v-row class="title">
            <v-col class="text-center" cols="1">STT</v-col>
            <v-col class="text-center" cols="2">Thể loại</v-col>
            <v-col class="text-center">Tên tài liệu</v-col>
            <v-col class="text-center" cols="2">Kỹ năng</v-col>
            <v-col class="text-center" cols="1"></v-col>
          </v-row>
          <v-divider></v-divider>

          <v-row
            class="content"
            v-for="(documentation, index) in documentations"
            :key="documentation.id"
            :class="{ background: index % 2 == 0 }"
          >
            <router-link
              :to="{
                name: 'ManageDetailDocumentation',
                params: { documentationId: documentation.id },
              }"
            >
              <v-col class="text-center" cols="1">{{ index + 1 }}</v-col>
              <v-col class="text-center" cols="2">{{
                documentation.category_code
              }}</v-col>
              <v-col class="text-center">{{ documentation.name }}</v-col>
              <v-col class="text-center" cols="2">{{
                documentation.skill
              }}</v-col>
            </router-link>
            <v-col class="text-center" cols="1">
              <v-btn
                color="warning"
                @click.stop="
                  (openDialog = true),
                    (documentationInfo = Object.assign({}, documentation)),
                    (action = 'edit')
                "
                icon="mdi-pencil-outline"
                size="small"
                variant="text"
              ></v-btn>
              <v-btn
                color="error"
                icon="mdi-delete"
                size="small"
                variant="text"
                @click="deleteDocumentation(documentation.id)"
              ></v-btn>
            </v-col>
            <v-divider></v-divider>
          </v-row>
        </v-table>
      </v-card>
    </div>
    <v-dialog v-model="openDialog" persistent>
      <DocumentationForm
        class="form"
        :action="action"
        :documentation-info="documentationInfo"
        @changeDocumentation="(res) => (openDialog = res)"
        @infoNewDoc="(res) => saveChangeDoc(res)"
      />
    </v-dialog>
    <v-snackbar v-model="snackbar" timeout="1500">
      Xóa tài liệu thành công!
      <template v-slot:actions>
        <v-btn color="pink" variant="text" @click="snackbar = false">
          Close
        </v-btn>
      </template>
    </v-snackbar>
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted, computed, watch } from "vue";
import AppBar from "@/components/admin/AppBar";
import DocumentationForm from "./DocumentationForm.vue";
import { useStore } from "@/components/store/store";

const store = useStore();
const { documentations, getDocumentations, categories, getCategories } = store;
// const categories = ref([]);
// const documentations = ref([]);

const openDialog = ref(false);
const action = ref("");
// const defaultFilteredCategory = ref("all");
const documentationInfo = ref({});

const snackbar = ref(false);
const deleteDocumentation = (documentationId) => {
  const respone = confirm("Bạn có muốn xóa tài liệu?");
  if (respone) {
    documentations.value = documentations.value.filter((object) => {
      return object.id !== documentationId;
    });
    api.delete(`/api/documentations/${documentationId}`).then((res) => {
      snackbar.value = true;
    });
  }
};

const saveChangeDoc = (info) => {
  if (action.value === "add") documentations.value.push(info);
  else {
    const index = documentations.value.findIndex((el) => el.id === info.id);
    documentations.value[index] = info;
  }
};

onMounted(() => {
  getDocumentations();
  getCategories();
});

const loaded = ref(false);
const loading = ref(false);

const onClick = () => {
  loading.value = true;
};
</script>

<style scoped>
.main {
  width: 80%;
  margin: 0px auto;
  padding: 20px 0;
}
.content-header {
  width: 80%;
  margin: 0px auto;
}
.main .v-chip {
  color: #4a7c59;
  font-weight:500
}
.main .v-chip:hover {
  background-color: #e8ebf3;
}
.main .search-input {
  width: 50%;
}
.main .select-input {
  width: 20%;
}

.documentation-info {
  display: flex;
  margin-top: 40px;
}
.v-row a {
  display: contents;
  color: black;
}
.v-row.title {
  font-weight: 500;
}
.v-row.title,
.content {
  width: 100%;
  margin: 0px;
}
.v-btn--icon {
  height: 24px;
  width: 24px;
  margin-right: 4px;
}
.background {
  background-color: #faf3dd;
}
</style>
