import {createSlice} from "@reduxjs/toolkit";

const initialState = {
    searchbarContext : "",
}




const appSlice = createSlice({
    name : "app",
    initialState,
    reducers : {
        changeSearchBarContext : (state,action)=> {
            state.searchbarContext = action.payload;
        }
    }
})

export const selectAppSearchbarContext = state => state.app.searchbarContext

export const {changeSearchBarContext} = appSlice.actions ;


export default appSlice.reducer ;