
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faBan, faEdit, faTrashCan, faUserShield} from "@fortawesome/free-solid-svg-icons";
import styles from "./options.module.css"
import {useSelector} from "react-redux";
import {selectInfoRole} from "../../../pages/userFormPage/userInfoSlice";
export const Options = ()=>{

    const role = useSelector(selectInfoRole)
    const display = role==="ADMIN" || role==="CLIENT" ?  styles.displayColumn : styles.displayRow
    const icon = role!=="OWNER_REQUEST" ? faBan : faUserShield
    const banOptionText = role!=="OWNER_REQUEST" ? "Ban" : "approve "
    return (
        <>
        <div className={`${display} ${styles.global}`}>
            <div className={styles.edit}><FontAwesomeIcon icon={faEdit}/> Edit</div>
            <div className={styles.delete}><FontAwesomeIcon icon={faTrashCan}/> Delete</div>
            <div className={styles.ban}> <FontAwesomeIcon icon={icon }/> {banOptionText}</div>
        </div>

        </>
    )
}