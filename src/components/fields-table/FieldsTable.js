import {useDispatch, useSelector} from "react-redux";
    import {selectOrderBy, selectSort, selectFieldsList,changeOrderAndSort} from "../../pages/fieldsListPage/fieldsSlice";
import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import {faChevronDown, faChevronUp, faCircleUser} from "@fortawesome/free-solid-svg-icons";
import styles from "../users-table/usersTable.module.css";
import {tableHeaders} from "./fieldsData";

import {FieldRow} from "../field-row/FieldRow";


export const FieldsTable = ()=> {

    const dispatch = useDispatch()
    const fieldsList = useSelector(selectFieldsList)
    const orderBy = useSelector(selectOrderBy)
    const sort = useSelector(selectSort)
    const icon = sort==="ASC"? <FontAwesomeIcon icon={faChevronUp}/> : <FontAwesomeIcon icon={faChevronDown}/>


    return (
        <>
        <main >
            <main >
                <table className={styles.table}>
                    <thead>
                    <th >image</th>
                    {tableHeaders.map((element,index)=>{
                        return (

                            <th  key={index}
                                onClick={()=>dispatch(changeOrderAndSort(element))}
                            >
                                {element}
                                &nbsp;&nbsp;{element===orderBy&&(
                                icon
                            )}
                            </th>

                        )
                    })}
                    <th>Delete</th>
                    <th>Action</th>
                    </thead>
                    <tbody>

                    { fieldsList.length>0 && (fieldsList.map((element)=> {
                        const {id,name,adresse,services,createdAt,} = element;
                        return (
                            <FieldRow
                                key={id}
                                name={`${name} `}

                                createdAt={createdAt}
                                adresse={adresse}
                                services={services}
                                image={faCircleUser}
                                id={id}
                            />
                        )
                    }))}

                    </tbody>
                </table>
            </main>


        </main>


        </>
    )
}