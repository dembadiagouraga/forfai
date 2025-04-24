import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import attributesService from '../../services/attributes';

const initialState = {
  loading: false,
  attributes: [],
  error: '',
  params: {
    page: 1,
    perPage: 10,
  },
  meta: {},
  attributeDetails: {
    loading: false,
    data: [],
    error: '',
  },
};

export const fetchAttributes = createAsyncThunk(
  'attributes/fetchAttributes',
  (params = {}) => {
    return attributesService
      .getAll({ ...initialState.params, ...params })
      .then((res) => res);
  },
);

export const fetchAttributeByCategoryId = createAsyncThunk(
  'attributes/fetchAttributeById',
  ({ id, params = {} }) => attributesService.getByCategoryId(id, params),
);

const attributesSlice = createSlice({
  name: 'attributes',
  initialState,
  extraReducers: (builder) => {
    // attribute list
    builder.addCase(fetchAttributes.pending, (state) => {
      state.loading = true;
    });
    builder.addCase(fetchAttributes.fulfilled, (state, action) => {
      const { payload } = action;
      state.loading = false;
      state.attributes = payload.data;
      state.meta = payload.meta;
      state.params.page = payload.meta.current_page;
      state.params.perPage = payload.meta.per_page;
      state.error = '';
    });
    builder.addCase(fetchAttributes.rejected, (state, action) => {
      state.loading = false;
      state.attributes = [];
      state.error = action.error.message;
    });
    // attribute details
    builder.addCase(fetchAttributeByCategoryId.pending, (state) => {
      state.attributeDetails.loading = true;
    });
    builder.addCase(fetchAttributeByCategoryId.fulfilled, (state, action) => {
      state.attributeDetails.loading = false;
      state.attributeDetails.data = action.payload?.data;
      state.attributeDetails.error = '';
    });
    builder.addCase(fetchAttributeByCategoryId.rejected, (state, action) => {
      state.attributeDetails.loading = false;
      state.attributeDetails.data = {};
      state.attributeDetails.error = action.error.message;
    });
  },
});

export default attributesSlice.reducer;
