<template>
  <v-form @submit.prevent>
    <v-card class="update-test-form">
      <v-card-title v-if="action === 'add'">
        Thêm tài khoản người dùng
      </v-card-title>
      <v-card-title v-else>Sửa tài khoản người dùng</v-card-title>
      <v-divider />
      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="12" md="6">
              <v-text-field
                v-model="user.name"
                label="Tên người dùng *"
                clearable
                variant="underlined"
                :rules="textRules"
                :readonly="action === 'edit' ? true : false"
              ></v-text-field>
            </v-col>
            <v-col cols="12" md="6">
              <v-text-field
                v-if="action === 'add'"
                type="password"
                v-model="user.password"
                label="Mật khẩu *"
                clearable
                variant="underlined"
                :rules="passwordRules"
                :readonly="action === 'edit' ? true : false"
              ></v-text-field>
            </v-col>
            <v-col cols="12" md="6">
              <v-text-field
                v-model="user.email"
                label="Email *"
                clearable
                variant="underlined"
                :rules="emailRules"
                :readonly="action === 'edit' ? true : false"
              ></v-text-field>
            </v-col>
            <v-col cols="12" md="3">
              <v-text-field
                v-model="user.phone"
                label="Số điện thoại *"
                clearable
                variant="underlined"
                :rules="phoneRules"
                :readonly="action === 'edit' ? true : false"
              ></v-text-field>
            </v-col>
            <v-col cols="12" md="3">
              <v-select
                v-model="user.role"
                :items="role"
                label="Vai trò *"
                clearable
                variant="underlined"
                :rules="textRules"
              ></v-select>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>

      <v-alert class="alert" v-if="showAlert" type="error">
        {{ error }}
      </v-alert>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="blue darken-4" text @click="emit('changeUser', false)">
          Hủy
        </v-btn>
        <v-btn color="#62311a" text @click="handledClickSave"> Lưu </v-btn>
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
  userInfo: Object,
  action: String,
});

const store = useStore();
const rules = useRules();
const { textRules, emailRules, phoneRules, passwordRules } = rules;
const user = ref(_.cloneDeep(JSON.parse(JSON.stringify(props.userInfo))));
const role = ref(["admin", "member"]);

const showAlert = ref(false);
const error = ref("");

const emit = defineEmits(["changeUser", "infoNewUser"]);

// onMounted(() => {
//   api.get("/api/categories").then((res) => {
//     categories.value = res.data;
//   });
// });

const createUser = (param) => {
  api.post(`/api/users`, param).then((res) => {
    console.log(res.data);
    if (res.data.code === 400) {
      showAlert.value = true;
      error.value = res.data.message;
      return;
    }
    Object.assign(param, res.data);
    emit("infoNewUser", param);
  });
};

const updateUser = (param) => {
  console.log(user);
  api.patch(`/api/users/${user.value.id}`, param).then((res) => {
    console.log(res.data);
    Object.assign(param, res.data);
    emit("infoNewDoc", param);
  });
};

function handledClickSave() {
  const param = JSON.parse(JSON.stringify(user.value));
  if (
    _.isEmpty(param) ||
    !param.name ||
    !param.phone ||
    !param.email ||
    !param.role
  ) {
    showAlert.value = true;
    error.value = "Vui lòng nhập thông tin bắt buộc!";
    return;
  } else {
    console.log(param);
    if (props.action === "add") createUser(param);
    else updateUser(param);
    emit("changeUser", false);
  }
}
</script>

<style scoped>
.update-test-form {
  width: 800px;
}
.update-test-form .v-card-title {
  text-transform: uppercase;
}
.v-row .v-col-12 {
  padding: 0 12px;
}
</style>
