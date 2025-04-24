import { lazy } from 'react';

const UsersRoutes = [
  {
    path: 'users/admin',
    component: lazy(() => import('views/users')),
  },
  {
    path: 'users/user/:id',
    component: lazy(() => import('views/users/details')),
  },
  {
    path: 'users/role',
    component: lazy(() => import('views/users/roles')),
  },
  {
    path: 'user/add/:role',
    component: lazy(() => import('views/users/add')),
  },
  {
    path: 'user/:uuid',
    component: lazy(() => import('views/users/edit')),
  },
  {
    path: 'user-clone/:uuid',
    component: lazy(() => import('views/users/clone')),
  },
  {
    path: 'wallets',
    component: lazy(() => import('views/wallet')),
  },
];

export default UsersRoutes;
