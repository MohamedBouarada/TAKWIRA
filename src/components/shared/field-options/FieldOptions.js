import styles from "../options/options.module.css";
import {changeUserEdit, changeUserId, selectInfoId, selectInfoRole} from "../../../pages/userFormPage/userInfoSlice";
import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import {faBan, faEdit, faTrashCan, faUserShield} from "@fortawesome/free-solid-svg-icons";
import {useDispatch, useSelector} from "react-redux";
import {useNavigate} from "react-router-dom";


export const FieldOptions = ()=> {
    const role = useSelector(selectInfoRole)
    const id= useSelector(selectInfoId)

    const dispatch = useDispatch()
    const navigate = useNavigate()
    const icon = role!=="OWNER_REQUEST" ? faBan : faUserShield
    const banOptionText = role!=="OWNER_REQUEST" ? "Ban" : "approve "
    return (
        <>
            <>
                <div className={`${styles.displayColumn} ${styles.global}`}>
                    <div className={styles.edit} onClick={()=>{dispatch(changeUserId(id));dispatch(changeUserEdit(true));navigate("/user/add")}}><FontAwesomeIcon icon={faEdit}/> Edit</div>
                    <div className={styles.delete}><FontAwesomeIcon icon={faTrashCan}/> Delete</div>
                    <div className={styles.ban}> <FontAwesomeIcon icon={icon }/> {banOptionText}</div>
                </div>

            </>
        </>
    )
}