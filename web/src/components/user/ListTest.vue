<template>
  <AppBar />
  <v-layout>
    <div class="main">
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
      <v-container style="display: flex; margin-bottom: 12px">
        <v-text-field
          class="search-input"
          :loading="loading"
          variant="underlined"
          placeholder="Nhập từ khoá tìm kiếm: dạng câu hỏi ..."
          prepend-inner-icon="mdi-magnify"
          single-line
          hide-details
          @click:append-inner="onClick"
        ></v-text-field>
        <v-spacer />
        <v-select
          class="select-input"
          placeholder="Chọn bộ đề thi"
          :items="test"
          variant="underlined"
          hide-details
          item-title="name"
          item-value="id"
        ></v-select>
      </v-container>
      <v-btn variant="tonal" color="#21385a">Tìm kiếm</v-btn>
      <ListTest />
    </div>
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import AppBar from "@/components/common/AppBar";
import ListTest from "@/components/common/ListTest";

const categories = ref([]);
const tests = ref([]);
const test = ref([
  { id: 1, name: "mot" },
  { id: 2, name: "hai" },
  { id: 3, name: "ba" },
]);

// const defaultFilteredCategory = ref("all");

// const getCategories = async () => {
//   await api.get("/api/categories/").then((res) => {
//     categories.value = res.data;
//     console.log(res.data);
//   });
// };
// getCategories();
onMounted(() => {
  api.get("/api/tests").then((res) => {
    // console.log(res.data);
    tests.value = res.data;
  });
  api.get("/api/categories").then((res) => {
    categories.value = res.data;
    // console.log(res.data);
  });
});

const loaded = ref(false);
const loading = ref(false);

const onClick = () => {
  loading.value = true;
};
</script>

<style scoped>
.main {
  width: 60%;
  margin: 0px auto;
  padding: 20px 12px;
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
</style>
