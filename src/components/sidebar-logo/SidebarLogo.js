
import styles from "./sidebarLogo.module.css"
import {useDispatch, useSelector} from "react-redux";
import {clicking, selectSideBarHovering} from "../sidebar/sidebarSlice";

export const SidebarLogo = ()=> {
    const hover =useSelector(selectSideBarHovering);
    const dispatch = useDispatch()
    return (
        <>
            <li className={styles.logo} onClick={()=>dispatch(clicking(-1))}>
                <a href="#" className={styles.navLink}>
            <img src="/assets/images/T1.png" alt="" className={styles.logoImage}/>
                    {!hover &&( <span className={styles.logoText}> TAKWIRA</span>)}
                </a>
            </li>
        </>
    )

}