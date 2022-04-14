import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import styles from "./userDetailsPage.module.css"
import {faXmarkCircle} from "@fortawesome/free-solid-svg-icons";
import {useNavigate} from "react-router-dom";
import {clientExample} from "./userExampleData";
import {UserSingleInfo} from "../../components/user-single-info/UserSingleInfo";
import {Options} from "../../components/shared/options/Options";
import {FieldsRelatedToOwners} from "../../components/fields-related-to-owners/FieldsRelatedToOwners";

export const UserDetailsPage = ()=> {

    let navigate = useNavigate()
    const {id,firstName,lastName,role,email,createdAt,updatedAt,phoneNumber} = clientExample

    return (
        <>

       <div className={styles.container}>
           <div className={styles.closeMark} onClick={()=>navigate("/")}> <FontAwesomeIcon icon={faXmarkCircle}/></div>
           <div className={styles.userInfo}>

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
           <div>
               <FieldsRelatedToOwners/>
           </div>

       </div>
        </>
    )
}