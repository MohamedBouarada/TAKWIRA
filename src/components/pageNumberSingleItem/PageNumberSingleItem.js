
import styles from "./pageNumberSingleItem.module.css"
import {useSelector} from "react-redux";
import {selectPage} from "../../pages/userListPage/userSlice";

export const PageNumberSingleItem = ({num})=> {
    const page = useSelector(selectPage);
    const background = page===num ? styles.clicked : styles.notClicked

    return (
        <>

        <div className={`${styles.global} ${background}` }>{num}</div>
        </>
    )
}