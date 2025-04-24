import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import userService from 'services/user';

const initialState = {
  loading: false,
  users: [],
  userDetails: {
    data: {},
    loading: false,
  },
  walletHistory: {
    data: [],
    meta: {},
    params: {
      page: 1,
      perPage: 10,
    },
    loading: false,
  },
  error: '',
  params: {
    page: 1,
    perPage: 10,
    role: 'admin',
  },
  meta: {},
  selectedIds: [],
};

export const fetchUsers = createAsyncThunk('user/fetchUsers', (params = {}) => {
  return userService
    .getAll({ ...initialState.params, ...params })
    .then((res) => res);
});

export const fetchUserById = createAsyncThunk(
  'user/fetchUserById',
  ({ id }) => {
    return userService.getById(id).then((res) => res);
  },
);

export const fetchUserWalletHistory = createAsyncThunk(
  'user/fetchUserWalletHistory',
  ({ id, params }) => {
    return userService
      .walletHistory(id, { ...initialState.walletHistory.params, ...params })
      .then((res) => res);
  },
);

export const deleteUsers = (ids = []) => {
  const params = {
    ...ids.reduce((acc, cur, index) => {
      acc[`ids[${index}]`] = cur;
      return acc;
    }, {}),
  };

  return userService.delete(params);
};

const userSlice = createSlice({
  name: 'user',
  initialState,
  extraReducers: (builder) => {
    // paginate
    builder.addCase(fetchUsers.pending, (state) => {
      state.loading = true;
    });
    builder.addCase(fetchUsers.fulfilled, (state, action) => {
      const { payload } = action;
      state.loading = false;
      state.users = payload.data;
      state.meta = payload.meta;
      state.params.page = payload.meta.current_page;
      state.params.perPage = payload.meta.per_page;
      state.error = '';
    });
    builder.addCase(fetchUsers.rejected, (state, action) => {
      state.loading = false;
      state.users = [];
      state.error = action.error.message;
    });
    // get by id
    builder.addCase(fetchUserById.pending, (state) => {
      state.userDetails.loading = true;
    });
    builder.addCase(fetchUserById.fulfilled, (state, action) => {
      state.userDetails.loading = false;
      state.userDetails.data = action.payload?.data;
    });
    builder.addCase(fetchUserById.rejected, (state) => {
      state.userDetails.loading = false;
      state.userDetails.data = {};
    });
    // wallet history
    builder.addCase(fetchUserWalletHistory.pending, (state) => {
      state.walletHistory.loading = true;
    });
    builder.addCase(fetchUserWalletHistory.fulfilled, (state, action) => {
      state.walletHistory.loading = false;
      state.walletHistory.data = action.payload.data;
      state.walletHistory.meta = action.payload.meta;
      state.walletHistory.param = {
        ...state.walletHistory.params,
        page: Number(action.payload.meta.current_page),
      };
      state.walletHistory.param = {
        ...state.walletHistory.params,
        perPage: Number(action.payload.meta.per_page),
      };
    });
    builder.addCase(fetchUserWalletHistory.rejected, (state) => {
      state.walletHistory.loading = false;
      state.walletHistory.data = [];
      state.walletHistory.meta = {};
    });
  },
  reducers: {
    setParams: (state, action) => {
      state.params = { ...state.params, ...action.payload };
    },
    setSelectedIds: (state, action) => {
      state.selectedIds = action.payload;
    },
    resetSelectedIds: (state) => {
      state.selectedIds = initialState.selectedIds;
    },
    setWalletHistoryParams: (state, action) => {
      state.walletHistory.params = {
        ...state.walletHistory.params,
        ...action.payload,
      };
    },
  },
});

export const {
  setParams,
  setSelectedIds,
  resetSelectedIds,
  setWalletHistoryParams,
} = userSlice.actions;

export default userSlice.reducer;
