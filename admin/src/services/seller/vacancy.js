import request from '../request';
import requestWithoutTimeout from '../requestWithoutTimeout';

const vacanciesService = {
  getAll: (params) =>
    request.get('dashboard/seller/vacancies/paginate', { params }),
  getById: (uuid, params) =>
    request.get(`dashboard/seller/vacancies/${uuid}`, { params }),
  create: (params) =>
    request.post(`dashboard/seller/vacancies`, {}, { params }),
  export: (params) =>
    requestWithoutTimeout.get(`dashboard/seller/vacancies/export`, { params }),
  import: (data) =>
    requestWithoutTimeout.post('dashboard/seller/vacancies/import', data),
  update: (uuid, params) =>
    request.put(`dashboard/seller/vacancies/${uuid}`, {}, { params }),
  delete: (params) =>
    request.delete(`dashboard/seller/vacancies/delete`, { params }),
  extras: (uuid, data) =>
    request.post(`dashboard/seller/vacancies/${uuid}/extras`, data),
  stocks: (uuid, data) =>
    request.post(`dashboard/seller/vacancies/${uuid}/stocks`, data),
  properties: (uuid, data) =>
    request.post(`dashboard/seller/vacancies/${uuid}/properties`, data),
  setActive: (uuid) =>
    request.post(`dashboard/seller/vacancies/${uuid}/active`, {}),
  getStock: (params) =>
    request.get(`dashboard/seller/stocks/select-paginate`, { params }),
  updateStatus: (uuid, params) =>
    request.get(
      `dashboard/seller/vacancies/${uuid}/status/change`,
      {},
      { params }
    ),
  updateStocks: (data) =>
    request.post(`dashboard/seller/stocks/galleries`, data),
};

export default vacanciesService;