
import styles from "./fliedsPreview.module.css"
import {changeFieldId} from "../../pages/field-form-page/fieldInfoSlice";
import {useDispatch} from "react-redux";
import {useNavigate} from "react-router-dom";


export const FieldsPreview= ({id,image,fieldName,address,createdAt})=> {
    const dispatch = useDispatch()
    const navigate = useNavigate()


    return(

        <>
        <div className={styles.global}>
            <div className={styles.displayRow}>
                <div>{fieldName}</div>
                <div className={styles.fieldImage}><img src={`http://192.168.49.148:5000/static/${image}`} alt="field image" style={{width:"270px",height:"130px"}}/></div>
            </div>
            <div className={styles.displayRow}>
                <div>address</div>
                <div> {address}</div>
            </div>
            <div className={styles.displayRow}>
                <div>createdAt</div>
                <div> { new Date(createdAt).toLocaleString()}</div>
            </div>
            <div className={styles.viewMore} onClick={()=>{dispatch(changeFieldId(id)) ;navigate("/fields/details")}}>view more</div>
        </div>

        </>
    )
}