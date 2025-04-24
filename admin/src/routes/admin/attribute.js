import { lazy } from 'react';

const AttributeRoutes = [
  {
    path: 'attributes',
    component: lazy(() => import('views/attribute')),
  },
  {
    path: 'attributes/create',
    component: lazy(() => import('views/attribute/create')),
  },
  {
    path: 'attributes/create-many',
    component: lazy(() => import('views/attribute/create-many')),
  },
  {
    path: 'attributes/edit/:id',
    component: lazy(() => import('views/attribute/edit')),
  },
];

export default AttributeRoutes;
