const userDao = require("../dao/user.dao")
const fieldDao = require("../dao/field.dao")
const {StatusCodes} = require("http-status-codes");
const timeHandling = require("../services/timeHandling")
const reservationDao = require("../dao/reservation.dao")
const moment = require("moment");

class ReservationController{

    async add(req,res){
        const {userId,fieldId,startDate} = req.body;
       // return res.json( new Date(startDate).toLocaleTimeString())
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
       // const startDate = new Date(startDate).toISOString();
       // return res.json(startDate)
        const endDate = moment(startDate).add(fieldExists.data.period)
       // return res.json( endDate.toISOString())
 //return await reservationDao.add({fieldId,userId,startDate,endDate})
       // return res.json({endDate,startDate})
        const reservation = await reservationDao.getWithFieldId(fieldId)
        if(reservation.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        let reserved = false;
        if(reservation.data.length >0){
            const reservationList = reservation.data ;
           // const date = new Date(startDate);
            //return res.json(reservationList)
           // let reserved = false;
          //  const startDate = new Date(startDate).toUTCString();
            const elt = reservationList[1]
           // return res.json({date:new Date(elt.startDate).toISOString() , date2:elt.startDate})
            reservationList.map((element)=>{
               // console.log(element.startDate)

                if(timeHandling.checkReservation(startDate,element.startDate,element.endDate)){
                    reserved = true ;
                }
            })
        }
        if(reserved) {
            return  res.status(StatusCodes.BAD_REQUEST).json("field already reserved")
        }
        //return res.json(reservation)
        //const endDate = moment(startDate).add(fieldExists.data.period)
        const startHour = new Date(startDate).toTimeString()
        const endHour = new Date(endDate.toISOString()).toTimeString()
      //  return res.json({startHour,endHour , startDate})
        const isOpened= timeHandling.checkOuvertureFermeture(startHour,fieldExists.data.ouverture,fieldExists.data.fermeture)
        const isOpenedEnd= timeHandling.checkOuvertureFermeture(endHour,fieldExists.data.ouverture,fieldExists.data.fermeture)

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

    async getFieldReservation(req,res){
        const {date,fieldId} = req.params;
        const fieldExists = await fieldDao.findById(fieldId);
        if(fieldExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(!fieldExists.data){
            return  res.status(StatusCodes.NOT_FOUND).json("no field was found with this id")
        }
        const dateFormat = new Date(date)
        const endDate = new Date(dateFormat.setDate(dateFormat.getDate()+1))
        const startDate = new Date(dateFormat.setDate(dateFormat.getDate()-1))
        const reservationList = await reservationDao.getFieldReservationInfos(fieldId,startDate,endDate)
        if(reservationList.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(!reservationList.data) {
            return res.status(StatusCodes.NOT_FOUND).json("no reservation were found")
        }
        const formattedResult =await Promise.all(reservationList.data.map(async (element)=>{
            const userExists =await  userDao.findById(element.userId)
            delete userExists.data.password
            delete userExists.data.jwt

            return {...element,user:{...userExists['data']}}
        }))
        return res.json(formattedResult)
    }

    async giveAvailableReservation (req,res){
        const {date,fieldId} = req.params;
        const fieldExists = await fieldDao.findById(fieldId);
        if(fieldExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(!fieldExists.data){
            return  res.status(StatusCodes.NOT_FOUND).json("no field was found with this id")
        }
        const dateFormat = new Date(date)
        const fixedStartDate = new Date(dateFormat.setDate(dateFormat.getDate()-1))
        const endDate = new Date(dateFormat.setDate(dateFormat.getDate()+1))
        let startDate = new Date(dateFormat.setDate(dateFormat.getDate()))
        const notAvailableAsString = fieldExists.data.isNotAvailable;
        const notAvailable = JSON.parse(notAvailableAsString)
       // return res.json({notAvailable,aaa:timeHandling.checkUnavailable(startDate.toLocaleString(), notAvailable.startDate, notAvailable.finishDate),startDate:startDate.toLocaleString()})

        let ouvertureTime = fieldExists.data.ouverture.split(":")
        startDate.setHours(ouvertureTime[0],ouvertureTime[1],ouvertureTime[2])
        let fermetureTime = fieldExists.data.fermeture.split(":")
        endDate.setHours(fermetureTime[0],fermetureTime[1],fermetureTime[2])
        //return res.json(startDate)
        const reservation = await reservationDao.getFieldReservationInfos(fieldId,fixedStartDate,endDate)
        if(reservation.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error please try again")
        }
        let time = fieldExists.data.period.split(":")
        const seconds = (+time[0]) * 60 * 60 + (+time[1]) * 60 + (+time[2]);
        if(reservation.data.length>0){
            const reservationList = reservation.data ;
           // return res.json(reservation)
            //return res.json(reservationList[0].startDate.toLocaleTimeString())
            let firstReserved = false;
            let nextStep = new Date(startDate.getTime() + seconds*1000);
            reservationList.map((element)=>{
               // console.log(timeHandling.checkUnavailable(startDate,element.isNotAvailable.startDate,element.isNotAvailable.finishDate))
               // console.log(new Date(startDate).toString())
                console.log("******",timeHandling.checkUnavailable(startDate,notAvailable.startDate,notAvailable.finishDate))
                let bool = timeHandling.checkReservation(startDate,element.startDate,element.endDate) ||timeHandling.checkReservation(nextStep,element.startDate,element.endDate) ||timeHandling.checkUnavailable(startDate,notAvailable.startDate,notAvailable.finishDate)||timeHandling.checkUnavailable(nextStep,notAvailable.startDate,notAvailable.finishDate)
                console.log(bool)
                if(bool) {
                    firstReserved = true;
                }

            })
            // const date = new Date(startDate);
            //return res.json(reservationList)
            // let reserved = false;
            //  const startDate = new Date(startDate).toUTCString();
           // const elt = reservationList[1]
            // return res.json({date:new Date(elt.startDate).toISOString() , date2:elt.startDate})

            let slices = {};
            let count = 0;
            if(!firstReserved){
                slices[count]= startDate.toLocaleTimeString();
                count++
            }

           // return res.json(reservationList)
            while (endDate >= startDate) {
                startDate = new Date(startDate.getTime() + seconds*1000);
                let nextStep = new Date(startDate.getTime() + seconds*1000);
                let reserved = false ;
                reservationList.map((element)=>{
                    // console.log(element.startDate)
                    let bool = timeHandling.checkReservation(startDate,element.startDate,element.endDate) ||timeHandling.checkReservation(nextStep,element.startDate,element.endDate) ||timeHandling.checkUnavailable(startDate,notAvailable.startDate,notAvailable.finishDate)||timeHandling.checkUnavailable(nextStep,notAvailable.startDate,notAvailable.finishDate)

                    console.log(bool)
                    if(bool){
                        reserved = true ;
                    }
                })
                if(!reserved){
                    slices[count] = startDate.toLocaleTimeString();
                    count++;
                }

            }
            return res.json(slices);

        } else {
            let slices={}
            let count = 0
            if(!timeHandling.checkUnavailable(startDate,notAvailable.startDate,notAvailable.finishDate)) {
                slices[count] = startDate.toLocaleTimeString();
                count++;
            }

            while (endDate >= startDate) {

                startDate = new Date(startDate.getTime() + seconds*1000);
                let nextStep = new Date(startDate.getTime() + seconds*1000);
                if(!timeHandling.checkUnavailable(startDate,notAvailable.startDate,notAvailable.finishDate) && !timeHandling.checkUnavailable(nextStep,notAvailable.startDate,notAvailable.finishDate)) {
                    slices[count] = startDate.toLocaleTimeString();
                    count++
                }

            }
            return res.json(slices)
        }
       // if(timeHandling.checkReservation(startDate,))



    }

}


module.exports = new ReservationController()