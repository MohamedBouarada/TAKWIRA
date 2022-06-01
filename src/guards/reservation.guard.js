const UserType = require("../enums/userTypes");
const {StatusCodes} = require("http-status-codes");
const userDao = require("../dao/user.dao");


async function reservationGuard(req,res,next) {
    try{
        const {authEmail,authId,authRole} = req.infos;
        if(authRole!==UserType.Client) {
            return res.status(StatusCodes.FORBIDDEN).json("unathorized action1")
        }
        const userExists = await userDao.findById(authId);
        if(userExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(!userExists.data){
            return res.status(StatusCodes.NOT_FOUND).json("no user found")
        }
        if(userExists.data.role !==UserType.Client) {
            return res.status(StatusCodes.FORBIDDEN).json("unathorized action2")
        }
        if(userExists.data.email!==authEmail) {
            return res.status(StatusCodes.FORBIDDEN).json("unathorized action3")
        }
        return next();

    }catch (e) {
        console.log(e)
        return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("errorrr")
    }
}


module.exports = reservationGuard