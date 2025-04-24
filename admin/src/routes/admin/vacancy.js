// ** React Imports
import { lazy } from 'react';

const VacancyRoutes = [
  {
    path: 'vacancies',
    component: lazy(() => import('views/vacancies')),
  },
  {
    path: 'vacancies/add',
    component: lazy(() => import('views/vacancies/vacancies-add')),
  },
  {
    path: 'vacancy/:uuid',
    component: lazy(() => import('views/vacancies/vacancy-edit')),
  },
  {
    path: 'vacancy-clone/:uuid',
    component: lazy(() => import('views/vacancies/vacancy-clone')),
  },
  {
    path: 'catalog/vacancy/import',
    component: lazy(() => import('views/vacancies/vacancy-import')),
  },
];

export default VacancyRoutes;
