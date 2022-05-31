
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faCaretLeft, faCaretRight, faPlus} from "@fortawesome/free-solid-svg-icons";
import {FieldsPreview} from "../fields-preview/FieldsPreview";
import styles from  "./fieldsRelatedToOwners.module.css"
import {FieldsExampleData} from "./fieldsExampleData";
import {useDispatch, useSelector} from "react-redux";
import {
    decrementFieldIndex, incrementFieldIndex, selectCurrentFieldIndex,
    selectCurrentFieldShowed, selectFieldsRelatedToUser,

} from "../../pages/userFormPage/userInfoSlice";

export const FieldsRelatedToOwners = ()=> {

   // const {image} = FieldsExampleData[0]

    const dispatch = useDispatch()
    const fieldShowed= useSelector(selectCurrentFieldShowed)
    console.log(fieldShowed)

     const {id,name,adresse,createdAt,images} = fieldShowed
        const image = JSON.parse(images)

    return(
        <>

                <div className={styles.global}>

                    <div className={styles.title}>Fields</div>
                    <div className={styles.displayRow}>
                        <div className={styles.icon} onClick={()=>dispatch(decrementFieldIndex())}> <FontAwesomeIcon icon={faCaretLeft}/></div>
                        <div> <FieldsPreview  id={id}image={image[0].name} fieldName={name}  address={adresse} createdAt={createdAt}/></div>
                        <div className={styles.icon} onClick={()=>dispatch(incrementFieldIndex())}> <FontAwesomeIcon icon={faCaretRight}/></div>
                    </div>
                    <div className={styles.addField}>
                        <FontAwesomeIcon icon={faPlus}/>  &nbsp; add Field
                    </div>

                </div>



        </>
    )

}