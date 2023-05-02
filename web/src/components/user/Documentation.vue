<template>
  <AppBar />
  <v-layout>
    <div class="main">
      <v-chip-group>
        <v-chip
          v-for="category in categories"
          :key="category.id"
          variant="outlined"
          :value="`${category.id}`"
        >
          {{ category.code }}
        </v-chip>
      </v-chip-group>
      <v-container style="display: flex; margin-bottom: 12px">
        <v-text-field
          class="search-input"
          :loading="loading"
          variant="underlined"
          placeholder="Nhập từ khoá tìm kiếm: tên đề, kỹ năng"
          prepend-inner-icon="mdi-magnify"
          single-line
          hide-details
          @click:append-inner="onClick"
        ></v-text-field>
        <v-spacer />
        <v-select
          class="select-input"
          placeholder="Chọn thể loại đề"
          :items="test"
          variant="underlined"
          hide-details
          item-title="name"
          item-value="id"
        ></v-select>
      </v-container>
      <Documentation />
    </div>
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import AppBar from "@/components/common/AppBar";
import Documentation from "@/components/common/Documentation";

const categories = ref([]);
const documentations = ref([]);

onMounted(() => {
  api.get("/api/documentations").then((res) => {
    documentations.value = res.data;
  });
  api.get("/api/categories").then((res) => {
    categories.value = res.data;
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
  color: #4a7c59;
  font-weight:500
}
.main .v-chip:hover {
  background-color: #e8ebf3;
}
.main .search-input {
  width: 40%;
}
.main .select-input {
  width: 20%;
}
</style>
