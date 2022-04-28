import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import {Button} from "../shared/button/Button";
import styles from "../user-row/userRow.module.css";
import {faEdit, faEllipsis, faInfoCircle, faXmark} from "@fortawesome/free-solid-svg-icons";
import {changeUserEdit, changeUserId} from "../../pages/userFormPage/userInfoSlice";
import {useState} from "react";
import {useDispatch} from "react-redux";
import {useNavigate} from "react-router-dom";
import {changeFieldId} from "../../pages/field-form-page/fieldInfoSlice";


export const FieldRow  = ({id,name,image,adresse,services,createdAt})=> {
    const dispatch = useDispatch()
    const navigate = useNavigate()
    const [actionClicked,setActionClicked] = useState(false)
    const showActionsMenu=()=> setActionClicked(true)
    const discardActionsMenu = ()=>setActionClicked(false)
    const bgColor = actionClicked? styles.rowBgColorClicked : styles.rowBgColor
    return (
        <tr
           className={`${bgColor}`}
        >

            <td > <FontAwesomeIcon icon={image}/> </td>
            <td> <span>{name}</span> </td>
            <td> <span>{   new Date(createdAt).toLocaleDateString()}</span> </td>
            <td> <span>{adresse}</span> </td>
            <td> <span>{services}</span> </td>
            <td><div onClick={()=>console.log("&&&&")}> <Button buttonText={'delete'} backgroundColor={'#DC3545'} width={"70px"} height={"22px"}  /> </div> </td>
            <td >
                {!actionClicked &&(
                    <div className={styles.actionsButton}
                         onClick={showActionsMenu}
                    >

                        <FontAwesomeIcon icon={faEllipsis}/>
                    </div>
               )
                        }

                {actionClicked && (
                    <div className={styles.actionsMenu}>
                        <div
                           onClick={()=>{dispatch(changeFieldId(id)) ;navigate("/fields/details")}}
                        >
                            <FontAwesomeIcon icon={faInfoCircle}/>
                        </div>
                        <div
                         onClick={()=>{dispatch(changeUserId(id));dispatch(changeUserEdit(true));navigate("/user/add")}}
                        >
                            <FontAwesomeIcon icon={faEdit}/>
                        </div>
                        <div
                           onClick={()=>discardActionsMenu()}
                        >
                            <FontAwesomeIcon icon={faXmark}/>
                        </div>
                    </div>
                )
                        }

            </td>

        </tr>
    )
}