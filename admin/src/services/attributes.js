import request from './request';

const attributesService = {
  getAll: (params) => request.get('dashboard/admin/attributes', { params }),
  getById: (id) => request.get(`dashboard/admin/attributes/${id}`),
  create: (data) => request.post('dashboard/admin/attributes', data),
  createMany: (data) =>
    request.post('dashboard/admin/attributes/create/many', { data }),
  update: (id, data) => request.put(`dashboard/admin/attributes/${id}`, data),
  delete: (params) =>
    request.delete('dashboard/admin/attributes/delete', { params }),
  getByCategoryId: (id, params = {}) =>
    request.get(`rest/attributes/${id}`, { params }),
};

export default attributesService;
