import { lazy } from 'react';

const StoryRoutes = [
  {
    path: 'stories',
    component: lazy(() => import('views/story')),
  },
  {
    path: 'stories/create',
    component: lazy(() => import('views/story/create')),
  },
  {
    path: 'stories/edit/:id',
    component: lazy(() => import('views/story/edit')),
  },
];

export default StoryRoutes;
