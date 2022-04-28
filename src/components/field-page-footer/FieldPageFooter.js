import styles from "../userPageFooter/userPageFooter.module.css";
import {useSelector} from "react-redux";
import {selectPage, selectPerPage, selectFieldsCount} from "../../pages/fieldsListPage/fieldsSlice";
import {FieldFooterPagination} from "../field-footer-pagination/FieldFooterPagination";


export const FieldPageFooter = ()=> {

    const page = useSelector(selectPage)
    const perPage = useSelector(selectPerPage)
    const total = useSelector(selectFieldsCount)

    const calcul = page*perPage;
    return (
        <>
            <div className={styles.global}>
                <div className={styles.title}> showing {page===1?1:page+perPage-1} to {calcul>total?total:calcul} of {total} entities</div>

                <FieldFooterPagination/>
            </div>
        </>
    )
}