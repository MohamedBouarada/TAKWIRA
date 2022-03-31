
const StatusCodes =  require ("http-status-codes");
const userDao = require("../dao/user.dao")
const passwordHandling = require("../services/passwordHandling")
const jwtHandling = require("../services/jwtHandling")
const UserType = require("../enums/userTypes")

class UserController {

    async register (req,res) {
        const {firstName, lastName, email, password , phoneNumber , role, repeatPassword} = req.body;

        if(role !==UserType.OwnerRequest || role !==UserType.Client) {
            return res.status(StatusCodes.CONFLICT).json("error")
        }
        const emailExists =  await userDao.findByEmail(email);
        const phoneNumberExists = await userDao.findByPhoneNumber(phoneNumber);
        if(emailExists.success===false || phoneNumberExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(emailExists.data && phoneNumberExists.data) {
            return  res.status(StatusCodes.BAD_REQUEST).json("email and phone number already used")
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
        const userToSave = {
            email,
            firstName,
            lastName,
            phoneNumber,
            password:hashedPassword.data,
            role,
        }
        const saving = await  userDao.add(userToSave);
        if(saving.success===false){
            return  res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while registering , please try again")
        }
        return  res.status(StatusCodes.CREATED).json("new user created successfully")
    }

    async login( req , res) {
        const {email , password} = req.body ;
        const userExists = await userDao.findByEmail(email) ;
        if(userExists.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while logging in , please try again1")
        }
        if(!userExists.data) {
            return  res.status(StatusCodes.NOT_FOUND).json("no user found with this email , please verify your credentials")
        }
        const passwordVerification = await passwordHandling.decryptingPassword(password , userExists.data.password);
        if(passwordVerification.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while logging in , please try again2")
        }
        if(!passwordVerification.data) {
            return res.status(StatusCodes.FORBIDDEN).json("please verify your password")
        }
        const jwtProcess = await jwtHandling.jwtSign(email,userExists.data.id,userExists.data.role);
        if(jwtProcess.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while logging in , please try again3")
        }
        const tokenToSave = await userDao.updateJwt(email , jwtProcess.data)
        if(tokenToSave.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while logging in , please try again")
        }
        return res.status(StatusCodes.OK).json({token:jwtProcess.data,role:userExists.data.role})

    }


}


module.exports = new UserController()