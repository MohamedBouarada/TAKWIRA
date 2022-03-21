
const StatusCodes =  require ("http-status-codes");
const clientDao = require("../dao/client.dao")
const passwordHandling = require("../services/passwordHandling")
const jwtHandling = require("../services/jwtHandling")
const UserType = require("../enums/userTypes")

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

    async login( req , res) {
        const {email , password} = req.body ;
        const clientExists = await clientDao.findByEmail(email) ;
        if(clientExists.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while logging in , please try again1")
        }
        if(!clientExists.data) {
            return  res.status(StatusCodes.NOT_FOUND).json("no user found with this email , please verify your credentials")
        }
        const passwordVerification = await passwordHandling.decryptingPassword(password , clientExists.data.password);
        if(passwordVerification.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while logging in , please try again2")
        }
        if(!passwordVerification.data) {
            return res.status(StatusCodes.FORBIDDEN).json("please verify your password")
        }
        const jwtProcess = await jwtHandling.jwtSign(email,clientExists.data.id,UserType.Client);
        if(jwtProcess.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while logging in , please try again3")
        }
        const tokenToSave = await clientDao.updateJwt(email , jwtProcess.data)
        if(tokenToSave.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while logging in , please try again")
        }
        return res.status(StatusCodes.OK).json(jwtProcess.data)

    }

}


module.exports = new ClientController()