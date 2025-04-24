// ** React Imports
import { lazy } from 'react';

const VacancyCategoryRoutes = [
  {
    path: 'catalog/vacancyCategories',
    component: lazy(() => import('views/vacancyCategories')),
  },
  {
    path: 'vacancy-category/add',
    component: lazy(() =>
      import('views/vacancyCategories/vacancyCategory-add')
    ),
  },
  {
    path: 'vacancy-category/:uuid',
    component: lazy(() => import('views/vacancyCategories/category-edit')),
  },
  {
    path: 'vacancy-category/show/:uuid',
    component: lazy(() => import('views/vacancyCategories/category-show')),
  },
  {
    path: 'vacancy-category-clone/:uuid',
    component: lazy(() => import('views/vacancyCategories/category-clone')),
  },
  {
    path: 'vacancy-catalog/categories/import',
    component: lazy(() => import('views/vacancyCategories/category-import')),
  },
];

export default VacancyCategoryRoutes;
