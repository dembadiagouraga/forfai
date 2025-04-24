import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import productService from '../../services/product';
import restProductService from '../../services/rest/product';
import sellerProductService from '../../services/seller/product';

const initialState = {
  loading: false,
  vacancies: [],
  error: '',
  params: {
    page: 1,
    perPage: 10,
    work: 1,
  },
  links: null,
  meta: {},
};

export const fetchVacancies = createAsyncThunk(
  'vacancy/fetchVacancies',
  (params = {}) => {
    return productService
      .getAll({ ...initialState.params, ...params })
      .then((res) => res);
  }
);

export const fetchRestProducts = createAsyncThunk(
  'vacancy/fetchRestProducts',
  (params = {}) => {
    return restProductService
      .getAll({ ...initialState.params, ...params })
      .then((res) => res);
  }
);

export const fetchSellerProducts = createAsyncThunk(
  'vacancy/fetchSellerProducts',
  (params = {}) => {
    return sellerProductService
      .getAll({ ...initialState.params, ...params })
      .then((res) => res);
  }
);

const productSlice = createSlice({
  name: 'vacancy',
  initialState,
  extraReducers: (builder) => {
    builder.addCase(fetchVacancies.pending, (state) => {
      state.loading = true;
    });
    builder.addCase(fetchVacancies.fulfilled, (state, action) => {
      const { payload } = action;
      state.loading = false;
      state.vacancies = payload.data.map((item) => ({
        ...item,
        id: item.id,
        uuid: item.uuid,
        name: item.translation ? item.translation.title : 'no name',
        active: item.active,
        img: item.img,
        category_name: item.category?.translation
          ? item.category.translation.title
          : 'no name',
      }));
      state.meta = payload.meta;
      state.links = payload.links;
      state.params.page = payload.meta.current_page;
      state.params.perPage = payload.meta.per_page;
      state.error = '';
    });
    builder.addCase(fetchVacancies.rejected, (state, action) => {
      state.loading = false;
      state.vacancies = [];
      state.error = action.error.message;
    });

    //rest products
    builder.addCase(fetchRestProducts.pending, (state) => {
      state.loading = true;
    });
    builder.addCase(fetchRestProducts.fulfilled, (state, action) => {
      const { payload } = action;
      state.loading = false;
      state.products = payload.data.map((item) => ({
        ...item,
        id: item.id,
        uuid: item.uuid,
        name: item.product?.translation
          ? item.product?.translation.title
          : 'no name',
        active: item.active,
        img: item?.img,
        category_name: item.product?.category?.translation
          ? item.product?.category.translation.title
          : 'no name',
        unit: item?.unit,
      }));
      state.meta = payload.meta;
      state.links = payload.links;
      state.params.page = payload.meta.current_page;
      state.params.perPage = payload.meta.per_page;
      state.error = '';
    });
    builder.addCase(fetchRestProducts.rejected, (state, action) => {
      state.loading = false;
      state.products = [];
      state.error = action.error.message;
    });

    //seller product
    builder.addCase(fetchSellerProducts.pending, (state) => {
      state.loading = true;
    });
    builder.addCase(fetchSellerProducts.fulfilled, (state, action) => {
      const { payload } = action;
      state.loading = false;
      state.products = payload.data?.map((item) => ({
        ...item,
        id: item.id,
        uuid: item.uuid,
        name: item?.translation ? item?.translation.title : 'no name',
        active: item.active,
        img: item?.img,
        category_name: item?.category?.translation
          ? item?.category?.translation?.title
          : 'no name',
      }));
      state.meta = payload.meta;
      state.links = payload.links;
      state.params.page = payload.meta.current_page;
      state.params.perPage = payload.meta.per_page;
      state.error = '';
    });
    builder.addCase(fetchSellerProducts.rejected, (state, action) => {
      state.loading = false;
      state.products = [];
      state.error = action.error.message;
    });
  },
});

export default productSlice.reducer;
