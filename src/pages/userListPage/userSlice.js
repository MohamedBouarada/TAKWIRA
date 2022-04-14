import {createAsyncThunk, createSlice} from "@reduxjs/toolkit";
import {getAllUsers} from "../../services/axios";


const initialState={
    sort : "ASC",
    perPage : 5,
    page :1,
    pagesNumber :1,
    orderBy : "createdAt",
    usersList: [] ,
    countUsers : 1,
}


export const getUsers = createAsyncThunk(
    "user/fetchUsers",
    async (_,{getState})=>{
        const {user} =getState();
        const {sort,perPage,page,orderBy} = user
        return await getAllUsers(orderBy,sort,perPage,page) ;

    }
);


export const userSlice = createSlice({
    name : "user",
    initialState,
    reducers:{
        decrementPage : (state)=> {
            if(state.page>1) {
                state.page -=1 ;
            }
        },
        incrementPage :(state)=>{
            if(state.page< state.pagesNumber) {
                state.page +=1
            }
        },
        changePerPage : (state,action)=> {

            if(action.payload>0 && action.payload<=state.countUsers){

                state.perPage =action.payload
            } else {
                state.perPage = 5;
            }
        },
        changeOrderAndSort :(state,action) => {
            if(state.orderBy === action.payload) {
                if(state.sort==="ASC") {
                    state.sort="DESC"
                } else{
                    state.sort = "ASC"
                }
            } else {
                state.orderBy =action.payload
                state.sort = "ASC"
            }
        }
    },
    extraReducers: (builder => {
        builder.addCase(getUsers.fulfilled , (state,action)=>{

            if(action.payload.success ===true){
                console.log(action.payload)
                state.usersList = action.payload.data.result.data.rows
                state.countUsers = action.payload.data.result.data.count
                state.pagesNumber = action.payload.data.pagesNumber;
            } else {
                state.usersList = []
            }

        })
    })
})



export const selectSort = state => state.user.sort ;
export const selectOrderBy = state =>state.user.orderBy ;
export const selectPerPage = state=>state.user.perPage;
export const selectPage = state => state.user.page;
export  const selectUsersList = state => state.user.usersList;
export const selectPagesNumber = state => state.user.pagesNumber;
export const selectUsersCount = state =>state.user.countUsers

export const {incrementPage , decrementPage ,changePerPage ,changeOrderAndSort} = userSlice.actions
export default  userSlice.reducer ;