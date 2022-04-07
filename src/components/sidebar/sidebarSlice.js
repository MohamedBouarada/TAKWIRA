import {createSlice} from "@reduxjs/toolkit";


const initialState={
    isHovering :1,
    isClicked : 1,
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
        },
        clicking : (state , action) => {

            state.isClicked =action.payload ;
        }

    }

})


export const {hovering,notHovering , clicking} = sidebarSlice.actions ;
export const selectSideBarHovering = state => state.sidebar.isHovering;
export const selectSideBarClicking = state => state.sidebar.isClicked ;

export default sidebarSlice.reducer ;