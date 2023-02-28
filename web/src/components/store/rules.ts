import { ref, Ref, getCurrentInstance, toRaw } from "vue";
import api from "@/plugins/url";

export function useRules() {
  const emailRules = ref([
    (value) => {
      if (/.+@.+\..+/.test(value)) return true;
      return "Email không hợp lệ (Vd: name@gmail.com).";
    },
  ]);

  const phoneRules = ref([
    (value) => {
      if (value.length > 9) return true;
      return "Số điện thoại không hợp lệ (Vd: 0982147569).";
    },
  ]);

  const passwordRules = ref([
    (value) => {
      if (value.length > 5) return true;
      return "Mật khẩu ít nhất 6 ký tự.";
    },
  ]);

  const textRules = ref([
    (value) => {
      if (!!value) return true;
      return "Bắt buộc điền thông tin.";
    },
  ]);

  const numberRules = ref([
    (value) => {
      if (value < 0) return "Giá trị cần nhập phải > 0";
      if (!!value) return true;
      if (typeof value !== "number") return "Điền số.";
      return "Bắt buộc điền thông tin.";
    },
  ]);

  const fileRules = ref([
    (value) => {
      if (
        !!value ||
        (value && value[0].size > 0 && value[0].size < 5000000) ||
        !!value.length
      )
        return true;
      return "Bắt buộc điền thông tin.";
    },
  ]);

  return {
    emailRules,
    phoneRules,
    passwordRules,
    textRules,
    numberRules,
    fileRules,
  };
}
