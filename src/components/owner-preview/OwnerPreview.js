import styles from "../fields-preview/fliedsPreview.module.css";
import {changeUserId, selectInfoId} from "../../pages/userFormPage/userInfoSlice";
import {useDispatch, useSelector} from "react-redux";
import {useNavigate} from "react-router-dom";


export const OwnerPreview = ({id,firstName, lastName,image,email,phoneNumber})=>{
    const dispatch = useDispatch()
    const navigate = useNavigate()
    //const id= useSelector(selectInfoId)

    return (
        <>
            <div className={styles.global}>
                <div className={styles.displayRow}>
                    <div>{firstName} {lastName}</div>
                    {/*<div className={styles.fieldImage}><img src={image} alt="owner image"/></div>*/}
                </div>
                <div className={styles.displayRow}>
                    <div>email</div>
                    <div> {email}</div>
                </div>
                <div className={styles.displayRow}>
                    <div>phone</div>
                    <div>{ phoneNumber}</div>
                </div>
                <div className={styles.viewMore} onClick={()=>{dispatch(changeUserId(id)) ; navigate("/details")}}>view more</div>
            </div>

        </>
    )
}