
import styles from "./searchBar.module.css"
import {useDispatch, useSelector} from "react-redux";
import {useState} from "react";
import {changeSearch} from "../../../pages/userListPage/userSlice";
import {selectAppSearchbarContext} from "../../app/appSlice";
import {changeFieldsSearch} from "../../../pages/fieldsListPage/fieldsSlice";


export const SearchBar =()=> {

const dispatch = useDispatch()
    const context = useSelector(selectAppSearchbarContext)
    const [inputValue,setInputValue] = useState("")
    const handleChange = (e)=> {
    if(context==="users") {
        dispatch(changeSearch(e.target.value))
    }else if(context==="fields"){
        dispatch(changeFieldsSearch(e.target.value))
    }

    setInputValue(e.target.value)
    }

    return (
        <>
            <div className={styles.bar}>
            <div className={styles.title}> User list</div>
                <form >
             <input name="search" className={styles.input}  placeholder="search..." value={inputValue} onChange={handleChange}/>

                </form>

                <img src="/assets/images/logo_green.png" alt="logo_takwira"/>
            </div>
        </>

    )
}