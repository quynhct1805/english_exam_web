import { ref, Ref, getCurrentInstance, toRaw } from "vue";
import api from "@/plugins/url";

interface User {
  id: number;
  name: string;
  phone: string;
  email: string;
  histories: [];
}

interface Documentation {
  id: number;
  name: string;
  skill: string;
  category_id: number;
  category_code: string;
  description: string;
  files: [];
}

interface Category {
  id: number;
  code: string;
  name: string;
  description: string;
}

interface Test {
  id: number;
  name: string;
  category_code: string;
  skill: string;
  time: number;
  total_part: number;
  total_ques: number;
}

export function useStore() {
  const documentations: Ref<Documentation[]> = ref([]);
  const categories: Ref<Category[]> = ref([]);
  const users: Ref<User[]> = ref([]);
  const user: Ref<User> = ref();
  const tests: Ref<Test[]> = ref([]);

  const skill = ref(["Listening", "Reading", "Writing", "Speaking"]);

  const getUsers = async () => {
    const res = await api.get(`/api/users`);
    users.value = res.data;
  };

  const getUser = (userId: number) => {
    console.log(userId);
    api.get(`/api/users/${userId}`).then((res) => {
      user.value = res.data;
    });
  };

  const getDocumentations = () => {
    api.get("/api/documentations").then((res) => {
      documentations.value = res.data;
    });
  };
  const getCategories = () => {
    api.get("/api/categories").then((res) => {
      categories.value = res.data;
      // console.log(res.data);
    });
  };

  const getTests = () => {
    api.get("/api/tests").then((res) => {
      tests.value = res.data;
    });
  };

  return {
    users,
    user,
    skill,
    getUser,
    getUsers,
    documentations,
    getDocumentations,
    categories,
    getCategories,
    tests,
    getTests,
  };
}
