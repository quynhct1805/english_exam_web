import { createRouter, createWebHistory } from "vue-router";
import Home from "./components/Home";
// import ListBooks from './view/user/ListBooks'
// import DetailBook from './view/user/DetailBook'
// import ManageBooks from './view/admin/ManageBooks'
// import ManageDetailBook from './view/admin/ManageDetailBook'
// import ManageCategories from './view/admin/ManageCategories'

const routes = [
  {
    path: "/admin/",
    component: Home,
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
  //   {
  //     path: '/book/:id',
  //     component: DetailBook,
  //     name: "DetailBook",
  //     props: router => ({id: router.params.id})
  //   },
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
