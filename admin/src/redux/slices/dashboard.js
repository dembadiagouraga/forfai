import moment from 'moment/moment';
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import statisticService from 'services/statistics';

const date = {
  from: moment().subtract(1, 'months').format('YYYY-MM-DD'),
  to: moment().format('YYYY-MM-DD'),
};

const initialState = {
  filters: {
    date,
  },
  params: {
    date_from: date.from,
    date_to: date.to,
    time: 'subMonth',
  },
  statistics: {
    loading: false,
    data: {},
    error: '',
  },
};

export const fetchStatistics = createAsyncThunk(
  'dashboard/fetchStatistics',
  (params = {}) =>
    statisticService.getAll({ ...initialState.params, ...params }),
);

const dashboard = createSlice({
  name: 'dashboard',
  initialState,
  extraReducers: (builder) => {
    // statistics
    builder.addCase(fetchStatistics.pending, (state, action) => {
      state.statistics.loading = true;
    });
    builder.addCase(fetchStatistics.fulfilled, (state, action) => {
      state.statistics.loading = false;
      state.statistics.data = action.payload.data;
      state.statistics.error = '';
    });
    builder.addCase(fetchStatistics.rejected, (state, action) => {
      state.statistics.loading = false;
      state.statistics.data = initialState.statistics.data;
      state.statistics.error = action.error.message;
    });
  },
  reducers: {
    setFilters: (state, action) => {
      state.filters = { ...state.filters, ...action.payload };
    },
    setParams: (state, action) => {
      state.params = { ...state.params, ...action.payload };
    },
  },
});

export const { setFilters, setParams } = dashboard.actions;

export default dashboard.reducer;
