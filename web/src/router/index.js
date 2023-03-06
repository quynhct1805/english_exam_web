import { createRouter, createWebHistory } from "vue-router";

const routes = [
  {
    path: "/",
    name: "FirstPage",
    component: () => import("@/components/common/FirstPage"),
  },
  {
    path: "/home",
    name: "Home",
    component: () => import("@/components/common/Home"),
  },
  {
    path: "/tests",
    name: "ListTest",
    component: () => import("@/components/user/ListTest"),
    // props: router => ({id: router.params.id})
  },
  {
    path: "/tests/:testId",
    name: "InfoTest",
    component: () => import("@/components/user/InfoTest"),
    props: (router) => ({ id: router.params.testId }),
  },
  {
    path: "/documentations",
    name: "Documentation",
    component: () => import("@/components/user/Documentation"),
    // props: router => ({id: router.params.id})
  },
  {
    path: "/documentations/:documentationId",
    name: "InfoDocumentation",
    component: () => import("@/components/user/InfoDocumentation"),
    props: (router) => ({ id: router.params.documentationId }),
  },
  {
    path: "/tests/:testId/testing",
    name: "Testing",
    component: () => import("@/components/user/Test"),
    props: (router) => ({ id: router.params.testId }),
  },
  {
    path: "/login",
    name: "Login",
    component: () => import("@/components/common/Login"),
    // props: router => ({id: router.params.id})
  },
  {
    path: "/forgotpassword",
    name: "ForgotPassword",
    component: () => import("@/components/common/ForgotPassword"),
    // props: router => ({id: router.params.id})
  },
  {
    path: "/changepassword",
    name: "ChangePassword",
    component: () => import("@/components/common/ChangePassword"),
    // props: (router) => ({ userId: router.params.userId }),
  },
  {
    path: "/admin/tests",
    name: "ManageTest",
    component: () => import("@/components/admin/ManageTest"),
    // props: (router) => ({ id: router.params.id }),
  },
  {
    path: "/admin/tests/:testId",
    name: "ManageDetailTest",
    component: () => import("@/components/admin/ManageDetailTest"),
    props: (router) => ({ id: router.params.testId }),
  },
  {
    path: "/admin/documentations",
    name: "ManageDocumentation",
    component: () => import("@/components/admin/ManageDocumentation"),
    // props: (router) => ({ id: router.params.id }),
  },
  {
    path: "/admin/documentations/:documentationId",
    name: "ManageDetailDocumentation",
    component: () => import("@/components/admin/ManageDetailDocumentation"),
    props: (router) => ({ id: router.params.documentationId }),
  },
  {
    path: "/admin/users",
    name: "ManageUser",
    component: () => import("@/components/admin/ManageUser"),
    // props: (router) => ({ id: router.params.id }),
  },
  {
    path: "/admin/users/:userId",
    name: "ManageDetailUser",
    component: () => import("@/components/admin/ManageDetailUser"),
    props: (router) => ({ id: router.params.userId }),
  },
  {
    path: "/admin/categories",
    name: "ManageCategory",
    component: () => import("@/components/admin/ManageCategory"),
    // props: (router) => ({ id: router.params.id }),
  },
  {
    path: "/profile/:userId",
    name: "ProfilePage",
    component: () => import("@/components/common/Profile"),
    props: (router) => ({ id: router.params.userId }),
  },
  {
    path: "/history/:historyId",
    name: "HistoryDetail",
    component: () => import("@/components/user/HistoryTest"),
    props: (router) => ({ id: router.params.historyId }),
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
