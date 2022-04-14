
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faChevronLeft, faChevronRight} from "@fortawesome/free-solid-svg-icons";
import {PageNumberSingleItem} from "../pageNumberSingleItem/PageNumberSingleItem";

import styles from "./footerPagination.module.css"
import {useDispatch, useSelector} from "react-redux";
import {
    changePerPage,
    decrementPage,
    incrementPage,
    selectPagesNumber,
    selectPerPage, selectUsersCount
} from "../../pages/userListPage/userSlice";
import {useRef, useState} from "react";

export const FooterPagination = ()=> {
    const dispatch = useDispatch();
const numberPages = useSelector(selectPagesNumber)
    const perPage = useSelector(selectPerPage)
    const total = useSelector(selectUsersCount)
    console.log(perPage)

const [inputValue,setInputValue] = useState(perPage)
    const handleChange = (e)=> {
    const value= parseInt(e.target.value , 10)
        dispatch(changePerPage(value))
    setInputValue(e.target.value);

    }

    return (
        <>
        <div className={styles.global}>
            <div className={styles.title}>Display</div>


            <input type="number" className={styles.input}  min="1" max={total}
                   value={inputValue} onChange={handleChange}

            />


            <button
                className={styles.icon}
                onClick={()=>dispatch(decrementPage())}

            >
                <FontAwesomeIcon icon={faChevronLeft}/>
            </button>

            {
                [...Array(numberPages)].map((element,index)=> <PageNumberSingleItem key={index} num={index+1}/>)
            }


           <button
               className={styles.icon}
               onClick={()=>dispatch(incrementPage())}

           >
               <FontAwesomeIcon icon={faChevronRight}/>
           </button>
        </div>

        </>
    )
}