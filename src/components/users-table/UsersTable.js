
import styles from "./usersTable.module.css"
import {UserRow} from "../user-row/UserRow";
import {useDispatch, useSelector} from "react-redux";
import {changeOrderAndSort, selectOrderBy, selectSort, selectUsersList} from "../../pages/userListPage/userSlice";
import {faChevronDown, faChevronUp, faCircleUser} from "@fortawesome/free-solid-svg-icons";
import {tableHeaders} from "./usersData";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'


export const UsersTable = ()=>{
const dispatch = useDispatch()
const usersList = useSelector(selectUsersList)
    const orderBy = useSelector(selectOrderBy)
    const sort = useSelector(selectSort)
    const icon = sort==="ASC"? <FontAwesomeIcon icon={faChevronUp}/> : <FontAwesomeIcon icon={faChevronDown}/>

    return (
        <>
            <main >
                <table className={styles.table}>
                    <thead>
                    <th >image</th>
                    {tableHeaders.map((element,index)=>{
                        const order = element==="name" ? "firstName" : element
                        return (

                            <th  key={index} onClick={()=>dispatch(changeOrderAndSort(order))} >
                                {element}
                                 &nbsp;&nbsp;{order===orderBy&&(
                                    icon
                                )}
                            </th>

                        )
                    })}
                    <th>Delete</th>
                    <th>Action</th>
                    </thead>
                    <tbody>

            { usersList.length>0 && (usersList.map((element)=> {
                const {id,firstName,lastName,phoneNumber,createdAt,email} = element;
                return (
                    <UserRow
                        key={id}
                        name={`${firstName} ${lastName}`}
                        phoneNumber={phoneNumber}
                        createdAt={createdAt}
                        email={email}
                        image={faCircleUser}
                        id={id}
                    />
                )
            }))}

                    </tbody>
                </table>
            </main>
        </>
    )
}