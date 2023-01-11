import { createRouter, createWebHistory } from "vue-router";
import Home from "../components/Home.vue";
import ListTests from "../components/ListTests.vue";

// const routes = [
//   { path: "/", component: Home },
//   // { path: '/about', component: About },
// ];

const routes = [
  {
    path: "/",
    component: () => import("../components/Home"),
    name: "Home",
    // children: [
    //   {
    //     path: ':id?',
    //     component: ListBooks,
    //     name: "ListBooks",
    //     props: router => ({category_id: router.params.id}),
    //     alias: '/'
    //   },
    // ]
  },
  {
    path: "/tests",
    component: () => import("../components/ListTests"),
    name: "ListTests",
    // props: router => ({id: router.params.id})
  },
  //   {
  //     path: '/admin/books',
  //     component: ManageBooks,
  //     name: "ManageBooks",
  //   },
  //   {
  //     path: '/admin/book/:id?',
  //     component: ManageDetailBook,
  //     name: "ManageDetailBook",
  //     props: router => ({id: router.params.id})
  //   },
  //   {
  //     path: '/admin/categories',
  //     component: ManageCategories,
  //     name: "ManageCategories",
  //   }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
