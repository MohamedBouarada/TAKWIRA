import {createSlice} from "@reduxjs/toolkit";


const initialState={
    isHovering :1
}

export const sidebarSlice = createSlice({
    name: "sidebar",
    initialState,
    reducers : {
        hovering : (state)=> {
            state.isHovering =0 ;
        },
        notHovering : (state)=> {
            state.isHovering =1
        }

    }

})


export const {hovering,notHovering} = sidebarSlice.actions ;
export const selectSideBarHovering = state => state.sidebar.isHovering;

export default sidebarSlice.reducer ;