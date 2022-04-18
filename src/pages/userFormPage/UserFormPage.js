
import styles from "./userFormPage.module.css"
import {useEffect, useState} from "react";
import {useDispatch, useSelector} from "react-redux";
import {
    addOneUser,
    changeUserEmail,
    changeUserFirstName,
    changeUserLastName,
    changeUserPassword,
    changeUserPhoneNumber,
    changeUserRepeatPassword,
    changeUserRole, getSingleUser,
    selectInfoCreatedAt, selectInfoEdit,
    selectInfoEmail,
    selectInfoFirstName,
    selectInfoId,
    selectInfoLastName,
    selectInfoPassword,
    selectInfoPhoneNumber,
    selectInfoRepeatPassword,
    selectInfoRole,
    selectInfoUpdatedAt, updateUser
} from "./userInfoSlice";
import {useNavigate} from "react-router-dom";

export const UserFormPage = ()=> {



    const dispatch = useDispatch()
    const id= useSelector(selectInfoId);


    const infoFirstName= useSelector(selectInfoFirstName);
    const infoLastName= useSelector(selectInfoLastName);
    const infoRole= useSelector(selectInfoRole);
    const infoEmail= useSelector(selectInfoEmail);
    const infoPhoneNumber= useSelector(selectInfoPhoneNumber);
    const infoPassword = useSelector(selectInfoPassword)
    const infoRepeatPassword = useSelector(selectInfoRepeatPassword)
    const infoEdit = useSelector(selectInfoEdit)


    let navigate = useNavigate()

        const handleSubmit=() => {
if(infoEdit) {
    dispatch(updateUser())
}else {
    dispatch(addOneUser())
    navigate("/details")
}



    }
    useEffect(()=>{
if(infoEdit){
    dispatch(getSingleUser())
}



    }, [id])





    return (
        <>
<div className={styles.global}>
    <div className={styles.displayColumn}>
    <div  >
        <select  className={styles.roleOption} name="selectRole"  value={infoRole} onChange={(e)=>dispatch(changeUserRole(e.target.value))}>
            <option value="CLIENT">CLIENT</option>
            <option value="OWNER">OWNER</option>
            <option value="ADMIN">ADMIN</option>

        </select>
            <form >


                    <label htmlFor="firstName">First Name</label>
                <div>
                <input type="text" name="firstName" required value={infoFirstName} onChange={(e)=>dispatch(changeUserFirstName(e.target.value))}/>
                </div>
                <label htmlFor="lastName">Last Name</label>
                <div>
                <input type="text" name="lastName" required value={infoLastName} onChange={(e)=>dispatch(changeUserLastName(e.target.value))}/>
                </div>
                <label htmlFor="phoneNumber"> Phone Number</label>
                <div>
                <input type="text" name="phoneNumber" required value={infoPhoneNumber} onChange={(e)=>dispatch(changeUserPhoneNumber(e.target.value))}/>
                </div>
                <label htmlFor="email"> Email</label>
                <div>
                <input type="email" name="email" required value={infoEmail} onChange={(e)=>dispatch(changeUserEmail(e.target.value))}/>
                </div>
                {infoEdit===false && (
                    <>
                    <label htmlFor="password"> Create Password</label>
                    <div>
                    <input type="password" name="password" required value={infoPassword} onChange={(e)=>dispatch(changeUserPassword(e.target.value))}/>
                    </div>
                    <label htmlFor="repeatPassword"> Repeate Password</label>
                    <div>
                    <input type="password" name="repeatPassword" required value={infoRepeatPassword} onChange={(e)=>dispatch(changeUserRepeatPassword(e.target.value))}/>
                    </div>
                    </>
                )}


            </form>
    </div>
    <div className={styles.userImage}>
        <img  src="/assets/images/userImagePlaceholder.png" alt=" image placeholder"/>
    </div>
    </div>
<div className={styles.buttonSubmit} onClick={handleSubmit}>
    + ADD NEW CLIENT
</div>

</div>
        </>
    )
}