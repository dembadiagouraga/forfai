import request from './request';

const storeisService = {
  getAll: (params) => request.get('dashboard/admin/stories', { params }),
  getById: (id, params) =>
    request.get(`dashboard/admin/stories/${id}`, { params }),
  create: (data) => request.post('dashboard/admin/stories', data),
  delete: (params) =>
    request.delete(`dashboard/admin/stories/delete`, { params }),
  update: (id, data) => request.put(`dashboard/admin/stories/${id}`, data),
};

export default storeisService;
