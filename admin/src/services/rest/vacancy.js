import request from '../request';

const vacancyService = {
  getAll: (params) => request.get('rest/vacancies/paginate', { params }),
  getProductByIds: (params) => request.get('rest/vacancies/ids', { params }),
  getByID: (id, params) => request.get(`rest/vacancies/${id}`, { params }),
  search: (params) => request.get('rest/vacancies/paginate', { params }),
};

export default vacancyService;
