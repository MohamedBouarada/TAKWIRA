
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'


import styles from "./sidebarElement.module.css"
import {useSelector} from "react-redux";
import {selectSideBarHovering} from "../sidebar/sidebarSlice";
export const SidebarElement = ({icon,title})=> {

    const hover =useSelector(selectSideBarHovering);

    return (
        <>
<li className={styles.navItem}>
    <a  href='#' className={styles.navLink}>
            <FontAwesomeIcon icon={icon } />
        {!hover && (<span>{title}</span>)}
    </a>
</li>
        </>
    )
}