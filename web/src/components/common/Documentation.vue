<template>
  <div class="documentation-info">
    <v-card v-for="documentation in documentations">
      <v-card-title style="text-transform: uppercase">{{
        documentation.name
      }}</v-card-title>
      <v-card-text>{{ documentation.category_code }}</v-card-text>
      <v-card-text>{{ documentation.skill }}</v-card-text>
      <v-card-actions>
        <v-spacer />
        <v-btn variant="outlined" :to="{
          name: 'InfoDocumentation',
          params: { documentationId: documentation.id },
        }">
          Chi tiết
        </v-btn>
      </v-card-actions>
    </v-card>
  </div>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";

const categories = ref([]);
const documentations = ref([]);
const router = useRouter();
const role = ref(localStorage.role);


onMounted(() => {
  api.get("/api/documentations").then((res) => {
    if (
      (["Home", "FirstPage"].includes(router.currentRoute.value.name) &&
        role.value === "member") ||
      !role.value
    ) {
      res.data = res.data.slice(-3);
    }
    documentations.value = res.data;
  });
  api.get("/api/categories").then((res) => {
    categories.value = res.data;
  });
});
</script>

<style scoped>

.documentation-info {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
}

.documentation-info .v-card {
  /* width: 20%; */
  margin: 0 32px;
  margin-bottom: 28px;
  transition: transform .4s;
}

@media only screen and (max-width: 1280px) {
  .documentation-info {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }
}

@media only screen and (max-width: 960px) {
  .documentation-info {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
  .documentation-info .v-card {
    margin: 0 40px;
    margin-bottom: 28px;
  }
}

@media only screen and (max-width: 600px) {
  .documentation-info {
    grid-template-columns: repeat(1, minmax(0, 1fr));
  }
  .documentation-info .v-card {
    margin: 0 60px;
    margin-bottom: 28px;
  }
}

.documentation-info .v-card:hover {
  /* background-color: rgb(200, 213, 185, 0.1); */
  background-color: white;
  transform: scale(1.1);
}

.v-card-text {
  padding: 8px 16px;
}

.v-card-actions {
  color: #4a7c59;
}
</style>
