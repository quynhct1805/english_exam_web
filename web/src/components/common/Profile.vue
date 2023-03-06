<template>
  <AppBar />
  <v-layout>
    <div class="main manage-profile" v-if="!!user">
      <v-card class="cover mx-auto rounded-lg" max-width="800" height="200">
        <v-img
          height="100%"
          cover
          src="https://cdn.vuetifyjs.com/images/cards/server-room.jpg"
        >
        </v-img>
      </v-card>
      <div class="avatar">
        <v-avatar class="rounded-circle" color="grey" size="150" rounded="0">
          <v-img
            cover
            src="https://cdn.vuetifyjs.com/images/profiles/marcus.jpg"
          ></v-img>
        </v-avatar>
        <v-btn
          class="edit-btn"
          icon="mdi-pencil"
          @click="(openDialog = true), (profileInfo = Object.assign({}, user))"
        ></v-btn>
      </div>
      <div class="user-name text-h4">{{ user.name }}</div>
      <div class="histories">
        <div class="text-h6">Kết quả luyện thi</div>
        <v-table class="mt-3">
          <v-row class="title">
            <v-col class="text-center">Đề</v-col>
            <v-col class="text-center" cols="2">Kết quả</v-col>
            <v-col class="text-center" cols="3">Thời gian làm (s)</v-col>
            <v-col class="text-center" cols="2">Ngày làm</v-col>
          </v-row>
          <v-divider></v-divider>

          <v-row
            class="content"
            v-for="(history, index) in user.histories"
            :key="index"
          >
            <router-link
              :to="{ name: 'HistoryDetail', params: { historyId: history.id } }"
            >
              <v-col class="text-center">{{ history.test }}</v-col>
              <v-col class="text-center" cols="2">{{ history.grade }}</v-col>
              <v-col class="text-center" cols="3">{{ history.time }}</v-col>
              <v-col class="text-center" cols="2">
                {{ history.created_at }}
              </v-col>
            </router-link>
          </v-row>
        </v-table>
      </div>
    </div>
    <v-dialog v-model="openDialog" persistent>
      <ProfileForm
        class="form"
        :profile-info="profileInfo"
        @changeProfile="(res) => (openDialog = res)"
      />
    </v-dialog>
  </v-layout>
</template>

<script setup>
import { ref, onMounted } from "vue";
import api from "@/plugins/url";
import AppBar from "@/components/admin/AppBar";
import { useStore } from "@/components/store/store";
import ProfileForm from "@/components/common/ProfileForm";

const props = defineProps({
  id: String,
});

const store = useStore();
const { user, getUser } = store;
// console.log(props.id);

const openDialog = ref(false);
const profileInfo = ref({});

onMounted(() => {
  getUser(props.id);
});
</script>

<style scoped>
.v-layout {
  background-color: white;
  margin-top: 16px;
}
.main {
  width: 800px;
  margin: 0px auto;
  padding: 20px 0;
}

.v-btn--icon {
  height: 36px;
  width: 36px;
  margin-right: 4px;
}

.v-avatar {
  margin-left: 50%;
  margin-top: -12%;
  transform: translate(-50%, 0);
}
.avatar {
  display: flex;
  margin: -6.3rem auto 0.5rem;
  position: relative;
  width: 7.875rem;
  height: 7.875rem;
  border: 0.1875rem solid #fff;
  border-radius: 50%;
}
.edit-btn {
  position: absolute;
  bottom: -20px;
  right: -12px;
}
.user-name {
  text-align: center;
  margin-top: 20px;
  font-weight: 500;
  margin-bottom: 24px;
}
.v-row.title {
  font-weight: bold;
}
.v-divider {
  margin-top: 8px;
  margin-bottom: 8px;
}
.v-row a {
  display: contents;
  color: black;
}
</style>
