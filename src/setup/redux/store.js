import { configureStore } from '@reduxjs/toolkit';
import counterReducer from '../../features/counter/counterSlice';
import sidebarReducer from "../../components/sidebar/sidebarSlice"
import userReducer from "../../pages/userListPage/userSlice"
import infoReducer from "../../pages/userFormPage/userInfoSlice"
import fieldReducer from "../../pages/fieldsListPage/fieldsSlice"
export const store = configureStore({
    reducer: {
        counter: counterReducer,
        sidebar: sidebarReducer,
        user: userReducer,
        info : infoReducer,
        field : fieldReducer
    },
});
