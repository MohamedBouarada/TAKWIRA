import { configureStore } from '@reduxjs/toolkit';
import counterReducer from '../../features/counter/counterSlice';
import sidebarReducer from "../../components/sidebar/sidebarSlice"
import userReducer from "../../pages/userListPage/userSlice"
import infoReducer from "../../pages/userFormPage/userInfoSlice"
import fieldReducer from "../../pages/fieldsListPage/fieldsSlice"
import appReducer from  "../../components/app/appSlice"
import fieldInfoReducer from "../../pages/field-form-page/fieldInfoSlice";
export const store = configureStore({
    reducer: {
        counter: counterReducer,
        sidebar: sidebarReducer,
        user: userReducer,
        info : infoReducer,
        field : fieldReducer,
        app : appReducer,
        fieldInfo : fieldInfoReducer
    },
});



