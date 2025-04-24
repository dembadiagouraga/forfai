import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import reportService from 'services/report';
import moment from 'moment';

const initialState = {
  products: {
    loading: false,
    data: [],
    error: '',
    meta: {},
    filters: {
      date: {
        from: moment().subtract(1, 'months').format('YYYY-MM-DD'),
        to: moment().format('YYYY-MM-DD'),
      },
    },
    params: {
      page: 1,
      perPage: 10,
    },
  },
  users: {
    loading: false,
    data: [],
    error: '',
    meta: {},
    filters: {
      date: {
        from: moment().subtract(1, 'months').format('YYYY-MM-DD'),
        to: moment().format('YYYY-MM-DD'),
      },
    },
    params: {
      page: 1,
      perPage: 10,
    },
  },
};

export const fetchProductReports = createAsyncThunk(
  'report/fetchProductReports',
  (params = {}) => reportService.products(params),
);

export const fetchUserReports = createAsyncThunk(
  'report/fetchUserReports',
  (params = {}) => reportService.users(params),
);

const report = createSlice({
  name: 'report',
  initialState,
  extraReducers: (builder) => {
    // Products
    builder.addCase(fetchProductReports.pending, (state) => {
      state.products.loading = true;
    });
    builder.addCase(fetchProductReports.fulfilled, (state, action) => {
      const { payload } = action;
      state.products.loading = false;
      state.products.data = payload?.data;
      state.products.meta = payload?.meta;
      state.products.params.page = payload?.meta?.current_page;
      state.products.params.perPage = payload?.meta?.per_page;
      state.products.error = initialState.products.error;
    });
    builder.addCase(fetchProductReports.rejected, (state, action) => {
      state.products.loading = false;
      state.products.data = initialState.products.data;
      state.products.error = action.error.message;
    });

    // Users
    builder.addCase(fetchUserReports.pending, (state) => {
      state.users.loading = true;
    });
    builder.addCase(fetchUserReports.fulfilled, (state, action) => {
      const { payload } = action;
      state.users.loading = false;
      state.users.data = payload?.data;
      state.users.meta = {
        total: payload?.total,
        per_page: payload?.per_page,
        current_page: payload?.current_page,
      };
      state.users.params.page = payload?.current_page;
      state.users.params.perPage = payload?.per_page;
      state.users.error = initialState.users.error;
    });
    builder.addCase(fetchUserReports.rejected, (state, action) => {
      state.users.loading = false;
      state.users.data = initialState.users.data;
      state.users.error = action.error.message;
    });
  },
  reducers: {
    setReportParams: (state, action) => {
      const { payload } = action;

      switch (payload?.type) {
        case 'product':
          state.products.params = {
            ...state.products.params,
            ...payload.params,
          };
          break;

        case 'user':
          state.users.params = {
            ...state.users.params,
            ...payload.params,
          };
          break;

        default:
          break;
      }
    },
    setReportFilters: (state, action) => {
      const { payload } = action;
      switch (payload?.type) {
        case 'product':
          state.products.filters = {
            ...state.products.filters,
            ...payload.filters,
          };
          break;

        case 'user':
          state.users.filters = {
            ...state.users.filters,
            ...payload.filters,
          };
          break;

        default:
          break;
      }
    },
  },
});

export const { setReportFilters, setReportParams } = report.actions;

export default report.reducer;
