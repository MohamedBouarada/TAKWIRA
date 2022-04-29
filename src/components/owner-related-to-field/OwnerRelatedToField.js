import styles from "../fields-related-to-owners/fieldsRelatedToOwners.module.css";
import {decrementFieldIndex, incrementFieldIndex} from "../../pages/userFormPage/userInfoSlice";
import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import {faCaretLeft, faCaretRight, faPlus} from "@fortawesome/free-solid-svg-icons";
import {FieldsPreview} from "../fields-preview/FieldsPreview";
import {FieldsExampleData} from "../fields-related-to-owners/fieldsExampleData";
import {OwnerPreview} from "../owner-preview/OwnerPreview";
import {useDispatch, useSelector} from "react-redux";
import {selectFieldInfoRelatedOwner, selectFieldInfoUserId} from "../../pages/field-form-page/fieldInfoSlice";


export const OwnerRelatedToField = ()=> {

    const {image} = FieldsExampleData[0]
    const dispatch = useDispatch()
    const relatedUser = useSelector(selectFieldInfoRelatedOwner)
    const {firstName,lastName,email,phoneNumber,role} = relatedUser;
    const userId = useSelector(selectFieldInfoUserId)

    return (
        <>
            <div className={styles.global}>
                <div className={styles.title}>{role}</div>
                <div className={styles.displayRow}>
                    <div> <OwnerPreview  id={userId} image={image} firstName={firstName} lastName={lastName} email={email} phoneNumber={phoneNumber} /></div>
                </div>

            </div>
        </>
    )
}