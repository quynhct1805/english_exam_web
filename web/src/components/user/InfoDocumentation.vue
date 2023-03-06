<template>
  <AppBar />
  <v-layout>
    <div>
      <audio controls class="pb-10">
        <source
          src="@/assets/audio/CD1/01-AudioTrack 01.mp3"
          type="audio/mp3"
        />
      </audio>
    </div>

    <!-- <AudioPlayer 
      class="audio" 
      :option="{
        :src:"@/assets/audio/01-AudioTrack 01.mp3"
      }" 
    /> -->
    <!-- <div class="main">
    </div> -->
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import AppBar from "@/components/common/AppBar";

// const props = defineProps({
//   id: String,
// });
// const parts = ref([]);
// const test = ref({});

// const page = ref("info");
// const questions = ref([]);
// // console.log(props.id);
// // const defaultFilteredCategory = ref("all");

// onMounted(() => {
//   api.get(`/api/tests/${props.id}`).then((res) => {
//     // console.log(res.data);
//     test.value = res.data;
//   });
//   api.get(`/api/tests/${props.id}/parts`).then((res) => {
//     for (const part of res.data) {
//       api.get(`/api/parts/${part.id}/questions`).then((res) => {
//         // for (const question of res.data) questions.value.push(question);
//         part["questions"] = res.data;
//       });
//     }
//     parts.value = res.data;
//   });
// });

// const loaded = ref(false);
// const loading = ref(false);

// const onClick = () => {
//   loading = true;
// };

const items = ref(["Luyện tập", "Làm full test", "Bình luận"]);
</script>

<style scoped>
.audio .audio__player-play-and-title {
  display: none;
}
</style>
