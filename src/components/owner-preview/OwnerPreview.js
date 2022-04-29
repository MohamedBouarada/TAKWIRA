import styles from "../fields-preview/fliedsPreview.module.css";


export const OwnerPreview = ({firstName, lastName,image,email,phoneNumber})=>{


    return (
        <>
            <div className={styles.global}>
                <div className={styles.displayRow}>
                    <div>{firstName} {lastName}</div>
                    <div className={styles.fieldImage}><img src={image} alt="owner image"/></div>
                </div>
                <div className={styles.displayRow}>
                    <div>email</div>
                    <div> {email}</div>
                </div>
                <div className={styles.displayRow}>
                    <div>phone</div>
                    <div>{ phoneNumber}</div>
                </div>
                <div className={styles.viewMore}>view more</div>
            </div>

        </>
    )
}