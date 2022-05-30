const userDao = require("../dao/user.dao")
const fieldDao = require("../dao/field.dao")
const {StatusCodes} = require("http-status-codes");
const timeHandling = require("../services/timeHandling")
const reservationDao = require("../dao/reservation.dao")
const moment = require("moment");
class ReservationController{

    async add(req,res){
        const {userId,fieldId,startDate} = req.body;
       // return res.json(moment("2022-05-31T16:26:30.000Z").isBetween(moment("2022-05-31T16:15:30.000Z"),moment("2022-05-31T17:26:30.000Z")))
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
        const endDate = moment(startDate).add(fieldExists.data.period)
       // return res.json(endDate)
        const reservation = await reservationDao.getWithFieldId(fieldId)
        if(reservation.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        let reserved = false;
        if(reservation.data.length >0){
            const reservationList = reservation.data ;
            //return res.json(reservationList)
            let reserved = false;
            const elt = reservationList[0]
            return res.json(timeHandling.checkUnavailable(startDate,elt.startDate,elt.endDate))
            reservationList.map((element)=>{
               // console.log(element.startDate)
                console.log(timeHandling.checkUnavailable(startDate,element.startDate,element.endDate)||
                    timeHandling.checkUnavailable(endDate,element.startDate,element.endDate))
                if(timeHandling.checkUnavailable(startDate,element.startDate,element.endDate)||
                timeHandling.checkUnavailable(endDate,element.startDate,element.endDate)
                ) {

                    reserved = true;
                }
            })
        }
        if(reserved) {
            return  res.status(StatusCodes.BAD_REQUEST).json("field already reserved")
        }
        //return res.json(reservation)
        //const endDate = moment(startDate).add(fieldExists.data.period)
        const isOpened= timeHandling.checkOuvertureFermeture(startDate,fieldExists.data.ouverture,fieldExists.data.fermeture)
        const isOpenedEnd= timeHandling.checkOuvertureFermeture(endDate,fieldExists.data.ouverture,fieldExists.data.fermeture)

        if(!isOpened || !isOpenedEnd) {
            return res.status(StatusCodes.BAD_REQUEST).json("sorry we are closed")
        }
        const notAvailableAsString = fieldExists.data.isNotAvailable;
        const notAvailable = JSON.parse(notAvailableAsString)
        //return res.json(notAvailable)
      if(timeHandling.checkUnavailable(startDate,notAvailable.startDate,notAvailable.finishDate)||
      timeHandling.checkUnavailable(endDate,notAvailable.startDate,notAvailable.finishDate)

      ){

            return  res.status(StatusCodes.BAD_REQUEST).json("we are not available in this date")
        }

       // return res.json({startDate,endDate})
        const saveResult = await reservationDao.add({userId,fieldId,startDate,endDate})

        if(saveResult.success){
            return res.status(StatusCodes.CREATED).json("reservation succeeded")
        }
        return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")

    }
}


module.exports = new ReservationController()