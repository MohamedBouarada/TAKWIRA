
import styles from "./sidebarLogo.module.css"
import {useSelector} from "react-redux";
import {selectSideBarHovering} from "../sidebar/sidebarSlice";

export const SidebarLogo = ()=> {
    const hover =useSelector(selectSideBarHovering);
    return (
        <>
            <li className={styles.logo}>
                <a href="#" className={styles.navLink}>
            <img src="/assets/images/T1.png" alt="" className={styles.logoImage}/>
                    {!hover &&( <span className={styles.logoText}> TAKWIRA</span>)}
                </a>
            </li>
        </>
    )

}