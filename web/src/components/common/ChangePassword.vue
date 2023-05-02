<template>
  <AppBar />
  <v-form @submit.prevent="changePassword">
    <v-main>
      <v-card width="500" class="mx-auto mt-9 pa-2">
        <v-card-title class="mb-3">Đổi mật khẩu</v-card-title>
        <v-card-text>
          <v-text-field density="comfortable" label="Mã xác thực" prepend-icon="mdi-account-check"
            v-model="confirmCode" />
          <v-text-field class="mt-2" density="comfortable" label="Mật khẩu mới" type="password" v-model="newPassword"
            prepend-icon="mdi-lock" messages="* Mật khẩu ít nhất 6 ký tự." :rules="passwordRules" />
          <v-text-field class="mt-2" density="comfortable" label="Xác nhận mật khẩu mới" type="password"
            v-model="confirmNewPassword" prepend-icon="mdi-lock-check" messages="* Mật khẩu ít nhất 6 ký tự."
            :rules="passwordRules" />
        </v-card-text>
        <v-alert class="alert" v-if="showAlert" type="error" v-model="error">
          {{ error }}
        </v-alert>
        <v-card-actions>
          <v-btn class="ml-5" color="red-darken-3" @click="cancelBtn()">
            Hủy
          </v-btn>
          <v-spacer />
          <v-btn class="mr-5" type="submit" @click="changePassword()" color="indigo-darken-3">
            Xác nhận
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-main>
  </v-form>
</template>
<script setup>
import { ref, onMounted, computed } from "vue";
import _ from "lodash";
import { useRoute, useRouter } from "vue-router";
import api from "@/plugins/url";
import AppBar from "@/components/common/AppBar";
import { useStore } from "@/components/store/store";
import { useRules } from "../store/rules";

const route = useRoute();
const router = useRouter();

const store = useStore();
const { user, getUser } = store;
const confirmCode = ref("");
const newPassword = ref("");
const confirmNewPassword = ref("");
const rules = useRules();
const { passwordRules } = rules;
const showAlert = ref(false);
const error = ref("");

const changePassword = () => {
  try {
    const rawInfo = JSON.parse(JSON.stringify(user.value));
    if (rawInfo.code !== confirmCode.value) {
      showAlert.value = true;
      error.value = "Mã xác thực không chính xác!";
      return;
    }
    if (newPassword.value !== confirmNewPassword.value) {
      showAlert.value = true;
      error.value = "Mật khẩu xác nhận không chính xác!";
      return;
    }
    showAlert.value = false;
    error.value = "";
    if (newPassword.value.length < 6 && confirmNewPassword.value.length < 6)
      return;
    const param = _.omit(rawInfo, "id");
    param["password"] = newPassword.value;
    param["code"] = null;
    api.patch(`/api/users/${rawInfo.id}`, param);
    router.replace("/login");
    ce;
  } catch (e) {
    error.value = "Giá trị không hợp lệ";
  }
};

const cancelBtn = () => {
  const rawInfo = JSON.parse(JSON.stringify(user.value));
  const respone = confirm(
    "Nếu bạn hủy mã xác thực sẽ mất hiệu lực. Bạn có muốn tiếp tục?"
  );
  // cancel -> respone = false
  console.log(respone);

  if (respone) {
    const param = _.omit(rawInfo, "id");
    param["code"] = null;
    api.patch(`/api/users/${rawInfo.id}`, param);
    router.replace("/login");
  }
};

onMounted(() => {
  getUser(route.query.userId);
});
</script>
<style>
/* .login-btn {
    background-color: #283c74;
    color: white;
    text-transform: none;
    padding: 0 12px;
    margin-right: 12px;
  } */
.v-card-actions {
  justify-content: end;
}

.changeAction {
  cursor: pointer;
}
</style>
