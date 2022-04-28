
import styles from "./pageNumberSingleItem.module.css"


export const PageNumberSingleItem = ({num , page})=> {

    const background = page===num ? styles.clicked : styles.notClicked

    return (
        <>

        <div className={`${styles.global} ${background}` }>{num}</div>
        </>
    )
}