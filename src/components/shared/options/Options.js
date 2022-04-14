
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faBan, faEdit, faTrashCan} from "@fortawesome/free-solid-svg-icons";
import styles from "./options.module.css"
export const Options = ()=>{


    return (
        <>
        <div className={styles.global}>
            <div className={styles.edit}><FontAwesomeIcon icon={faEdit}/> Edit</div>
            <div className={styles.delete}><FontAwesomeIcon icon={faTrashCan}/> Delete</div>
            <div className={styles.ban}> <FontAwesomeIcon icon={faBan}/> Ban</div>
        </div>

        </>
    )
}