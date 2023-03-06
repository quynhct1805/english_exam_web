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
      <!-- <span>{{ tests }}</span> -->
      <!-- <div class="documentation-info">
        <v-card v-for="documentation in documentations">
          <v-card-title style="text-transform: uppercase">{{
            documentation.name
          }}</v-card-title>
          <v-card-text>{{ documentation.category_code }}</v-card-text>
          <v-card-text>{{ documentation.skill }}</v-card-text>
          <v-card-actions>
            <v-spacer />
            <v-btn
              variant="outlined"
              :to="{
                name: 'InfoDocumentation',
                params: { documentationId: documentation.id },
              }"
            >
              Chi tiết
            </v-btn>
          </v-card-actions>
        </v-card>
      </div> -->
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
  color: #1f3759;
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

/* .documentation-info {
  display: flex;
  margin-top: 40px;
  padding: 0 20px;
  justify-content: space-evenly;
}
.documentation-info .v-card {
  width: 28%;
}
.v-card-text {
  padding: 8px 16px;
}
.v-card-actions {
  color: #21385a;
} */
</style>
