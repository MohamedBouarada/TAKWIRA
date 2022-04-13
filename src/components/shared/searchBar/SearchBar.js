
import styles from "./searchBar.module.css"


export const SearchBar =()=> {



    return (
        <>
            <div className={styles.bar}>
            <div className={styles.title}> User list</div>
                <form >
             <input name="search" className={styles.input}  placeholder="search..."/>

                </form>

                <img src="/assets/images/logo_green.png" alt="logo_takwira"/>
            </div>
        </>

    )
}