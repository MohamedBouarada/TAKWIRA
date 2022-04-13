
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faChevronLeft, faChevronRight} from "@fortawesome/free-solid-svg-icons";
import {PageNumberSingleItem} from "../pageNumberSingleItem/PageNumberSingleItem";

import styles from "./footerPagination.module.css"
export const FooterPagination = ()=> {


    return (
        <>
        <div className={styles.global}>
            <div className={styles.title}>Display</div>
            <form >
            <input type="number" className={styles.input}/>
            </form>
            <button className={styles.icon}>  <FontAwesomeIcon icon={faChevronLeft}/> </button>

            {
                [...Array(10)].map((element,index)=> <PageNumberSingleItem key={index}/>)
            }


           <button className={styles.icon}> <FontAwesomeIcon icon={faChevronRight}/></button>
        </div>

        </>
    )
}