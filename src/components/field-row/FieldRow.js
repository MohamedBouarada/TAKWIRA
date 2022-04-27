import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import {Button} from "../shared/button/Button";
import styles from "../user-row/userRow.module.css";
import {faEdit, faEllipsis, faInfoCircle, faXmark} from "@fortawesome/free-solid-svg-icons";
import {changeUserEdit, changeUserId} from "../../pages/userFormPage/userInfoSlice";


export const FieldRow  = ({id,name,image,adresse,services,createdAt})=> {
    return (
        <tr
        //    className={`${bgColor}`}
        >

            <td > <FontAwesomeIcon icon={image}/> </td>
            <td> <span>{name}</span> </td>
            <td> <span>{   new Date(createdAt).toLocaleDateString()}</span> </td>
            <td> <span>{adresse}</span> </td>
            <td> <span>{services}</span> </td>
            <td><div onClick={()=>console.log("&&&&")}> <Button buttonText={'delete'} backgroundColor={'#DC3545'} width={"70px"} height={"22px"}  /> </div> </td>
            <td >
                {//!actionClicked &&(
                    <div className={styles.actionsButton} //onClick={showActionsMenu}
                    >

                        <FontAwesomeIcon icon={faEllipsis}/>
                    </div>
               // )
                        }

                {//actionClicked && (
                    <div className={styles.actionsMenu}>
                        <div
                        //    onClick={()=>{dispatch(changeUserId(id)) ;navigate("/details")}}
                        >
                            <FontAwesomeIcon icon={faInfoCircle}/>
                        </div>
                        <div
                        //    onClick={()=>{dispatch(changeUserId(id));dispatch(changeUserEdit(true));navigate("/user/add")}}
                        >
                            <FontAwesomeIcon icon={faEdit}/>
                        </div>
                        <div
                        //    onClick={()=>discardActionsMenu()}
                        >
                            <FontAwesomeIcon icon={faXmark}/>
                        </div>
                    </div>
               // )
                        }

            </td>

        </tr>
    )
}