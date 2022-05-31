import {createAsyncThunk, createSlice} from "@reduxjs/toolkit";
import {getOneField} from "../../services/axios";


const initialState = {
    createdAt: "",
    updatedAt: "",
    id:"",
    edit:false,
    userId : "",
    name : "",
    adresse : "",
    type : "",
    isNotAvailable : {},
    services : "",
    prix : "",
    period : "",
    surface : "",
    description : "",
    relatedUser  : {},
    images: [],
    currentIndex : 0,
    currentImage : "",

}


export const getSingleField = createAsyncThunk(
    "fieldInfo/fetchSingleField",
    async  (_,{getState})=> {
        const {fieldInfo} = getState()
        const {id} = fieldInfo
        return await getOneField(id)
    }
)


export const fieldInfoSlice = createSlice({
    name : "fieldInfo",
    initialState,
    reducers : {
    changeFieldId : (state,action)=> {
        state.id = action.payload
    },
        incrementIndex : (state,action)=>{
            if(state.currentIndex < state.images.length -1) {
                const index = state.currentIndex +1 ;
                state.currentIndex++;
                state.currentImage = state.images[index].name;

            }
        },
        decrementIndex : (state,action)=>{
            if(state.currentIndex > 0) {
                const index = state.currentIndex -1;
                state.currentIndex--;
                state.currentImage = state.images[index].name;
            }
        }


    },
    extraReducers : builder => {
        builder.addCase(getSingleField.fulfilled , (state,action)=>{
            if(action.payload.success===true) {
                console.log(action.payload.data)
                const {id,images,name,adresse,createdAt,updatedAt,type,surface,services,prix,description,period,user,userId} = action.payload.data
               console.log(action.payload.data)
                state.id = id;
                state.name = name;
                state.adresse = adresse;
                state.createdAt = createdAt;
                state.updatedAt = updatedAt;
                state.type = type;
                state.surface = surface;
                state.services = services;
                state.prix = prix;
                state.description = description;
                state.period = period;
                state.relatedUser = user;
                state.userId = userId;
                state.images = images;
                state.currentIndex =0;
                state.currentImage = images[0].name;
            }
        })
    }
})


export const selectFieldInfoId = state=> state.fieldInfo.id
export const selectFieldInfoName = state=>state.fieldInfo.name
export const selectFieldInfoCreatedAt = state => state.fieldInfo.createdAt
export const selectFieldInfoUpdatedAt = state=>state.fieldInfo.createdAt
export const selectFieldInfoEdit = state => state.fieldInfo.edit;
export const selectFieldInfoAdresse = state => state.fieldInfo.adresse;
export const selectFieldInfoType = state => state.fieldInfo.type;
export const selectFieldInfoSurface = state => state.fieldInfo.surface;
export const selectFieldInfoIsNotAvailable = state => state.fieldInfo.isNotAvailable;
export const selectFieldInfoServices = state => state.fieldInfo.services;
export const selectFieldInfoPrix = state => state.fieldInfo.prix;
export const selectFieldInfoPeriod = state => state.fieldInfo.period;
export const selectFieldInfoDescription = state => state.fieldInfo.description;
export const selectFieldInfoRelatedOwner = state => state.fieldInfo.relatedUser;
export const selectFieldInfoUserId = state =>state.fieldInfo.userId;
export const selectFieldImages = state =>state.fieldInfo.images;
export const selectFieldCurrentIndex = state =>state.fieldInfo.currentIndex;
export const selectFieldCurrentImage = state=> state.fieldInfo.currentImage;



export const {changeFieldId,incrementIndex,decrementIndex} = fieldInfoSlice.actions

export default fieldInfoSlice.reducer ;
