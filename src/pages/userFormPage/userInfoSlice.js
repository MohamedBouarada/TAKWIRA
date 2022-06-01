import {createAsyncThunk, createSlice} from "@reduxjs/toolkit";
import {
    activateOwnerRequestAccount,
    addNewUser,
    deleteOneUser,
    getOneUser,
    updateUserGeneralInfos
} from "../../services/axios";

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
    fieldsRelatedToUser : [],
    fieldIndex : 0 ,
    currentFieldShowed : {},
}

export const getSingleUser = createAsyncThunk(
    "info/fetchSingleUser",
    async(_, {getState})=>{
        const {info} = getState()
        const {id} =info ;
        return await getOneUser(id)

    }
)
export const deleteUser = createAsyncThunk(
    "info/deleteUser",
    async(idd,{getState})=>{
       const {info}= getState();
        const{id} = info;
        return await deleteOneUser(idd)
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

export const updateUser = createAsyncThunk(
    "info/updateGeneralInfos",
    async (_ , {getState})=>{
        const {info} = getState()
        const {id,firstName,lastName,email,phoneNumber} = info;
        return await  updateUserGeneralInfos(id,email,firstName,lastName,phoneNumber)
    }
)
export const activateOwnerAcc = createAsyncThunk(
    "info/activateOwnerRequestAccount",
    async (_,{getState})=>{
        const {info}=getState()
        const {id}=info;
        return await activateOwnerRequestAccount(id)
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
        },
        changeUserEdit : (state,action) =>{
            state.edit = action.payload
        } ,
        incrementFieldIndex : (state,action) => {
            console.log("incrementing")
            if(state.fieldIndex=== state.fieldsRelatedToUser.length-1){

            }else {
                state.fieldIndex = state.fieldIndex+1;
                state.currentFieldShowed = state.fieldsRelatedToUser[state.fieldIndex]
            }
        },
        decrementFieldIndex : (state,action) => {
            if(state.fieldIndex=== 0){

            }else {
                state.fieldIndex = state.fieldIndex-1;
                state.currentFieldShowed = state.fieldsRelatedToUser[state.fieldIndex]
            }
        },
        initState : (state,action) => {
            state.id="";
            state.firstName ="";
            state.lastName="";
            state.email = "";
            state.phoneNumber = "";
            state.role="CLIENT";
            state.password="";
            state.repeatPassword="";
            state.createdAt="";
            state.updatedAt="";
            state.edit=false;
        }
    },
    extraReducers: (builder => {
        builder.addCase(getSingleUser.fulfilled , (state,action)=>{
            if(action.payload.success===true) {

                const {id,firstName,lastName,createdAt,updatedAt,phoneNumber,email,role}= action.payload.data;

                    state.id=id;
                    state.firstName=firstName;
                    state.lastName=lastName;
                    state.createdAt=createdAt;
                    state.updatedAt=updatedAt;
                    state.phoneNumber=phoneNumber;
                    state.email=email;
                    state.role=role;
                    if(role === "OWNER" || role==="OWNER_REQUEST"){
                        state.fieldsRelatedToUser = action.payload.data.fields;
                        state.fieldIndex = 0 ;
                            state.currentFieldShowed = action.payload.data.fields[0];
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
            .addCase(updateUser.fulfilled ,(state,action)=>{
                if(action.payload.success===true){
                    state.id=action.payload.data
                    state.edit=false;
                }else {

                }
            })
            .addCase(activateOwnerAcc.fulfilled , (state,action)=>{
                if(action.payload.success===true) {
                    state.id = action.payload.data.id;
                }
            })
            .addCase(deleteUser.fulfilled , (state,action)=>{
                if(action.payload.success) {
                   // state.id = 1;
                }
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
export const selectInfoEdit = state => state.info.edit;
export const selectFieldsRelatedToUser = state=>state.info.fieldsRelatedToUser ;
export const selectCurrentFieldIndex = state => state.info.fieldIndex;
export const selectCurrentFieldShowed = state=>state.info.currentFieldShowed;

export const {changeUserId ,
    changeUserLastName,
    changeUserRepeatPassword,
    changeUserPhoneNumber,
    changeUserPassword,
    changeUserRole,
    changeUserFirstName,
    changeUserEmail,
    changeUserEdit , initState ,incrementFieldIndex,decrementFieldIndex} = infoSlice.actions

export default infoSlice.reducer
