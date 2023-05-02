<template>
  <AppBar />
  <v-card width="500" class="mx-auto mt-9 pa-5">
    <form ref="form" @submit.prevent="sendEmail">
      <div class="title">Xác thực thông tin tài khoản</div>
      <div class="mb-4">
        Vui lòng nhập email đã đăng ký tài khoản để nhận mã xác thực đổi mật
        khẩu.
      </div>
      <v-text-field
        type="email"
        name="to_mail"
        v-model="user.email"
        placeholder="Nhập email"
        label="Email"
      ></v-text-field>
      <label style="display: none">Message</label>
      <v-text-field
        v-model="result"
        name="message"
        style="display: none"
      ></v-text-field>
      <v-card-actions>
        <v-btn variant="outlined" @click="backBtn()" color="blue-grey-darken-4">
          Back
        </v-btn>
        <v-spacer />
        <v-btn
          variant="outlined"
          :disabled="!user.id"
          :to="{ name: 'ChangePassword', query: { userId: user.id } }"
          color="indigo-darken-3"
        >
          Đổi mật khẩu
        </v-btn>
        <v-btn variant="outlined" type="submit" color="success">Gửi</v-btn>
      </v-card-actions>
    </form>
  </v-card>
  <v-snackbar v-model="snackbar" :timeout="timeout">
    {{ noti }}
    <template v-slot:actions>
      <v-btn color="blue" variant="text" @click="snackbar = false">
        Đóng
      </v-btn>
    </template>
  </v-snackbar>
</template>

<script>
import { ref, getCurrentInstance, watch } from "vue";
import emailjs from "@emailjs/browser";
import api from "@/plugins/url";
import _ from "lodash";
import AppBar from "@/components/common/AppBar";
import { useRouter } from "vue-router";

export default {
  components: {
    AppBar,
  },
  setup() {
    const router = useRouter();
    const result = ref("");
    const users = ref([]);
    const user = ref({
      id: 0,
      name: "",
      phone: "",
      email: "",
      role: "",
      code: "",
    });
    const snackbar = ref(false);
    const noti = ref("Mã xác thực tài khoản đã được gửi đến email của bạn.");
    const timeout = ref(5000);

    const backBtn = () => {
      const tempUser = JSON.parse(JSON.stringify(user.value));
      // console.log(tempUser);
      if (tempUser.id > 0) {
        const respone = confirm(
          "Nếu bạn thoát mã xác thực sẽ mất hiệu lực. Bạn có muốn tiếp tục?"
        );
        // cancel -> respone = false
        console.log(respone);

        if (respone) {
          const param = _.omit(tempUser, "id");
          param["code"] = null;
          console.log(param);
          api.patch(`/api/users/${tempUser.id}`, param);
          router.back();
        }
      } else router.back();
    };

    return { result, users, user, backBtn, snackbar, noti, timeout };
  },

  methods: {
    sendEmail() {
      for (const user of JSON.parse(JSON.stringify(this.users))) {
        if (user.email === this.user.email) {
          this.user = user;
        }
      }
      const tempUser = JSON.parse(JSON.stringify(this.user));
      const param = _.omit(tempUser, "id");
      param["code"] = this.result;
      api.patch(`/api/users/${tempUser.id}`, param);
      emailjs
        .sendForm(
          "service_o30mpo7",
          "template_gkmtlzj",
          this.$refs.form,
          "3u1T_sU4lZjzA78Fo"
        )
        .then(
          (result) => {
            console.log("SUCCESS!", result.text);
          },
          (error) => {
            console.log("FAILED...", error.text);
          }
        );
      this.snackbar = true;
    },

    makeid(length) {
      //   let result = "";
      const characters =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
      const charactersLength = characters.length;
      let counter = 0;
      while (counter < length) {
        this.result += characters.charAt(
          Math.floor(Math.random() * charactersLength)
        );
        counter += 1;
      }
      //   console.log(this.result);
      return this.result;
    },
  },

  mounted() {
    this.makeid(6);
    api.get("/api/users").then((res) => {
      this.users = res.data;
      //   console.log(this.user["name"]);
    });
  },
};
</script>
<style scoped>
.title {
  font-weight: 500;
  font-size: 1.8rem;
  margin-bottom: 20px;
}
</style>
