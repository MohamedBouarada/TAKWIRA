import {SidebarElement} from "../sidebar-element/SidebarElement";
import styles from "./sidebar.module.css"
import {sidebarData} from "./sidebarData";
import {SidebarLogo} from "../sidebar-logo/SidebarLogo";
import {useDispatch, useSelector} from "react-redux";
import {hovering, notHovering, clicking,  selectSideBarClicking} from "./sidebarSlice";

export  const Sidebar = ()=>{


    const dispatch = useDispatch();



    return(
        <nav className={styles.navbar} onMouseEnter={()=>dispatch(hovering())} onMouseLeave={()=>dispatch(notHovering())}>
            <ul className={styles.navbarNav}>
            <SidebarLogo  />
                {sidebarData.map((element,index)=> <SidebarElement  index={index} linked={element.linked} key={element.id}  icon={element.icon} title={element.title}/>)}

            </ul>



        </nav>
    )
}