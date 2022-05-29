import styles from "../fields-related-to-owners/fieldsRelatedToOwners.module.css";
import {decrementFieldIndex, incrementFieldIndex} from "../../pages/userFormPage/userInfoSlice";
import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import {faCaretLeft, faCaretRight, faPlus} from "@fortawesome/free-solid-svg-icons";
import {FieldsPreview} from "../fields-preview/FieldsPreview";
import {FieldsExampleData} from "../fields-related-to-owners/fieldsExampleData";
import {OwnerPreview} from "../owner-preview/OwnerPreview";
import {useDispatch, useSelector} from "react-redux";
import {
    decrementIndex, incrementIndex, selectFieldCurrentImage,
    selectFieldCurrentIndex,
    selectFieldImages,
    selectFieldInfoRelatedOwner,
    selectFieldInfoUserId
} from "../../pages/field-form-page/fieldInfoSlice";
import {useState} from "react";


export const OwnerRelatedToField = ()=> {

    const {image} = FieldsExampleData[0]
    const dispatch = useDispatch()
    const relatedUser = useSelector(selectFieldInfoRelatedOwner)
    const {firstName,lastName,email,phoneNumber,role} = relatedUser;
    const userId = useSelector(selectFieldInfoUserId)
    const currentImage = useSelector(selectFieldCurrentImage)

    return (
        <>
            <div className={styles.global}>

                <div className={styles.displayRow} style={{paddingBottom:"10px" ,paddingLeft:"50px"}}>
                    <div className={styles.icon} onClick={()=>dispatch(decrementIndex())}> <FontAwesomeIcon icon={faCaretLeft}/></div>
                    <img src={`http://localhost:5000/static/${currentImage}`} style={{width:"300px",height:"150px"}}/>
                    <div className={styles.icon} onClick={()=>dispatch(incrementIndex())}> <FontAwesomeIcon icon={faCaretRight}/></div>
                </div>
                <div className={styles.title}>{role}</div>
                <div className={styles.displayRow}>

                    <div> <OwnerPreview  id={userId} image={image} firstName={firstName} lastName={lastName} email={email} phoneNumber={phoneNumber} /></div>
                </div>

            </div>
        </>
    )
}