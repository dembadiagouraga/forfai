import { lazy } from 'react';

const RestaurantRoutes = [
  {
    path: 'report',
    component: lazy(() => import('views/report')),
  },
  {
    path: 'report/products',
    component: lazy(() => import('views/report/products')),
  },
  {
    path: 'report/users',
    component: lazy(() => import('views/report/users')),
  },
];

export default RestaurantRoutes;
