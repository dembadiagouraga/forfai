// ** React Imports
import { lazy } from 'react';

const AppRoutes = [
  {
    path: 'dashboard',
    component: lazy(() => import('views/dashboard')),
  },
  {
    path: 'payouts',
    component: lazy(() => import('views/admin-payouts')),
  },
  {
    path: 'email/subscriber',
    component: lazy(() => import('views/email-subscribers')),
  },
  {
    path: 'subscriber',
    component: lazy(() => import('views/subscriber')),
  },
  {
    path: 'chat',
    component: lazy(() => import('views/chat')),
  },
  {
    path: 'transactions',
    component: lazy(() => import('views/transactions')),
  },
  {
    path: 'payout-requests',
    component: lazy(() => import('views/payout-requests')),
  },
  {
    path: 'catalog',
    component: lazy(() => import('views/catalog')),
  },
];

export default AppRoutes;
