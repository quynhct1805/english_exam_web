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
  </div>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";

const categories = ref([]);
const documentations = ref([]);
const router = useRouter();

onMounted(() => {
  api.get("/api/documentations").then((res) => {
    if (["Home", "FirstPage"].includes(router.currentRoute.value.name)) {
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
  display: flex;
  margin-top: 40px;
  padding: 0 20px;
  justify-content: start;
  flex-wrap: wrap;
}
.documentation-info .v-card {
  width: 28%;
  margin: 0 19px;
  margin-bottom: 20px;
  transition: transform .4s;
}

.documentation-info .v-card:hover {
  background-color: rgb(200, 213, 185, 0.1);
  transform: scale(1.1);
}

.v-card-text {
  padding: 8px 16px;
}
.v-card-actions {
  color: #4a7c59;
}
</style>
