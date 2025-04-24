import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import sellerCategory from '../../services/seller/category';
import categoryService from '../../services/category';

const initialState = {
  loading: false,
  vacancyCategories: [],
  error: '',
  params: {
    page: 1,
    perPage: 10,
  },
  meta: {},
};

export const fetchVacancyCategories = createAsyncThunk(
  'vacancyCategory/fetchVacancyCategories',
  (params = {}) => {
    return categoryService
      .getAllMain({ ...initialState.params, ...params })
      .then((res) => res);
  },
);

export const fetchSellerCategory = createAsyncThunk(
  'vacancyCategory/fetchSellerCategory',
  (params = {}) => {
    return sellerCategory
      .getAll({ ...initialState.params, ...params })
      .then((res) => res);
  },
);

const categorySlice = createSlice({
  name: 'vacancyCategory',
  initialState,
  extraReducers: (builder) => {
    builder.addCase(fetchVacancyCategories.pending, (state) => {
      state.loading = true;
    });
    builder.addCase(fetchVacancyCategories.fulfilled, (state, action) => {
      const { payload } = action;
      state.loading = false;
      state.vacancyCategories = payload.data.map((item) => ({
        active: item.active,
        img: item.img,
        name: item.translation !== null ? item.translation.title : 'no name',
        key: item.uuid + '_' + item.id,
        uuid: item.uuid,
        id: item.id,
        locales: item.locales,
        status: item.status,
      }));
      state.meta = payload.meta;
      state.params.page = payload.meta?.current_page;
      state.params.perPage = payload.meta.per_page;
      state.error = '';
    });
    builder.addCase(fetchVacancyCategories.rejected, (state, action) => {
      state.loading = false;
      state.vacancyCategories = [];
      state.error = action.error.message;
    });

    //seller category
    builder.addCase(fetchSellerCategory.pending, (state) => {
      state.loading = true;
    });
    builder.addCase(fetchSellerCategory.fulfilled, (state, action) => {
      const { payload } = action;
      state.loading = false;
      state.vacancyCategories = payload.data.map((item) => ({
        active: item.active,
        img: item.img,
        name: item.translation !== null ? item.translation.title : 'no name',
        key: item.uuid + '_' + item.id,
        uuid: item.uuid,
        id: item.id,
        locales: item.locales,
        status: item.status,
        shop: item.shop,
      }));
      state.meta = payload?.meta;
      state.params.page = payload.meta?.current_page;
      state.params.perPage = payload.meta?.per_page;
      state.error = '';
    });
    builder.addCase(fetchSellerCategory.rejected, (state, action) => {
      state.loading = false;
      state.vacancyCategories = [];
      state.error = action.error.message;
    });
  },
});

export default categorySlice.reducer;
