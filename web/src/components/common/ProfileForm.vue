<template>
  <v-form @submit.prevent>
    <v-card class="update-profile-form">
      <v-card-title> Chỉnh sửa thông tin cá nhân </v-card-title>
      <v-divider />
      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="12">
              <v-text-field
                v-model="profile.name"
                label="Tên người dùng *"
                clearable
                variant="underlined"
                :rules="textRules"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="profile.phone"
                label="Số điện thoại *"
                clearable
                variant="underlined"
                :rules="phoneRules"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="profile.email"
                label="Email *"
                clearable
                variant="underlined"
                :rules="emailRules"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                type="password"
                v-model="oldPassword"
                label="Mật khẩu cũ"
                variant="underlined"
                :rules="passwordRules"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                type="password"
                v-model="newPassword"
                label="Mật khẩu mới"
                persistent-hint
                variant="underlined"
                :rules="passwordRules"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                type="password"
                v-model="confirmNewPassword"
                label="Xác nhận mật khẩu mới"
                persistent-hint
                variant="underlined"
                :rules="passwordRules"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>

      <v-alert class="alert" v-if="showAlert" type="error">
        {{ error }}
      </v-alert>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="blue darken-4" text @click="emit('changeProfile', false)">
          Hủy
        </v-btn>
        <v-btn color="#4a7c59" text @click="handledClickSave"> Lưu </v-btn>
      </v-card-actions>
    </v-card>
  </v-form>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from "vue";
import _ from "lodash";
import api from "@/plugins/url";
import { useStore } from "@/components/store/store";
import { useRules } from "@/components/store/rules";

const props = defineProps({
  profileInfo: Object,
});

const store = useStore();
const { users, getUsers } = store;
const rules = useRules();
const { textRules, emailRules, phoneRules, passwordRules } = rules;
const profile = ref(_.cloneDeep(JSON.parse(JSON.stringify(props.profileInfo))));

const showAlert = ref(false);
const error = ref("");

const oldPassword = ref();
const newPassword = ref();
const confirmNewPassword = ref();

const emit = defineEmits(["changeProfile"]);

onMounted(() => {
  getUsers();
});

const updateUser = (param) => {
  console.log(profile.value.id);
  api.patch(`/api/users/${profile.value.id}`, param).then((res) => {
    console.log(res.data);
    // tests.value = res.data;
  });
};

function handledClickSave() {
  showAlert.value = false;
  error.value = "";
  const oldProfileInfo = JSON.parse(JSON.stringify(props.profileInfo));
  const param = JSON.parse(JSON.stringify(profile.value));

  const checkInfoUpdate = (key, errorMessage) => {
    if (!_.isEqual(oldProfileInfo[key], param[key])) {
      for (const user of JSON.parse(JSON.stringify(users.value))) {
        if (user[key] === param[key]) {
          showAlert.value = true;
          error.value = errorMessage;
          return;
        }
      }
    }
  };
  for (const key in param) {
    if (key === "name") checkInfoUpdate("name", "Tên người dùng đã tồn tại!");
    if (key === "email") checkInfoUpdate("email", "Email đã tồn tại!");
  }
  if (
    !!oldPassword.value &&
    !_.isEqual(oldProfileInfo["password"], oldPassword.value)
  ) {
    console.log(oldProfileInfo["password"], oldPassword.value);
    showAlert.value = true;
    error.value = "Mật khẩu cũ không chính xác!";
    return;
  }
  if (!!newPassword.value && newPassword.value.length < 6) {
    showAlert.value = true;
    error.value = "Nhập lại mật khẩu mới";
    return;
  }
  if (
    (!!newPassword.value || !!confirmNewPassword.value) &&
    !_.isEqual(newPassword.value, confirmNewPassword.value)
  ) {
    console.log(newPassword.value, confirmNewPassword.value);
    showAlert.value = true;
    error.value = "Xác nhận mật khẩu mới không khớp!";
    return;
  }
  if (
    !oldPassword.value &&
    (!!newPassword.value || !!confirmNewPassword.value)
  ) {
    showAlert.value = true;
    error.value = "Nhập mật khẩu cũ để đổi mật khẩu!";
    return;
  }
  if (_.isEmpty(param) || !param.name || !param.phone || !param.email) {
    showAlert.value = true;
    error.value = "Vui lòng nhập thông tin bắt buộc!";
    return;
  }
  if (!!newPassword.value) param.password = newPassword.value;
  console.log(param);
  updateUser(param);
  if (!!newPassword.value) param.password = newPassword.value;

  emit("changeProfile", false);
}
</script>

<style scoped>
.update-profile-form {
  width: 500px;
}
.update-profile-form .v-card-title {
  text-transform: uppercase;
}
.v-row .v-col-12 {
  padding: 0 12px;
}
</style>
