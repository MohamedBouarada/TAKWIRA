
import styles from "./fliedsPreview.module.css"


export const FieldsPreview= ({image,fieldName,address,createdAt})=> {



    return(

        <>
        <div className={styles.global}>
            <div className={styles.displayRow}>
                <div>{fieldName}</div>
                <div className={styles.fieldImage}><img src={image} alt="field image"/></div>
            </div>
            <div className={styles.displayRow}>
                <div>address</div>
                <div> {address}</div>
            </div>
            <div className={styles.displayRow}>
                <div>createdAt</div>
                <div> { new Date(createdAt).toLocaleString()}</div>
            </div>
            <div className={styles.viewMore}>view more</div>
        </div>

        </>
    )
}