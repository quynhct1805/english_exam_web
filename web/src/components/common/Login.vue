<template>
  <AppBar />
  <v-form @submit.prevent="action === 'login' ? login : signup">
    <v-main>
      <template v-if="action === 'login'">
        <v-card width="500" class="mx-auto mt-9 pa-2">
          <v-card-title class="mb-3">ĐĂNG NHẬP</v-card-title>
          <v-card-text>
            <v-text-field
              density="comfortable"
              label="Email"
              prepend-icon="mdi-email"
              v-model="loginInfo.email"
              :rules="emailRules"
            />
            <v-text-field
              class="mt-2"
              density="comfortable"
              label="Mật khẩu"
              v-model="loginInfo.password"
              type="password"
              prepend-icon="mdi-lock"
              messages="* Mật khẩu ít nhất 6 ký tự."
              :rules="(ruleCommon, passwordRules)"
            />

            <v-checkbox
              class="save"
              density="comfortable"
              color="red"
              label="Lưu mật khẩu"
              hide-details
            ></v-checkbox>
            <router-link
              :to="{ name: 'ForgotPassword' }"
              color="indigo-darken-3"
            >
              Quên mật khẩu
            </router-link>
          </v-card-text>
          <v-alert class="alert" v-if="showAlert" type="error" v-model="error">
            {{ error }}
          </v-alert>
          <v-card-actions>
            <v-btn
              class="mr-5"
              type="submit"
              @click="login()"
              color="#4a7c59"
            >
              Đăng nhập
            </v-btn>
          </v-card-actions>
          <div class="my-2" style="text-align: center">
            <span>Bạn chưa có tài khoản? </span>
            <span
              class="changeAction"
              @click="(action = 'signup'), (showAlert = false), (error = '')"
              style="color: #4a7c59; font-weight: bold"
            >
              Đăng ký
            </span>
          </div>
        </v-card>
      </template>

      <template v-else>
        <v-card width="500" class="mx-auto mt-9 pa-2">
          <v-card-title class="mb-3">ĐĂNG KÝ</v-card-title>
          <v-card-text>
            <v-text-field
              class="mt-2"
              density="comfortable"
              label="Tên người dùng"
              prepend-icon="mdi-account"
              v-model="signupInfo.name"
              :rules="(ruleCommon, passwordRules)"
            />
            <v-text-field
              class="mt-2"
              density="comfortable"
              label="Email"
              prepend-icon="mdi-email"
              v-model="signupInfo.email"
              :rules="emailRules"
            />
            <v-text-field
              class="mt-2"
              density="comfortable"
              label="Số điện thoại"
              prepend-icon="mdi-phone"
              v-model="signupInfo.phone"
              :rules="phoneRules"
            />
            <v-text-field
              class="mt-2"
              density="comfortable"
              label="Mật khẩu"
              v-model="signupInfo.password"
              type="password"
              prepend-icon="mdi-lock"
              messages="* Mật khẩu ít nhất 6 ký tự."
            />
            <v-text-field
              class="mt-2"
              density="comfortable"
              label="Xác nhận mật khẩu"
              v-model="signupInfo.confirmPassword"
              type="password"
              prepend-icon="mdi-lock-check"
              hide-details
            />
          </v-card-text>
          <v-alert class="alert" v-if="showAlert" type="error">
            {{ error }}
          </v-alert>
          <v-card-actions>
            <v-btn
              class="mr-5"
              type="submit"
              @click="signup()"
              color="indigo-darken-3"
            >
              Đăng ký
            </v-btn>
          </v-card-actions>
          <div class="my-2" style="text-align: center">
            <span>Bạn đã có tài khoản? </span>
            <span
              class="changeAction"
              @click="action = 'login'"
              style="color: #4a7c59; font-weight: bold"
            >
              Đăng nhập
            </span>
          </div>
        </v-card>
      </template>
    </v-main>
  </v-form>
  <v-snackbar v-model="snackbar" :timeout="timeout">
    {{ noti }}
    <template v-slot:actions>
      <v-btn color="blue" variant="text" @click="snackbar = false">
        Đóng
      </v-btn>
    </template>
  </v-snackbar>
</template>
<script setup>
import { ref, onMounted, computed } from "vue";
import _ from "lodash";
import { useRouter } from "vue-router";
import api from "@/plugins/url";
import AppBar from "@/components/common/AppBar";
import { useStore } from "@/components/store/store";
import { useRules } from "../store/rules";

const router = useRouter();
const store = useStore();
const { users, getUsers } = store;
const rules = useRules();
const { emailRules, phoneRules, passwordRules } = rules;
const loginInfo = ref({
  email: "",
  password: "",
});
const showAlert = ref(false);
const error = ref("");
const action = ref("login");
const snackbar = ref(false);
const noti = ref("Đăng ký tài khoản thành công!");
const timeout = ref(2000);

const login = () => {
  try {
    const rawInfo = JSON.parse(JSON.stringify(loginInfo.value));
    if (!rawInfo.email || !rawInfo.password) {
      showAlert.value = true;
      error.value = "Vui lòng nhập thông tin!";
      return;
    }
    if (!/.+@.+\..+/.test(rawInfo.email) || rawInfo.password.length < 6) return;
    api.post("/api/login", loginInfo.value).then((res) => {
      if (res.data.code === 200) {
        localStorage.name = res.data.data.name;
        localStorage.email = res.data.data.email;
        localStorage.phone = res.data.data.phone;
        localStorage.id = res.data.data.id;
        localStorage.role = res.data.data.role;
        router.push("/home");
      } else {
        showAlert.value = true;
        error.value = "Email hoặc mật khẩu không hợp lệ!";
      }
    });
  } catch (e) {
    error.value = "Email hoặc mật khẩu không hợp lệ";
  }
};

const signupInfo = ref({
  name: "",
  email: "",
  phone: "",
  password: "",
  confirmPassword: "",
});
const signup = () => {
  console.log("sign up ");
  const rawInfo = JSON.parse(JSON.stringify(signupInfo.value));
  const rawUsers = JSON.parse(JSON.stringify(users.value));
  if (Object.values(rawInfo).includes("")) {
    showAlert.value = true;
    error.value = "Vui lòng nhập thông tin!";
    return;
  }
  if (!_.isEmpty(rawUsers)) {
    console.log(2);
    for (const user of rawUsers) {
      if (user.name === rawInfo.name) {
        showAlert.value = true;
        error.value = "Tên người dùng đã tồn tại!";
        return;
      }
      if (user.email === rawInfo.email) {
        showAlert.value = true;
        error.value = "Email đã tồn tại!";
        return;
      }
    }
  }
  if (rawInfo.password !== rawInfo.confirmPassword) {
    console.log(3);
    showAlert.value = true;
    error.value = "Xác nhận mật khẩu không đúng!";
    return;
  }
  if (
    !/.+@.+\..+/.test(rawInfo.email) ||
    rawInfo.password.length < 6 ||
    rawInfo.phone.length < 10
  )
    return;
  console.log(4);
  delete rawInfo.confirmPassword;
  console.log(rawInfo);
  showAlert.value = false;
  error.value = "";
  api.post("/api/users", rawInfo).then((res) => {
    if (res.status === 200) {
      action.value = "login";
      snackbar.value = true;
      Object.keys(signupInfo.value).forEach((key) => {
        signupInfo.value[key] = "";
      });
    }
  });
};

onMounted(() => {
  getUsers();
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
