import styles from "./button.module.css"

export const Button = ({   width, height, backgroundColor , buttonText})=> {


    return (
        <>

        <button className={styles.global} style={{backgroundColor,width,height}}>  {buttonText}</button>
        </>
    )

}