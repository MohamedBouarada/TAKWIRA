import React from 'react';
import {Sidebar} from "../sidebar/Sidebar";
import {Route, Routes, BrowserRouter} from 'react-router-dom'
import './App.css'

import {UserListPage} from "../../pages/userListPage/UserListPage";
import {UserDetailsPage} from "../../pages/userDetails/UserDetailsPage";
import {SearchBar} from "../shared/searchBar/SearchBar";
import {UserFormPage} from "../../pages/userFormPage/UserFormPage";
import {FieldsListPage} from "../../pages/fieldsListPage/FieldsListPage";
import {FieldDetailsPage} from "../../pages/field-details-page/FieldDetailsPage";


function App() {
  return (
    <div >

        <Sidebar/>
        <SearchBar/>
        <BrowserRouter>
        <Routes>
            <Route  path="/" element={<UserListPage />}/>
            <Route  path="/details" element={<UserDetailsPage />}/>
            <Route path="/user/add" element={<UserFormPage/>}/>
            <Route path="/fields/list" element ={<FieldsListPage/>}/>
            <Route path="/fields/details" element = {<FieldDetailsPage/>}/>
        </Routes>
        </BrowserRouter>

    </div>
  );
}

export default App;
