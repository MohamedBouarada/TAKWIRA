import styles from "./button.module.css"

export const Button = ({  backgroundColor , buttonText})=> {


    return (
        <>

        <button className={styles.global} style={{backgroundColor}}>  {buttonText}</button>
        </>
    )

}