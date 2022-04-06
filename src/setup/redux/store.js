import { configureStore } from '@reduxjs/toolkit';
import counterReducer from '../../features/counter/counterSlice';
import sidebarReducer from "../../components/sidebar/sidebarSlice"

export const store = configureStore({
    reducer: {
        counter: counterReducer,
        sidebar: sidebarReducer,
    },
});
