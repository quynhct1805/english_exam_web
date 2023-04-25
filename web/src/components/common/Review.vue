<template>
  <v-card class="mt-4">
    <div class="ms-4 pt-4">
      <strong>Bình luận</strong>
    </div>
    <!-- <div>{{ comments }}</div>
    <div>{{ countCmt }}</div>
    <div>{{ newCmt }}</div> -->
    <div>
      <v-banner lines="two">
        <div>
          <v-textarea
            v-model="newCmt.comment"
            placeholder="Viết đánh giá"
            auto-grow
            rows="1"
            variant="underlined"
            row-height="15"
          ></v-textarea>

          <v-rating
            v-model="newCmt.rate_stars"
            size="x-small"
            half-increments
            active-color="#0e274c"
          ></v-rating>
        </div>

        <v-banner-actions color="#0e274c">
          <v-btn>Huy</v-btn>
          <v-btn variant="tonal" @click="saveCmt()">Binh luan</v-btn>
        </v-banner-actions>
      </v-banner>
    </div>
    <v-list-item class="comment" v-for="comment in comments" :key="comment">
      <div>
        <h5>
          {{ comment.user }}
          <span class="time">{{ comment.updated_at }}</span>
        </h5>
        <v-rating
          size="x-small"
          half-increments
          v-model="comment.rate_stars"
          active-color="#0e274c"
          readonly
        ></v-rating>
        <v-card-text class="pt-0 pb-4">{{ comment.comment }}</v-card-text>
      </div>
    </v-list-item>
  </v-card>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";

// const props = defineProps({
//   items: { type: Object, required: false },
// });

const comments = ref([]);
const countCmt = ref();
// const tests = ref([]);

const route = useRoute();
// const role = ref(localStorage.role);

const newCmt = ref({ comment: "new", rate_stars: 0 });

function saveCmt() {
  console.log(JSON.parse(JSON.stringify(newCmt.value)));
}

onMounted(() => {
  api.get(`/api/tests/${(route, route.params.testId)}/reviews`).then((res) => {
    comments.value = res.data;
    countCmt.value = res.data.length;
  });
});
</script>

<style scoped>
.comment span.time {
  color: gray;
  font-style: oblique;
  font-weight: 400;
}
</style>
