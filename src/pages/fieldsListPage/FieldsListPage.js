
import styles from "./fieldsListPage.module.css"
import {useDispatch} from "react-redux";
import {useEffect} from "react";
import {getFields} from "./fieldsSlice";
import {FieldsTable} from "../../components/fields-table/FieldsTable";

export const FieldsListPage= ()=>{

const dispatch= useDispatch()

    useEffect(()=> {
        dispatch(getFields())
    } , [])

    return (
        <>
        <div className={styles.global}>
        <FieldsTable/>
        </div>
        </>


    )

}