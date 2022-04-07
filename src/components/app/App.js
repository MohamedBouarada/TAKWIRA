import React from 'react';
import {Sidebar} from "../sidebar/Sidebar";

import './App.css'
import {UsersTable} from "../users-table/UsersTable";


function App() {
  return (
    <div >

        <Sidebar/>
        <UsersTable/>
    </div>
  );
}

export default App;
