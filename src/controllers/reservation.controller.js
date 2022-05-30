const userDao = require("../dao/user.dao")
const fieldDao = require("../dao/field.dao")
const {StatusCodes} = require("http-status-codes");
const moment = require("moment")
const timeHandling = require("../services/timeHandling")

class ReservationController{

    async add(req,res){
        const {userId,fieldId,startDate} = req.body;
        const userExists = await userDao.findById(userId);
        if(userExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error plz try again")
        }
        if(!userExists.data){
            return res.status(StatusCodes.NOT_FOUND).json("no user found")
        }
        const fieldExists = await fieldDao.findById(fieldId)
        if(fieldExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error plzzz try again")
        }
        if(!fieldExists.data){
            return res.status(StatusCodes.NOT_FOUND).json("no field found")
        }

        const isOpened= timeHandling.checkOuvertureFermeture(startDate,fieldExists.data.ouverture,fieldExists.data.fermeture)

        if(!isOpened) {
            return res.status(StatusCodes.BAD_REQUEST).json("sorry we are closed")
        }
        const notAvailableAsString = fieldExists.data.isNotAvailable;
        const notAvailable = JSON.parse(notAvailableAsString)
        const time = moment("Mon May 31 2022 22:11:29 GMT+0100 (UTC+01:00)")
        const start = moment("Mon May 30 2022 20:11:29 GMT+0100 (UTC+01:00)")
        const end = moment("Mon May 30 2022 23:11:29 GMT+0100 (UTC+01:00)")
        if(time.isBetween(start,end))
            return res.json("bbbbbbbbbb")
        return res.json(isOpened)
        if( isClosed)
            return res.json("aaaaaaaa")
        console.log(notAvailable)
        return res.json(notAvailable)

    }
}


module.exports = new ReservationController()