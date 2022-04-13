import {UsersTable} from "../../components/users-table/UsersTable";
import styles from  "./usersListPage.module.css"
import {SearchBar} from "../../components/shared/searchBar/SearchBar";
import {UserPageFooter} from "../../components/userPageFooter/UserPageFooter";

export const UserListPage = ()=> {


    return (
        <>
<div className={styles.global}>

    <SearchBar/>
        <UsersTable/>
    <UserPageFooter/>
</div>
        </>
    )
}