import {UsersTable} from "../../components/users-table/UsersTable";
import styles from  "./usersListPage.module.css"
import {SearchBar} from "../../components/shared/searchBar/SearchBar";
import {UserPageFooter} from "../../components/userPageFooter/UserPageFooter";
import {useEffect} from "react";
import {useDispatch, useSelector} from "react-redux";
import {getUsers, selectOrderBy, selectPage, selectPerPage, selectSort, selectUsersList} from "./userSlice";
import {Button} from "../../components/shared/button/Button";

export const UserListPage = ()=> {
    const page = useSelector(selectPage)
    const perPage= useSelector(selectPerPage)
    const orderBy = useSelector(selectOrderBy)
    const sort = useSelector(selectSort)
    const dispatch = useDispatch();
    useEffect( ()=>{
        dispatch(getUsers())
    } , [page ,perPage,orderBy,sort])
    return (
        <>
<div className={styles.global}>

    <SearchBar/>
    <div className={styles.mainButton }>
        <Button buttonText={"ADD NEW +"} width={"150px"} backgroundColor={ "rgba(54, 198, 41, 0.66)"} height={"50px"}/>
    </div>
        <UsersTable/>
    <UserPageFooter/>
</div>
        </>
    )
}