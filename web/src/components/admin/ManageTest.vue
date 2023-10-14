<template>
  <AppBar />
  <v-layout>
    <!-- <span>List test</span> -->
    <div class="main manage-test">
      <div class="content-header">
        <v-chip-group>
          <router-link v-for="category in categories" :key="category.id" :to="{ name: 'ManageTest' }">
            <v-chip variant="outlined" :value="`${category.id}`">
              {{ category.code }}
            </v-chip>
          </router-link>
        </v-chip-group>
        <v-container style="display: flex; margin-bottom: 12px">
          <v-text-field class="search-input" :loading="loading" v-model="search" variant="underlined"
            label="Nhập từ khoá tìm kiếm: tên đề" prepend-inner-icon="mdi-magnify" hide-no-data single-line
            hide-details></v-text-field>
          <v-spacer />
          <v-select v-model="filterSkill" class="select-input" label="Chọn kỹ năng" :items="skill" variant="underlined"
            hide-details clearable></v-select>
          <v-spacer />
          <v-select v-model="filterCate" class="select-input" label="Chọn thể loại đề" :items="categories"
            item-title="code" item-value="code" variant="underlined" hide-details clearable></v-select>
        </v-container>
        <v-container style="display: flex; margin-bottom: 12px">
          <v-spacer />
          <v-btn variant="outlined" color="success" @click="
            (openDialog = true),
            (action = 'add'),
            (testInfo = Object.assign({}, {}))
            ">
            Thêm
          </v-btn>
        </v-container>
      </div>

      <!-- <div>{{ listTest }}</div> -->

      <v-card>
        <v-table class="manage-test" :key="items.length">
          <v-row class="title">
            <v-col class="text-center stt" cols="1">STT</v-col>
            <v-col class="text-center cate" cols="2">Thể loại</v-col>
            <v-col class="text-center">Đề</v-col>
            <v-col class="text-center skill" cols="2">Kỹ năng</v-col>
            <v-col class="text-center total-part" cols="2">Tổng số bài</v-col>
            <v-col class="text-center time" cols="2">Tổng thời gian (s)</v-col>
            <v-col class="text-center" cols="1"></v-col>
          </v-row>
          <v-divider></v-divider>

          <v-row class="content" v-for="(test, index) in items" :key="test.id" :class="{ background: index % 2 == 0 }">
            <router-link :to="{ name: 'ManageDetailTest', params: { testId: test.id } }">
              <v-col class="text-center stt" cols="1">{{ index + 1 }}</v-col>
              <v-col class="text-center cate" cols="2">{{
                test.category_code
              }}</v-col>
              <v-col class="text-center">{{ test.name }}</v-col>
              <v-col class="text-center skill" cols="2">{{ test.skill }}</v-col>
              <v-col class="text-center total-part" cols="2">{{ test.total_part }}</v-col>
              <v-col class="text-center time" cols="2">{{ test.time }}</v-col>
            </router-link>
            <v-col class="text-center" cols="1">
              <v-btn color="warning" @click="
                (openDialog = true),
                (action = 'edit'),
                (testInfo = Object.assign({}, test))
                " icon="mdi-pencil-outline" size="small" variant="text"></v-btn>
              <v-btn color="error" icon="mdi-delete" size="small" variant="text" @click="deleteTest(test.id)"></v-btn>
            </v-col>
            <v-divider></v-divider>
          </v-row>
        </v-table>
      </v-card>
    </div>
    <v-dialog v-model="openDialog" persistent>
      <TestForm class="form" :action="action" :test-info="testInfo" @changeTest="(res) => (openDialog = res)"
        @infoNewTest="(res) => saveChangeTest(res)" />
    </v-dialog>
    <v-snackbar v-model="snackbar" timeout="1500">
      Xóa đề thi thành công!
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
import { ref, onMounted, watch, computed } from "vue";
import AppBar from "@/components/admin/AppBar";
import TestForm from "./TestForm.vue";
import { useStore } from "@/components/store/store";

const store = useStore();
const { skill, tests, getTests } = store;

const categories = ref([]);
// const tests = ref([]);

const openDialog = ref(false);
const action = ref("");
const testInfo = ref({});
const items = ref([]);
const search = ref(null);
const loading = ref(false);
const filterCate = ref(null);
const filterSkill = ref(null);

const snackbar = ref(false);
const deleteTest = (testId) => {
  const respone = confirm("Bạn có muốn xóa đề thi?");
  if (respone) {
    items.value = items.value.filter((object) => {
      return object.id !== testId;
    });
    api.delete(`/api/tests/${testId}`).then((res) => {
      snackbar.value = true;
    });
  }
};

const saveChangeTest = (info) => {
  if (action.value === "add") items.value.push(info);
  else {
    const index = items.value.findIndex((el) => el.id === info.id);
    items.value[index] = info;
  }
};

// const listTest = computed(() => {
//   console.log(filterCate.value)
//   if (!!filterCate.value) {
//     console.log(11)
//     return JSON.parse(JSON.stringify(tests.value)).filter((e) => {
//       (e.category_code || "")
//         .toLowerCase()
//         .indexOf((filterCate.value || "").toLowerCase()) > -1
//     });
//   }
//   // items.value = JSON.parse(JSON.stringify((!!filterSkill.value && !!filterSkill.value) ? items.value : tests.value)).filter((e) => {
//   //   return (
//   //     (e.category_code || "")
//   //       .toLowerCase()
//   //       .indexOf((newVal || "").toLowerCase()) > -1
//   //   );
//   // });
//   else return tests
//   // tests
// })

onMounted(() => {
  getTests()
  api.get("/api/tests").then((res) => {
    // tests.value = res.data;
    items.value = res.data;
  });
  api.get("/api/categories").then((res) => {
    categories.value = res.data;
  });
});

watch(search, (newVal) => {
  items.value = JSON.parse(JSON.stringify(tests.value)).filter((e) => {
    return (
      (e.name || "").toLowerCase().indexOf((newVal || "").toLowerCase()) > -1
    );
  });
});

// filter by category
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
  // console.log('filterCate', newVal)
  // items.value = JSON.parse(JSON.stringify((!!filterSkill.value && !!filterSkill.value) ? items.value : tests.value)).filter((e) => {
  //   return (
  //     (e.category_code || "")
  //       .toLowerCase()
  //       .indexOf((newVal || "").toLowerCase()) > -1
  //   );
  // });
});

// filter by skill
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

  // const first = items.value
  // console.log('filterSkill', first)

  // items.value = JSON.parse(JSON.stringify(!!filterCate.value ? items.value : tests.value)).filter((e) => {
  //   return (
  //     (e.skill || "").toLowerCase().indexOf((newVal || "").toLowerCase()) > -1
  //   );
  // });
});
</script>

<style scoped>
/* .main {
  width: 80%;
  margin: 0px auto;
  padding: 20px 0;
} */
.content-header {
  width: 80%;
  margin: 0px auto;
}

.main .v-chip {
  color: #4a7c59;
  font-weight: 500
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

/* .v-divider {
  margin: 0 16px;
  color: #3e3d3d;
} */

.background {
  background-color: #faf3dd;
}

@media only screen and (max-width: 600px) {
  .stt {
    display: none;
  }

  .cate {
    max-width: fit-content
  }

  .skill {
    max-width: fit-content;
  }
}

@media only screen and (max-width: 450px) {

  .stt,
  .total-part,
  .time {
    display: none;
  }
}
</style>
