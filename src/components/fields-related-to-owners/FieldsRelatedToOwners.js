
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faCaretLeft, faCaretRight, faPlus} from "@fortawesome/free-solid-svg-icons";
import {FieldsPreview} from "../fields-preview/FieldsPreview";
import styles from  "./fieldsRelatedToOwners.module.css"
import {FieldsExampleData} from "./fieldsExampleData";
export const FieldsRelatedToOwners = ()=> {

    const {id,image,fieldName,address,createdAt} = FieldsExampleData[0]

    return(
        <>
            <div className={styles.global}>
                <div className={styles.title}>Fields</div>
                <div className={styles.displayRow}>
                    <div className={styles.icon}> <FontAwesomeIcon icon={faCaretLeft}/></div>
                    <div> <FieldsPreview image={image} fieldName={fieldName}  address={address} createdAt={createdAt}/></div>
                    <div className={styles.icon}> <FontAwesomeIcon icon={faCaretRight}/></div>
                </div>
                <div className={styles.addField}>
                  <FontAwesomeIcon icon={faPlus}/>  &nbsp; add Field
                </div>

            </div>

        </>
    )

}