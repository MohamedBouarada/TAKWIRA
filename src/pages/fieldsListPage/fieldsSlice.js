import {createAsyncThunk, createSlice} from "@reduxjs/toolkit";
import {getAllFields} from "../../services/axios";


const initialState={
    sort : "ASC",
    perPage : 5,
    page :1,
    pagesNumber :1,
    orderBy : "createdAt",
    fieldsList: [] ,
    countFields : 1,
    searchValue :"",
    type:"*",
    surface:"*"
}

export const getFields = createAsyncThunk(
    "field/fetchFields",
    async (_,{getState})=>{
        const {field} =getState();
        const {sort,perPage,page,orderBy,searchValue,type,surface} = field
        return await getAllFields(orderBy,sort,perPage,page,searchValue,type,surface) ;

    }
);


export const fieldSlice =createSlice({
    name : "field",
    initialState,
    reducers : {

    },
    extraReducers : (builder => {
        builder.addCase(getFields.fulfilled , (state,action)=> {
            if(action.payload.success ===true){
               // console.log(action.payload)
                state.fieldsList = action.payload.data.result.data.rows
                state.countFields = action.payload.data.result.data.count
                state.pagesNumber = action.payload.data.pagesNumber;
            } else {
                state.fieldsList = []
            }
        })
    })
})

export const selectSort = state => state.field.sort ;
export const selectOrderBy = state =>state.field.orderBy ;
export const selectPerPage = state=>state.field.perPage;
export const selectPage = state => state.field.page;
export  const selectFieldsList = state => state.field.fieldsList;
export const selectPagesNumber = state => state.field.pagesNumber;
export const selectFieldsCount = state =>state.field.countFields;
export const selectSearchValue = state => state.field.searchValue;
export const selectRole = state => state.field.role

export default  fieldSlice.reducer ;