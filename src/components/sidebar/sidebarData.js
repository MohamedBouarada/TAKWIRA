
import {faArrowRightFromBracket,faGripHorizontal ,faUserGroup ,faBuildingUser,faHandHoldingDollar,faSliders,faChartColumn} from "@fortawesome/free-solid-svg-icons"

export const sidebarData= [
    {
        id:1,
        icon :faGripHorizontal,
        title : "Dashboard",
        linked : "/"
    },
    {
        id:2,
        icon :faUserGroup,
        title : "Users",
        linked: "/"
    },
    {
        id:3,
        icon :faBuildingUser,
        title : "Fields",
        linked: "/fields/list"
    },
    {
        id:4,
        icon :faHandHoldingDollar,
        title : "Add user",
        linked: "/user/add"
    },
    {
        id:5,
        icon :faChartColumn,
        title : "Statistics",
        linked: "#"
    },
    {
        id:6,
        icon :faSliders,
        title : "Profile" ,
        linked: "#"
    },
    {
        id:7,
        icon :faArrowRightFromBracket,
        title : "Logout",
        linked: "#"
    }

]