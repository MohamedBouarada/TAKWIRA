import {usersData} from "./usersData"
import styles from "./usersTable.module.css"
import {UserRow} from "../user-row/UserRow";



export const UsersTable = ()=>{


    return (
        <>
            <main className={styles.global}>
                <table className={styles.table}>
                    <thead>
                    <th>image</th>
                    <th>name</th>
                    <th>createdAt</th>
                    <th>email</th>
                    <th>phone number</th>
                    <th>Delete</th>
                    <th>Action</th>
                    </thead>
                    <tbody>

            {usersData.map((element)=> {
                const {id,name,phoneNumber,createdAt,email,image} = element;
                return (
                    <UserRow
                        key={id}
                        name={name}
                        phoneNumber={phoneNumber}
                        createdAt={createdAt}
                        email={email}
                        image={image}
                    />
                )
            })}

                    </tbody>
                </table>
            </main>
        </>
    )
}