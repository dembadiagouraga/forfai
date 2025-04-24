// ** React Imports
import { lazy } from 'react';

const ProductRoutes = [
  {
    path: 'products',
    component: lazy(() => import('views/products')),
  },
  {
    path: 'product/add',
    component: lazy(() => import('views/products/add')),
  },
  {
    path: 'product/:uuid',
    component: lazy(() => import('views/products/edit')),
  },
  {
    path: 'product-clone/:uuid',
    component: lazy(() => import('views/products/clone')),
  },
  {
    path: 'product/import',
    component: lazy(() => import('views/products/import')),
  },
];

export default ProductRoutes;
