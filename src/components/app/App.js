import React from 'react';
import {Sidebar} from "../sidebar/Sidebar";

import './App.css'

import {UserListPage} from "../../pages/userListPage/UserListPage";


function App() {
  return (
    <div >

        <Sidebar/>
       <UserListPage/>
    </div>
  );
}

export default App;
