import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {Button} from "../shared/button/Button";
import {faEdit, faEllipsis, faInfoCircle, faXmark} from "@fortawesome/free-solid-svg-icons";

import styles from "./userRow.module.css"
import {useState} from "react";
import {useDispatch} from "react-redux";
import {changeUserEdit, changeUserId, deleteUser} from "../../pages/userFormPage/userInfoSlice";
import {useNavigate} from "react-router-dom";

export const UserRow =({id,name,image,phoneNumber,email,createdAt})=> {
    const dispatch = useDispatch()
    const navigate = useNavigate()
const [actionClicked,setActionClicked] = useState(false)
    const showActionsMenu=()=> setActionClicked(true)
    const discardActionsMenu = ()=>setActionClicked(false)
    console.log(actionClicked)
    const bgColor = actionClicked? styles.rowBgColorClicked : styles.rowBgColor
    return (
        <tr className={`${bgColor}`}>

            <td > <FontAwesomeIcon icon={image}/> </td>
            <td> <span>{name}</span> </td>
            <td> <span>{   new Date(createdAt).toLocaleDateString()}</span> </td>
            <td> <span>{email}</span> </td>
            <td> <span>{phoneNumber}</span> </td>
            <td><div onClick={()=> {
                  dispatch(deleteUser(id)) ; navigate("/")
            }}> <Button buttonText={'delete'} backgroundColor={'#DC3545'} width={"70px"} height={"22px"}  /> </div> </td>
            <td >
                {!actionClicked &&(
                <div className={styles.actionsButton} onClick={showActionsMenu}>

                    <FontAwesomeIcon icon={faEllipsis}/>
                </div>
                )}

                {actionClicked && (
                    <div className={styles.actionsMenu}>
                        <div onClick={()=>{dispatch(changeUserId(id)) ; navigate("/details")}}>
                            <FontAwesomeIcon icon={faInfoCircle}/>
                        </div>
                        <div onClick={()=>{dispatch(changeUserId(id));dispatch(changeUserEdit(true));navigate("/user/add")}}>
                            <FontAwesomeIcon icon={faEdit}/>
                        </div>
                        <div onClick={()=>discardActionsMenu()}>
                            <FontAwesomeIcon icon={faXmark}/>
                        </div>
                    </div>
                )}

            </td>

        </tr>
    )
}