
import styles from "./fieldsListPage.module.css"
import {useDispatch, useSelector} from "react-redux";
import {useEffect} from "react";
import {getFields, selectSurface, selectType} from "./fieldsSlice";
import {FieldsTable} from "../../components/fields-table/FieldsTable";
import {
    selectOrderBy,
    selectPage,
    selectPerPage,
    selectSearchValue,
    selectSort
} from "../fieldsListPage/fieldsSlice";
import {FieldParamsBar} from "../../components/shared/field-params-bar/FieldParamsBar";
import {FieldPageFooter} from "../../components/field-page-footer/FieldPageFooter";
import {changeSearchBarContext} from "../../components/app/appSlice";

export const FieldsListPage= ()=>{

const dispatch= useDispatch()
    const page = useSelector(selectPage)
    const perPage= useSelector(selectPerPage)
    const orderBy = useSelector(selectOrderBy)
    const sort = useSelector(selectSort)
    const searchValue = useSelector(selectSearchValue)
    const type = useSelector(selectType)
    const surface = useSelector(selectSurface)

    useEffect(()=>{
        dispatch(changeSearchBarContext("fields"))
    })
    useEffect(()=> {

        dispatch(getFields())

    } , [page ,perPage,orderBy,sort ,searchValue,type,surface])

    return (
        <>
        <div className={styles.global}>
            <FieldParamsBar/>
        <FieldsTable/>
            <FieldPageFooter/>
        </div>
        </>


    )

}