import { ref, Ref, getCurrentInstance, toRaw } from "vue";
import api from "@/plugins/url";

interface User {
  id: number;
  name: string;
  phone: string;
  email: string;
}

export function useStore() {
  const vm = getCurrentInstance();
  const users: Ref<User[]> = ref([]);
  const user: Ref<User> = ref(null);
  const loadInfo = ref(false);
  const userId = ref();
  // console.log(userId);
  //   const iconsProduct = ref([]);
  //   const panels = ref([]);
  //   const iconTargeted = ref(null);
  //   const selectedPort = ref(null);
  //   const availablePorts = computed(() => {
  //     return al.value.ports;
  //   });
  //   const expanded = ref(null);
  //   const loading = ref(false);
  //   const listItemInCart = ref({});
  //   const loadPanel = ref(false);
  //   const loadInfo = ref(false);
  //   const viewMode = ref("");
  //   const viewModeDefault = ref("");
  //   const showTextSuccess = ref(false);
  //   const isExpired = computed(() => {
  //     const availableUntil = new Date(al.value.available_until);
  //     const now = new Date();
  //     return now > availableUntil;
  //   });
  const skill = ref(["Listening", "Reading", "Writing", "Speaking"]);

  const getUsers = async () => {
    loadInfo.value = true;
    try {
      const res = await api.get(`/api/users`);
      users.value = res.data;
    } finally {
      loadInfo.value = false;
    }
  };

  const getUser = (params: number) => {
    loadInfo.value = true;
    userId.value = params;
    return api
      .get(`/api/users/${params}`)
      .then((res) => {
        user.value = res.data;
      })
      .finally(() => {
        loadInfo.value = false;
      });
  };

  // for (let index = 1; index < arguments.length; index++) {
  //   const nextSource = arguments[index]
  //   if (nextSource != null) {
  //     for (const nextKey in nextSource) {
  //       if (Object.prototype.hasOwnProperty.call(nextSource, nextKey)) {
  //         to[nextKey] = nextSource[nextKey]
  //       }
  //     }
  //   }
  // }

  return { user, getUser, skill, getUsers, users };
}
