
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'


import styles from "./sidebarElement.module.css"
import {useDispatch, useSelector} from "react-redux";
import {clicking, selectSideBarClicking, selectSideBarHovering} from "../sidebar/sidebarSlice";
export const SidebarElement = ({index,icon,title,linked})=> {

    const hover =useSelector(selectSideBarHovering);
    const clickIndex = useSelector(selectSideBarClicking)

    const navLinkClassName = index===clickIndex ? `${styles.navLinkClicked} ${styles.navLink}` : `${styles.navLink}`
    const dispatch = useDispatch();
    return (
        <>
<li className={styles.navItem} onClick={()=>dispatch(clicking(index))}>
    <a  href={`${linked}`} className={navLinkClassName}>
            <FontAwesomeIcon icon={icon } />
        {!hover && (<span>{title}</span>)}
    </a>
</li>
        </>
    )
}