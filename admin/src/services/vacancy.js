import request from './request';
import requestWithoutTimeout from './requestWithoutTimeout';

const vacancyService = {
  getAll: (params) =>
    request.get('dashboard/admin/vacancies/paginate', { params }),
    getById: (id, params) =>
    request.get(`dashboard/admin/vacancies/${id}`, { params }),
  export: (params) =>
    requestWithoutTimeout.get(`dashboard/admin/vacancies/export`, { params }),
  import: (data) =>
    requestWithoutTimeout.post('dashboard/admin/vacancies/import', data),
  create: (data) => request.post(`dashboard/admin/vacancies`, data),
  update: (uuid, data) => request.put(`dashboard/admin/vacancies/${uuid}`, data),
  delete: (params) =>
    request.delete(`dashboard/admin/vacancies/delete`, { params }),
  dropAll: () => request.get(`dashboard/admin/vacancies/drop/all`),
  restoreAll: () => request.get(`dashboard/admin/vacancies/restore/all`),
  extras: (uuid, data) =>
    request.post(`dashboard/admin/vacancies/${uuid}/extras`, data),
  stocks: (uuid, data) =>
    request.post(`dashboard/admin/vacancies/${uuid}/stocks`, data),
  properties: (uuid, data) =>
    request.post(`dashboard/admin/vacancies/${uuid}/properties`, data),
  setActive: (uuid) =>
    request.post(`dashboard/admin/vacancies/${uuid}/active`, {}),
  getStock: (params) =>
    request.get(`dashboard/admin/stocks/select-paginate`, { params }),
  updateStatus: (uuid, params) =>
    request.post(
      `dashboard/admin/vacancies/${uuid}/status/change`,
      {},
      { params }
    ),
  updateStocks: (data) =>
    request.post(`dashboard/admin/stocks/galleries`, data),
};

export default vacancyService;
