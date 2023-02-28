<template>
  <AppBar />
  <v-layout>
    <!-- <span>List documentation</span> -->
    <div class="main manage-document">
      <div class="content-header">
        <v-chip-group>
          <router-link :to="{ name: 'ListTest' }">
            <v-chip variant="outlined" value="all"> Tất cả </v-chip>
          </router-link>

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
            label="Nhập từ khoá tìm kiếm: dạng câu hỏi ..."
            prepend-inner-icon="mdi-magnify"
            single-line
            hide-details
            @click:append-inner="onClick"
          ></v-text-field>
          <v-spacer />
          <v-btn variant="tonal" color="#21385a">Tìm kiếm</v-btn>
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

      <v-table class="manage-documentation" :key="length">
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
        </v-row>
      </v-table>
    </div>
    <v-dialog v-model="openDialog" persistent>
      <DocumentationForm
        class="form"
        :action="action"
        :documentation-info="documentationInfo"
        @changeDocumentation="(res) => (openDialog = res)"
      />
    </v-dialog>
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
const length = ref(0);
const test = ref([
  { id: 1, name: "mot" },
  { id: 2, name: "hai" },
  { id: 3, name: "ba" },
]);

const openDialog = ref(false);
const action = ref("");
// const defaultFilteredCategory = ref("all");
const documentationInfo = ref({});

const deleteDocumentation = (documentationId) => {
  // console.log(length.value);
  // api
  //   .delete(`/api/documentations/${documentationId}`)
  //   .then((res) => console.log(res));
  // console.log(length.value);
};

// const getInfor = () => {
//   api.get("/api/documentations").then((res) => {
//     documentations.value = res.data;
//     length.value = res.data.length;
//   });
//   api.get("/api/categories").then((res) => {
//     categories.value = res.data;
//     // console.log(res.data);
//   });
// };

onMounted(() => {
  getDocumentations();
  getCategories();
  console.log(documentations);
});

const loaded = ref(false);
const loading = ref(false);

watch(documentations.value.length, (value) => {
  console.log(value);
  getDocumentations();
});

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
  color: #1f3759;
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
.v-row.title,
.content {
  width: 100%;
  margin-top: 2px;
}
.v-btn--icon {
  height: 24px;
  width: 24px;
  margin-right: 4px;
}
.v-divider {
  margin-top: 8px;
}
</style>
