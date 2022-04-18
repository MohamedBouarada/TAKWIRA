import styles from "./paramsBar.module.css"
import {Button} from "../button/Button";
import {userSelectOptions} from "./userSelectOptions";
import {useState} from "react";
import {useDispatch} from "react-redux";
import {changeRole} from "../../../pages/userListPage/userSlice";
import {changeUserFirstName, changeUserId, initState} from "../../../pages/userFormPage/userInfoSlice";
import {useNavigate} from "react-router-dom";



export const ParamsBar = ()=> {
    let navigator = useNavigate()
        const [roleOption,setRoleOption] = useState(userSelectOptions[0])
    const dispatch = useDispatch()
    const handleChange=(e)=> {
            dispatch(changeRole(e.target.value))
            setRoleOption(e.target.value)
    }
    const handleAddNewClick = ()=> {

        dispatch(initState())
        navigator("/user/add")
    }
    return(
        <>
            <div className={styles.global}>
                <div >
                    <select className={styles.selectRole} name="roleOption"  value={roleOption} onChange={handleChange}>

                        {userSelectOptions.map((element,index)=> {
                            return (
                                <option value={element} key={index}>
                                    {element}
                                </option>
                            )
                        })}
                    </select>
                </div>
            <div onClick={handleAddNewClick} >
                <Button buttonText={"ADD NEW +"} width={"150px"} backgroundColor={ "rgba(54, 198, 41, 0.66)"} height={"50px"}/>
            </div>


            </div>

        </>
    )

}