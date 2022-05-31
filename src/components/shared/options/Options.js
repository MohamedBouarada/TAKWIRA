
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faBan, faEdit, faTrashCan, faUserShield} from "@fortawesome/free-solid-svg-icons";
import styles from "./options.module.css"
import {useDispatch, useSelector} from "react-redux";
import {changeUserEdit, changeUserId, selectInfoRole,selectInfoId} from "../../../pages/userFormPage/userInfoSlice";
import {useNavigate} from "react-router-dom";
export const Options = ()=>{

    const role = useSelector(selectInfoRole)
    const id= useSelector(selectInfoId)
    const display = role==="ADMIN" || role==="CLIENT" ?  styles.displayColumn : styles.displayRow
    const icon = role!=="OWNER_REQUEST" ? faBan : faUserShield
    const banOptionText = role!=="OWNER_REQUEST" ? "Ban" : "approve "
    const dispatch = useDispatch()
    const navigate = useNavigate()

    return (
        <>
        <div className={`${display} ${styles.global}`}>
            <div className={styles.edit} onClick={()=>{dispatch(changeUserId(id));dispatch(changeUserEdit(true));navigate("/user/add")}}><FontAwesomeIcon icon={faEdit}/> Edit</div>
            <div className={styles.delete}><FontAwesomeIcon icon={faTrashCan}/> Delete</div>
            <div className={styles.ban}> <FontAwesomeIcon icon={icon }/> {banOptionText}</div>
        </div>

        </>
    )
}