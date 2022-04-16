
import styles from "./userFormPage.module.css"
import {useState} from "react";
import {useDispatch, useSelector} from "react-redux";
import {
    addOneUser,
    changeUserEmail,
    changeUserFirstName,
    changeUserLastName,
    changeUserPassword,
    changeUserPhoneNumber,
    changeUserRepeatPassword,
    changeUserRole,
    selectInfoCreatedAt,
    selectInfoEmail,
    selectInfoFirstName,
    selectInfoId,
    selectInfoLastName,
    selectInfoPassword,
    selectInfoPhoneNumber,
    selectInfoRepeatPassword,
    selectInfoRole,
    selectInfoUpdatedAt
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

    const [firstName,setFirstName] = useState(infoFirstName)
    const [lastName,setLastName] = useState(infoLastName)
    const [phoneNumber ,setPhoneNumber] = useState(infoPhoneNumber)
    const [email,setEmail] = useState(infoEmail)
    const [password,setPassword] = useState(infoPassword)
    const [repeatPassword,setRepeatPassword]= useState(infoRepeatPassword)
    const [role,setRole] = useState(infoRole)
    let navigate = useNavigate()

        const handleSubmit=() => {
            dispatch(changeUserFirstName(firstName))
            dispatch(changeUserLastName(lastName))
            dispatch(changeUserEmail(email))
            dispatch(changeUserPassword(password))
            dispatch(changeUserRepeatPassword(repeatPassword))
            dispatch(changeUserPhoneNumber(phoneNumber))
            dispatch(changeUserRole(role))
            dispatch(addOneUser())
            navigate("/details")


    }
    console.log("rooooooooooooooooole   " ,role)

    return (
        <>
<div className={styles.global}>
    <div className={styles.displayColumn}>
    <div>
        <select name="selectRole"  value={role} onChange={(e)=>setRole(e.target.value)}>
            <option value="CLIENT">CLIENT</option>
            <option value="OWNER">OWNER</option>
            <option value="ADMIN">ADMIN</option>

        </select>
            <form >


                    <label htmlFor="firstName">First Name</label>
                <div>
                <input type="text" name="firstName" required value={firstName} onChange={(e)=>setFirstName(e.target.value)}/>
                </div>
                <label htmlFor="lastName">Last Name</label>
                <div>
                <input type="text" name="lastName" required value={lastName} onChange={(e)=>setLastName(e.target.value)}/>
                </div>
                <label htmlFor="phoneNumber"> Phone Number</label>
                <div>
                <input type="text" name="phoneNumber" required value={phoneNumber} onChange={(e)=>setPhoneNumber(e.target.value)}/>
                </div>
                <label htmlFor="email"> Email</label>
                <div>
                <input type="email" name="email" required value={email} onChange={(e)=>setEmail(e.target.value)}/>
                </div>
                <label htmlFor="password"> Create Password</label>
                <div>
                <input type="password" name="password" required value={password} onChange={(e)=>setPassword(e.target.value)}/>
                </div>
                <label htmlFor="repeatPassword"> Repeate Password</label>
                <div>
                    <input type="password" name="repeatPassword" required value={repeatPassword} onChange={(e)=>setRepeatPassword(e.target.value)}/>
                </div>

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