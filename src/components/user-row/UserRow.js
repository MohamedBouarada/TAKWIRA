import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {Button} from "../shared/button/Button";
import {faEllipsis} from "@fortawesome/free-solid-svg-icons";


export const UserRow =({id,name,image,phoneNumber,email,createdAt})=> {

    return (
        <tr>

            <td> <FontAwesomeIcon icon={image}/> </td>
            <td> <span>{name}</span> </td>
            <td> <span>{   new Date(createdAt).toLocaleDateString()}</span> </td>
            <td> <span>{email}</span> </td>
            <td> <span>{phoneNumber}</span> </td>
            <td> <Button buttonText={'delete'} backgroundColor={'#DC3545'} />  </td>
            <td> <FontAwesomeIcon icon={faEllipsis}/> </td>

        </tr>
    )
}