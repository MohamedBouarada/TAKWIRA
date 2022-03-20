
const StatusCodes =  require ("http-status-codes");
const clientDao = require("../dao/client.dao")
const passwordHandling = require("../services/passwordHandling")

class ClientController {

    async register (req,res) {
        const {firstName, lastName, email, password , phoneNumber} = req.body;
        const emailExists =  await clientDao.findByEmail(email);
        const phoneNumberExists = await clientDao.findByPhoneNumber(phoneNumber);
        if(emailExists.success===false || phoneNumberExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(emailExists.data) {
            return  res.status(StatusCodes.BAD_REQUEST).json("email already used")
        }
        if(phoneNumberExists.data){
            return res.status(StatusCodes.BAD_REQUEST).json("phone number already used")
        }
        const hashedPassword = await passwordHandling.encryptingPassword(password) ;
        if(hashedPassword.success === false) {
            return  res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while registering , please try again")
        }
        const clientToSave = {
            email,
            firstName,
            lastName,
            phoneNumber,
            password:hashedPassword.data
        }
        const saving = await  clientDao.add(clientToSave);
        if(saving.success===false){
            return  res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while registering , please try again")
        }
        return  res.status(StatusCodes.CREATED).json("new user created successfully")
    }

}


module.exports = new ClientController()