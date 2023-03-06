<template>
  <AppBar />
  <v-layout>
    <!-- <span>List test</span> -->
    <div class="main manage-test">
      <div class="content-header">
        <v-container style="display: flex; margin-bottom: 12px">
          <v-btn
            variant="outlined"
            color="success"
            @click="
              (openDialog = true),
                (action = 'add'),
                (userInfo = Object.assign({}, {}))
            "
          >
            Thêm
          </v-btn>
        </v-container>
      </div>

      <v-table class="manage-user" :key="users.length">
        <v-row class="title">
          <v-col class="text-center" cols="1">STT</v-col>
          <v-col class="text-center">Tên tài khoản</v-col>
          <v-col class="text-center" cols="2">Số điện thoại</v-col>
          <v-col class="text-center" cols="3">Email</v-col>
          <v-col class="text-center" cols="2">Vai trò</v-col>
          <v-col class="text-center" cols="1"></v-col>
        </v-row>
        <v-divider></v-divider>

        <v-row class="content" v-for="(user, index) in users" :key="user.id">
          <router-link
            :to="{ name: 'ManageDetailUser', params: { userId: user.id } }"
          >
            <v-col class="text-center" cols="1">{{ index + 1 }}</v-col>
            <v-col class="text-center">{{ user.name }}</v-col>
            <v-col class="text-center" cols="2">{{ user.phone }}</v-col>
            <v-col class="text-center" cols="3">{{ user.email }}</v-col>
            <v-col class="text-center" cols="2">{{ user.role }}</v-col>
          </router-link>
          <v-col class="text-center" cols="1">
            <v-btn
              color="warning"
              @click="
                (openDialog = true),
                  (action = 'edit'),
                  (userInfo = Object.assign({}, user))
              "
              icon="mdi-pencil-outline"
              size="small"
              variant="text"
            ></v-btn>
            <v-btn
              color="error"
              icon="mdi-delete"
              size="small"
              variant="text"
              @click="deleteUser(user.id)"
            ></v-btn>
          </v-col>
        </v-row>
      </v-table>
    </div>
    <v-dialog v-model="openDialog" persistent>
      <UserForm
        class="form"
        :action="action"
        :user-info="userInfo"
        @changeUser="(res) => (openDialog = res)"
      />
    </v-dialog>
  </v-layout>
</template>

<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import AppBar from "@/components/admin/AppBar";
import UserForm from "./UserForm.vue";
import { useStore } from "@/components/store/store";

const categories = ref([]);
const store = useStore();
const { users, getUsers } = store;

const openDialog = ref(false);
const action = ref("");
const userInfo = ref({});

const deleteUser = (userId) => {
  api.delete(`/api/users/${userId}`).then((res) => console.log(res));
};

onMounted(() => {
  getUsers();
});

const loaded = ref(false);
const loading = ref(false);

const onClick = () => {
  loading.value = true;
};
</script>

<style scoped>
.main {
  width: 80%;
  margin: 0px auto;
  padding: 20px 0;
}
.content-header {
  width: 80%;
  margin: 0px auto;
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
.v-row.title,
.content {
  width: 100%;
  margin-top: 2px;
}
.v-btn--icon {
  height: 24px;
  width: 24px;
  margin-right: 4px;
}
.v-divider {
  margin-top: 8px;
}
</style>
