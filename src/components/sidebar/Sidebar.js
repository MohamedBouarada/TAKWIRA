import {SidebarElement} from "../sidebar-element/SidebarElement";
import styles from "./sidebar.module.css"
import {useState} from "react";

export  const Sidebar = ()=>{
const [isHovering,setIsHovering] = useState(1);


    return(
        <nav className={styles.navbar} onMouseEnter={()=>setIsHovering(0)} onMouseLeave={()=>setIsHovering(1)}>
            <ul className={styles.navbarNav}>
                <SidebarElement hover={isHovering} isLogo={true}/>
                <SidebarElement hover={isHovering}/>
                <SidebarElement hover={isHovering}/>
                <SidebarElement hover={isHovering}/>
            </ul>



        </nav>
    )
}