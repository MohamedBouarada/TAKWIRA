import {UsersTable} from "../../components/users-table/UsersTable";
import styles from  "./usersListPage.module.css"
import {SearchBar} from "../../components/shared/searchBar/SearchBar";
import {UserPageFooter} from "../../components/userPageFooter/UserPageFooter";
import {useEffect} from "react";
import {useDispatch, useSelector} from "react-redux";
import {
    getUsers,
    selectOrderBy,
    selectPage,
    selectPerPage, selectRole,
    selectSearchValue,
    selectSort,
    selectUsersList
} from "./userSlice";
import {Button} from "../../components/shared/button/Button";
import {ParamsBar} from "../../components/shared/params-bar/ParamsBar";
import {changeSearchBarContext} from "../../components/app/appSlice";

export const UserListPage = ()=> {
    const page = useSelector(selectPage)
    const perPage= useSelector(selectPerPage)
    const orderBy = useSelector(selectOrderBy)
    const sort = useSelector(selectSort)
    const searchValue = useSelector(selectSearchValue)
    const role = useSelector(selectRole)

    const dispatch = useDispatch();

    useEffect(()=>{
        dispatch(changeSearchBarContext("users"))
    })
    useEffect( ()=>{

            dispatch(getUsers())


    } , [page ,perPage,orderBy,sort ,searchValue,role])
    return (
        <>
<div className={styles.global}>


    <ParamsBar/>
        <UsersTable/>
    <UserPageFooter/>
</div>
        </>
    )
}