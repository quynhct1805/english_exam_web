<template>
  <AppBar />
  <v-layout>
    <!-- <span>List test</span> -->
    <div class="main manage-test">
      <div class="content-header">
        <v-chip-group>
          <router-link :to="{ name: 'ManageTest' }">
            <v-chip variant="outlined" value="all"> Tất cả </v-chip>
          </router-link>

          <router-link
            v-for="category in categories"
            :key="category.id"
            :to="{ name: 'ManageTest' }"
          >
            <v-chip variant="outlined" :value="`${category.id}`">
              {{ category.code }}
            </v-chip>
          </router-link>
        </v-chip-group>
        <v-container style="display: flex; margin-bottom: 12px">
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
          <v-select
            class="select-input"
            label="Chọn bộ đề thi"
            :items="test"
            variant="underlined"
            hide-details
            item-title="name"
            item-value="id"
          ></v-select>
        </v-container>
        <v-container style="display: flex; margin-bottom: 12px">
          <v-btn variant="tonal" color="#21385a">Tìm kiếm</v-btn>
          <v-spacer />
          <v-btn
            variant="outlined"
            color="success"
            @click="
              (openDialog = true),
                (action = 'add'),
                (categoryInfo = Object.assign({}, {}))
            "
          >
            Thêm
          </v-btn>
        </v-container>
      </div>

      <v-table class="manage-category" :key="categories.length">
        <v-row class="title">
          <v-col class="text-center" cols="1">STT</v-col>
          <v-col class="text-center" cols="1">Mã thể loại</v-col>
          <v-col class="text-center" cols="3">Tên thể loại</v-col>
          <v-col class="text-center">Mô tả</v-col>
          <v-col class="text-center" cols="1"></v-col>
        </v-row>
        <v-divider></v-divider>

        <v-row
          class="content"
          v-for="(category, index) in categories"
          :key="category.id"
        >
          <v-col class="text-center" cols="1">{{ index + 1 }}</v-col>
          <v-col class="text-center" cols="1">{{ category.code }}</v-col>
          <v-col class="text-center" cols="3">{{ category.name }}</v-col>
          <v-col class="text-center">{{ category.description }}</v-col>
          <v-col class="text-center" cols="1">
            <v-btn
              color="warning"
              @click="
                (openDialog = true),
                  (action = 'edit'),
                  (categoryInfo = Object.assign({}, category))
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
              @click="deleteCategory(category.id)"
            ></v-btn>
          </v-col>
        </v-row>
      </v-table>
    </div>
    <v-dialog v-model="openDialog" persistent>
      <CategoryForm
        class="form"
        :action="action"
        :category-info="categoryInfo"
        @changeCategory="(res) => (openDialog = res)"
      />
    </v-dialog>
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import AppBar from "@/components/admin/AppBar";
import CategoryForm from "./CategoryForm.vue";
import { useStore } from "@/components/store/store";

// const categories = ref([]);
const tests = ref([]);
const store = useStore();
const { categories, getCategories } = store;

const openDialog = ref(false);
const action = ref("");
const categoryInfo = ref({});

const deleteCategory = (categoryId) => {
  console.log(categoryId);
  api.delete(`/api/categories/${categoryId}`).then((res) => console.log(res));
};

onMounted(() => {
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

.test-info {
  display: flex;
  margin-top: 40px;
}
.v-row a {
  display: contents;
  color: black;
}
.v-table :deep(.v-table__wrapper) {
  overflow: hidden;
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
