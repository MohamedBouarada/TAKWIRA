import {createAsyncThunk, createSlice} from "@reduxjs/toolkit";
import {addNewUser, getOneUser} from "../../services/axios";

const  initialState = {
    firstName :"",
    lastName:"",
    phoneNumber:"",
    email:"",
    createdAt: "",
    updatedAt: "",
    role:"CLIENT",
    id:"",
    edit:false,
    password: "",
    repeatPassword :"",
}

export const getSingleUser = createAsyncThunk(
    "info/fetchSingleUser",
    async(_, {getState})=>{
        const {info} = getState()
        const {id} =info ;
        return await getOneUser(id)

    }
)

export const addOneUser = createAsyncThunk(
    "info/addNewUser",
    async(_,{getState})=>{
        const {info} = getState()
        const {firstName,lastName,email,password,phoneNumber,role,repeatPassword} = info;
        return await  addNewUser(firstName,lastName,email,password,phoneNumber,role,repeatPassword)
    }
)

export const infoSlice = createSlice({
    name:"info",
    initialState,
    reducers : {
        changeUserId :(state,action)=>{
            state.id= action.payload
        },
        changeUserFirstName : (state,action)=>{
            state.firstName= action.payload
        },
        changeUserLastName : (state,action)=>{
            state.lastName= action.payload
        },
        changeUserEmail : (state,action)=>{
            state.email= action.payload
        },changeUserPhoneNumber : (state,action)=>{
            state.phoneNumber= action.payload
        },changeUserRole : (state,action)=>{
            state.role= action.payload
        },
        changeUserPassword : (state,action)=>{
            state.password= action.payload
        },
        changeUserRepeatPassword : (state,action)=>{
            state.repeatPassword= action.payload
        }
    },
    extraReducers: (builder => {
        builder.addCase(getSingleUser.fulfilled , (state,action)=>{
            if(action.payload.success===true) {

                const {id,firstName,lastName,createdAt,updatedAt,phoneNumber,email,role}= action.payload.data;
                if(role!=="OWNER" || role!== "OWNER_REQUEST"){
                    state.id=id;
                    state.firstName=firstName;
                    state.lastName=lastName;
                    state.createdAt=createdAt;
                    state.updatedAt=updatedAt;
                    state.phoneNumber=phoneNumber;
                    state.email=email;
                    state.role=role;
                }

            }
        })
            .addCase(addOneUser.fulfilled ,(state,action)=>{
                if(action.payload.success===true){
                    state.id=action.payload.data
                } else {

                }


                state.password="";
                state.repeatPassword="";
                state.id=action.payload.data

            })
    })

})


export const selectInfoId = state=> state.info.id
export const selectInfoFirstName = state=>state.info.firstName
export const selectInfoLastName = state=>state.info.lastName
export const selectInfoEmail = state => state.info.email
export const selectInfoPhoneNumber = state=> state.info.phoneNumber
export const selectInfoCreatedAt = state => state.info.createdAt
export const selectInfoUpdatedAt = state=>state.info.createdAt
export const selectInfoRole = state =>state.info.role
export const selectInfoPassword = state => state.info.password
export const selectInfoRepeatPassword = state=> state.info.repeatPassword

export const {changeUserId ,
    changeUserLastName,
    changeUserRepeatPassword,
    changeUserPhoneNumber,
    changeUserPassword,
    changeUserRole,
    changeUserFirstName,
    changeUserEmail} = infoSlice.actions

export default infoSlice.reducer
