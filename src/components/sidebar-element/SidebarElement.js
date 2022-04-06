
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'


import styles from "./sidebarElement.module.css"
export const SidebarElement = ({hover,icon,title})=> {



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