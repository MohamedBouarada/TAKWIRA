
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faGear } from "@fortawesome/free-solid-svg-icons"

import styles from "./sidebarElement.module.css"
export const SidebarElement = ({hover,isLogo})=> {

    const className = isLogo? `${styles.logo}`:`${styles.navItem }`

    return (
        <>
<li className={className}>
    <a  href='#' className={styles.navLink}>
            <FontAwesomeIcon icon={faGear } />
        {!hover && (<span>text text text</span>)}
    </a>
</li>
        </>
    )
}