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
          v-model="search"
          variant="underlined"
          label="Nhập từ khoá tìm kiếm: tên đề"
          prepend-inner-icon="mdi-magnify"
          hide-no-data
          single-line
          hide-details
        ></v-text-field>
        <v-spacer />
        <v-select
          v-model="filterSkill"
          class="select-input"
          label="Chọn kỹ năng"
          :items="skill"
          variant="underlined"
          hide-details
          clearable
        ></v-select>
        <v-spacer />
        <v-select
          v-model="filterCate"
          class="select-input"
          label="Chọn thể loại đề"
          :items="categories"
          item-title="code"
          item-value="code"
          variant="underlined"
          hide-details
          clearable
        ></v-select>
      </v-container>
      <ListTest :items="items" />
    </div>
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted, watch } from "vue";
import AppBar from "@/components/common/AppBar";
import ListTest from "@/components/common/ListTest";
import { useStore } from "@/components/store/store";

const store = useStore();
const { skill } = store;

const categories = ref([]);
const tests = ref([]);

const items = ref([]);
const search = ref(null);
const loading = ref(false);
const filterCate = ref(null);
const filterSkill = ref(null);

onMounted(() => {
  api.get("/api/tests").then((res) => {
    tests.value = res.data;
    items.value = res.data;
  });
  api.get("/api/categories").then((res) => {
    categories.value = res.data;
    // console.log(res.data);
  });
});

watch(search, (newVal) => {
  items.value = JSON.parse(JSON.stringify(tests.value)).filter((e) => {
    return (
      (e.name || "").toLowerCase().indexOf((newVal || "").toLowerCase()) > -1
    );
  });
});

watch(filterCate, (newVal) => {
  if (!!filterSkill.value) {
    items.value = JSON.parse(JSON.stringify(tests.value)).filter((e) => {
      return (
        (e.skill || "")
          .toLowerCase()
          .indexOf((filterSkill.value || "").toLowerCase()) > -1 &&
        (e.category_code || "")
          .toLowerCase()
          .indexOf((newVal || "").toLowerCase()) > -1
      );
    });
  } else {
    items.value = JSON.parse(JSON.stringify(tests.value)).filter((e) => {
      return (
        (e.category_code || "")
          .toLowerCase()
          .indexOf((newVal || "").toLowerCase()) > -1
      );
    });
  }
});
watch(filterSkill, (newVal) => {
  if (!!filterCate.value) {
    items.value = JSON.parse(JSON.stringify(tests.value)).filter((e) => {
      return (
        (e.skill || "").toLowerCase().indexOf((newVal || "").toLowerCase()) >
          -1 &&
        (e.category_code || "")
          .toLowerCase()
          .indexOf((filterCate.value || "").toLowerCase()) > -1
      );
    });
  } else {
    items.value = JSON.parse(JSON.stringify(tests.value)).filter((e) => {
      return (
        (e.skill || "").toLowerCase().indexOf((newVal || "").toLowerCase()) > -1
      );
    });
  }
});
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
</style>
