import {SidebarElement} from "../sidebar-element/SidebarElement";
import styles from "./sidebar.module.css"
import {useState} from "react";
import {sidebarData} from "./sidebarData";
import {SidebarLogo} from "../sidebar-logo/SidebarLogo";

export  const Sidebar = ()=>{
const [isHovering,setIsHovering] = useState(1);


    return(
        <nav className={styles.navbar} onMouseEnter={()=>setIsHovering(0)} onMouseLeave={()=>setIsHovering(1)}>
            <ul className={styles.navbarNav}>
            <SidebarLogo hover={isHovering}/>
                {sidebarData.map((element)=> <SidebarElement  key={element.id} hover={isHovering} icon={element.icon} title={element.title}/>)}

            </ul>



        </nav>
    )
}