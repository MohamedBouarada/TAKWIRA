
import styles from "./userSingleInfo.module.css"


export const UserSingleInfo = ({title,content})=> {


    return (
        <>
            <div className={styles.global}>
            <div className={styles.title}>{title}:  </div>
            <div className={styles.content}> {content}</div>
            </div>
        </>
    )
}