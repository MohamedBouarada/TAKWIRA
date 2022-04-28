import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import styles from "./userDetailsPage.module.css"
import {faXmarkCircle} from "@fortawesome/free-solid-svg-icons";
import {useNavigate} from "react-router-dom";
import {clientExample} from "./userExampleData";
import {UserSingleInfo} from "../../components/user-single-info/UserSingleInfo";
import {Options} from "../../components/shared/options/Options";
import {FieldsRelatedToOwners} from "../../components/fields-related-to-owners/FieldsRelatedToOwners";
import {useDispatch, useSelector} from "react-redux";
import {useEffect} from "react";
import {
    getSingleUser, selectFieldsRelatedToUser, selectInfoCreatedAt, selectInfoEmail,
    selectInfoFirstName,
    selectInfoId,
    selectInfoLastName, selectInfoPhoneNumber,
    selectInfoRole, selectInfoUpdatedAt
} from "../userFormPage/userInfoSlice";

export const UserDetailsPage = ()=> {
    const dispatch = useDispatch()
    const id= useSelector(selectInfoId);
    const firstName= useSelector(selectInfoFirstName);
    const lastName= useSelector(selectInfoLastName);
    const role= useSelector(selectInfoRole);
    const email= useSelector(selectInfoEmail);
    const phoneNumber= useSelector(selectInfoPhoneNumber);
    const createdAt= useSelector(selectInfoCreatedAt);
    const updatedAt= useSelector(selectInfoUpdatedAt);
    const fields = useSelector(selectFieldsRelatedToUser)
    useEffect( ()=>{
        dispatch(getSingleUser())
    }, [id])

    let navigate = useNavigate()

    const display = role==="ADMIN" || role==="CLIENT" ? styles.displayRow : styles.displayColumn
    const globalDisplay = role==="ADMIN" || role==="CLIENT" ? styles.displayColumn : styles.displayRow

    return (
        <>

       <div className={`${styles.container} ${globalDisplay}`}>
           <div className={styles.closeMark} onClick={()=>navigate("/")}> <FontAwesomeIcon icon={faXmarkCircle}/></div>
           <div  className={`${display}`}>

            <div className={styles.detailsContainer}>
                <UserSingleInfo title="id" content={id}/>
                <UserSingleInfo title="firstName" content={firstName} />
                <UserSingleInfo title="lastName" content={lastName}/>
            <UserSingleInfo title="email" content={email}/>
                <UserSingleInfo title="phoneNumber" content={phoneNumber}/>
                <UserSingleInfo title="role" content={role}/>
            <UserSingleInfo title="createdAt" content={ new Date(createdAt).toLocaleString()}/>
            <UserSingleInfo title="updatedAt" content={new Date(updatedAt).toLocaleString()}/>


            </div>

           <div className={styles.options}>
               <Options/>
           </div>
       </div>
           {(role==="OWNER" || role==="OWNER_REQUEST") && fields.length>0 && (
               <div>

                   <FieldsRelatedToOwners/>

               </div>
           )}



       </div>
        </>
    )
}