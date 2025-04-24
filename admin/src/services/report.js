import request from './request';

const reportService = {
  products: (params = {}) =>
    request.get('dashboard/admin/statistics/products', { params }),
  users: (params = {}) =>
    request.get('dashboard/admin/statistics/users', { params }),
};

export default reportService;
