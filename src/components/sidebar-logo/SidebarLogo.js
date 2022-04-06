
import styles from "./sidebarLogo.module.css"

export const SidebarLogo = ({hover})=> {

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