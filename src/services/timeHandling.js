const moment =require( "moment");


class TimeHandling {
    checkOuvertureFermeture (time,ouverture,fermeture) {

        const timeMoment = moment(time,"hh:mm:ss")
        const ouvertureMoment = moment(ouverture,"hh:mm:ss")
        const fermetureMoment = moment(fermeture,"hh:mm:ss")
       // console.log("****",timeMoment,ouvertureMoment,fermetureMoment)
    if(timeMoment.isSame(ouvertureMoment)){
        return true ;
    }
        return timeMoment.isBetween(ouvertureMoment,fermetureMoment)
    }
    checkUnavailable(time,startDate,endDate) {
        const timeMoment = moment(time)
        const startMoment = moment(startDate)
        const endMoment = moment(endDate)
        //console.log(timeMoment,startMoment,endMoment)
        return timeMoment.isBetween(startMoment,endMoment)
    }
    checkReservation(currentTime , startDate,endDate) {
        const currentTimeMoment = moment(currentTime);
        const startMoment = moment(startDate);
        const endMoment = moment(endDate);
      //  console.log(currentTimeMoment,startMoment,endMoment)
        if(currentTimeMoment.isSame(startMoment)) {
            return true
        }
        if(currentTimeMoment.isSame(endMoment)) {
            return false
        }
        if(currentTimeMoment.isBetween(startMoment,endMoment)){
            return true
        }
        return false
    }
}

module.exports = new TimeHandling()