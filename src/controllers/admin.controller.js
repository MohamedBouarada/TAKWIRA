const userDao = require("../dao/user.dao");
const StatusCodes = require("http-status-codes");
const passwordHandling = require("../services/passwordHandling");
const UserType = require("../enums/userTypes")

class AdminController {
    async registerNewAdminOrNewOwner(req,res) {
        const {firstName, lastName, email, password , phoneNumber , repeatPassword,role} = req.body;
        if(role!==UserType.Admin && role!==UserType.Owner) {
            return res.status(StatusCodes.CONFLICT).json("error in role")
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
        const adminToSave = {
            email,
            firstName,
            lastName,
            phoneNumber,
            password:hashedPassword.data,
            role,
        }
        const saving = await  userDao.add(adminToSave);
        if(saving.success===false){
            return  res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while registering , please try again")
        }
        return  res.status(StatusCodes.CREATED).json(`new ${role} created successfully`)
    }

    async activateOwnerAccounts(req,res) {
        const id= req.params.id ;

        const exists =  await userDao.findById(id);
        if(exists.success===false ){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(!exists.data) {
            return  res.status(StatusCodes.NOT_FOUND).json("no user found ")
        }

        if(exists.data.role !== UserType.OwnerRequest) {
            return res.status(StatusCodes.CONFLICT).json("issue in user role");
        }
        const updateProcess = await userDao.updateRole(exists.data.email,UserType.Owner);
        if(updateProcess.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        return res.status(StatusCodes.OK).json("account successfully activated")

    }

}


module.exports = new AdminController()