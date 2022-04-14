import styles from "./userPageFooter.module.css"
import {FooterPagination} from "../footerPagination/FooterPagination";
import {useSelector} from "react-redux";
import {selectPage, selectPagesNumber, selectPerPage, selectUsersCount} from "../../pages/userListPage/userSlice";


export const UserPageFooter = ()=> {

const page = useSelector(selectPage)
const perPage = useSelector(selectPerPage)
    const total = useSelector(selectUsersCount)

const calcul = page*perPage;

    return (
        <>

        <div className={styles.global}>
            <div className={styles.title}> showing {page===1?1:page+perPage-1} to {calcul>total?total:calcul} of {total} entities</div>

            <FooterPagination/>
        </div>

        </>
    )
}