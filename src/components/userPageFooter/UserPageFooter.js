import styles from "./userPageFooter.module.css"
import {FooterPagination} from "../footerPagination/FooterPagination";


export const UserPageFooter = ()=> {



    return (
        <>

        <div className={styles.global}>
            <div className={styles.title}> showing 1 to 10 of 50 entities</div>

            <FooterPagination/>
        </div>

        </>
    )
}