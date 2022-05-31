import styles from "../userDetails/userDetailsPage.module.css";
import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import {faXmarkCircle} from "@fortawesome/free-solid-svg-icons";
import {UserSingleInfo} from "../../components/user-single-info/UserSingleInfo";
import {useNavigate} from "react-router-dom";
import {useEffect} from "react";
import {useDispatch, useSelector} from "react-redux";
import {
    getSingleField,
    selectFieldInfoAdresse,
    selectFieldInfoCreatedAt,
    selectFieldInfoDescription,
    selectFieldInfoId, selectFieldInfoIsNotAvailable,
    selectFieldInfoName, selectFieldInfoPeriod,
    selectFieldInfoPrix,
    selectFieldInfoServices,
    selectFieldInfoSurface,
    selectFieldInfoType,
    selectFieldInfoUpdatedAt
} from "../field-form-page/fieldInfoSlice";
import {OwnerPreview} from "../../components/owner-preview/OwnerPreview";
import {OwnerRelatedToField} from "../../components/owner-related-to-field/OwnerRelatedToField";
import {Options} from "../../components/shared/options/Options";
import {FieldOptions} from "../../components/shared/field-options/FieldOptions";


export const FieldDetailsPage = ()=> {
    const dispatch = useDispatch()
    const id = useSelector(selectFieldInfoId)
    const name = useSelector(selectFieldInfoName)
    const createdAt = useSelector(selectFieldInfoCreatedAt)
    const adresse = useSelector(selectFieldInfoAdresse)
    const updatedAt = useSelector(selectFieldInfoUpdatedAt)
    const type = useSelector(selectFieldInfoType)
    const surface = useSelector(selectFieldInfoSurface)
    const services = useSelector(selectFieldInfoServices)
    const description = useSelector(selectFieldInfoDescription)
    const prix = useSelector(selectFieldInfoPrix)
   // const isNotAvailable = useSelector(selectFieldInfoIsNotAvailable)
    const period = useSelector(selectFieldInfoPeriod)
console.log(id)

    let navigate = useNavigate()

        useEffect(()=>{
            dispatch(getSingleField(id))
        }
, [id])

    return (
        <>
            <div className={`${styles.container} ${styles.displayRow}`}>
                <div className={styles.closeMark} onClick={()=>navigate("/fields/list")}> <FontAwesomeIcon icon={faXmarkCircle}/></div>
                <div  className={`${styles.displayColumn}`}
                >

                    <div className={styles.detailsContainer}>
                        <UserSingleInfo title="id" content={id}/>
                        <UserSingleInfo title="name" content={name} />
                        <UserSingleInfo title="adresse" content={adresse}/>
                        <UserSingleInfo title="type" content={type}/>
                        <UserSingleInfo title="surface" content={surface}/>
                        <UserSingleInfo title="services" content={services}/>

                        <UserSingleInfo title="period" content={period}/>
                        <UserSingleInfo title="prix" content={prix}/>
                        <UserSingleInfo title="createdAt" content={ new Date(createdAt).toLocaleString()}/>
                        <UserSingleInfo title="updatedAt" content={new Date(updatedAt).toLocaleString()}/>

                        <UserSingleInfo title="description" content={description}/>
                    </div>
                </div>
                <div className={styles.options}>
                    <FieldOptions/>
                </div>


            <div>
        <OwnerRelatedToField/>
            </div>
            </div>
        </>
    )
}