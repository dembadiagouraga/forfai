import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import productService from 'services/product';

const initialState = {
  loading: false,
  products: [],
  error: '',
  params: {
    page: 1,
    perPage: 10,
  },
  links: null,
  meta: {},
  filters: {
    search: '',
    category: null,
    status: 'all',
  },
  selectedIds: [],
  productDetails: {
    loading: false,
    data: {},
    error: '',
  },
};

export const fetchProducts = createAsyncThunk(
  'product/fetchProducts',
  (params = {}) => {
    return productService
      .getAll({ ...initialState.params, ...params })
      .then((res) => res);
  },
);

export const fetchProductById = createAsyncThunk(
  'product/fetchProductById',
  ({ id, params = {} }) => productService.getById(id, params),
);

export const deleteProducts = (ids) => {
  const params = {
    ...ids.reduce((acc, cur, index) => {
      acc[`ids[${index}]`] = cur;
      return acc;
    }, {}),
  };
  return productService.delete(params);
};

export const productSlice = createSlice({
  name: 'product',
  initialState,
  extraReducers: (builder) => {
    // product list
    builder.addCase(fetchProducts.pending, (state) => {
      state.loading = true;
    });
    builder.addCase(fetchProducts.fulfilled, (state, action) => {
      const { payload } = action;
      state.loading = false;
      state.products = payload.data;
      state.meta = payload.meta;
      state.links = payload.links;
      state.params.page = Number(payload.meta.current_page);
      state.params.perPage = Number(payload.meta.per_page);
      state.error = '';
    });
    builder.addCase(fetchProducts.rejected, (state, action) => {
      state.loading = false;
      state.products = [];
      state.error = action.error.message;
    });
    // product details
    builder.addCase(fetchProductById.pending, (state) => {
      state.productDetails.loading = true;
    });
    builder.addCase(fetchProductById.fulfilled, (state, action) => {
      state.productDetails.loading = false;
      state.productDetails.data = action.payload?.data;
      state.productDetails.error = '';
    });
    builder.addCase(fetchProductById.rejected, (state, action) => {
      state.productDetails.loading = false;
      state.productDetails.data = initialState.productDetails.data;
      state.productDetails.error = action.error.message;
    });
  },
  reducers: {
    setFilters: (state, action) => {
      state.filters = { ...state.filters, ...action.payload };
    },
    resetFilters: (state) => {
      state.filters = initialState.filters;
    },
    setParams: (state, action) => {
      state.params = { ...state.params, ...action.payload };
    },
    setSelectedIds: (state, action) => {
      state.selectedIds = action.payload;
    },
  },
});

export const { setFilters, resetFilters, setParams, setSelectedIds } =
  productSlice.actions;

export default productSlice.reducer;
