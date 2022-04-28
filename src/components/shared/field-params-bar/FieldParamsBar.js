import {useNavigate} from "react-router-dom";
import {useState} from "react";
import {FieldTypeOptions, FootSurfacesOptions, TennisSurfacesOptions} from "./fieldParamsBarData";
import {useDispatch} from "react-redux";
import styles from "../params-bar/paramsBar.module.css";
import {Button} from "../button/Button";
import {changeSurface, changeType} from "../../../pages/fieldsListPage/fieldsSlice";


export const FieldParamsBar = ()=> {
    let navigator = useNavigate()
    const [fieldType,setFieldType] = useState(FieldTypeOptions[0])
    const [footSurface,setFootSurface] = useState(FootSurfacesOptions[0])
    const [tennisSurface,setTennisSurface] = useState(TennisSurfacesOptions[0])
    const dispatch = useDispatch()


    const handleTypeChange =(e)=> {
        dispatch(changeType(e.target.value))
        setFieldType(e.target.value)
    }

    const handleSurfaceChange=(e)=> {
        dispatch(changeSurface(e.target.value))
        if(fieldType==="FOOTBALL") {
            setFootSurface(e.target.value)
        }else if (fieldType==="TENNIS") {
            setTennisSurface(e.target.value)
        }
    }

    const handleAddNewClick = ()=> {

    }
    return (

        <>

            <div className={styles.global}>
                <div >
                    <select className={styles.selectRole} name="typeOption"  value={fieldType} onChange={handleTypeChange}>

                        {FieldTypeOptions.map((element,index)=> {
                            return (
                                <option value={element} key={index}>
                                    {element}
                                </option>
                            )
                        })}
                    </select>
                </div>
                {fieldType==="FOOTBALL" && (
                    <>
                    <div>
                        <div >
                            <select className={styles.selectRole} name="footballSurfaceOption"  value={footSurface} onChange={handleSurfaceChange}>

                                {FootSurfacesOptions.map((element,index)=> {
                                    return (
                                        <option value={element} key={index}>
                                            {element}
                                        </option>
                                    )
                                })}
                            </select>
                        </div>
                    </div>
                    </>
                )}

                {fieldType==="TENNIS" && (
                    <>
                        <div>
                            <div >
                                <select className={styles.selectRole} name="tennisSurfaceOption"  value={tennisSurface} onChange={handleSurfaceChange}>

                                    {TennisSurfacesOptions.map((element,index)=> {
                                        return (
                                            <option value={element} key={index}>
                                                {element}
                                            </option>
                                        )
                                    })}
                                </select>
                            </div>
                        </div>
                    </>
                )}
                <div onClick={handleAddNewClick} >
                    <Button buttonText={"ADD NEW +"} width={"150px"} backgroundColor={ "rgba(54, 198, 41, 0.66)"} height={"50px"}/>
                </div>


            </div>


        </>
    )
}