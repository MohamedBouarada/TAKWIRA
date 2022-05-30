const moment =require( "moment");


class TimeHandling {
    checkOuvertureFermeture (time,ouverture,fermeture) {
        const timeUTC = moment(time).format("HH:MM:SS")
        const timeMoment = moment(timeUTC,"hh:mm:ss")
        const ouvertureMoment = moment(ouverture,"hh:mm:ss")
        const fermetureMoment = moment(fermeture,"hh:mm:ss")
        return timeMoment.isBetween(ouvertureMoment,fermetureMoment)
    }
    checkUnavailable(time,startDate,endDate) {
        const timeMoment = moment(time)
        const startMoment = moment(startDate)
        const endMoment = moment(endDate)
        return timeMoment.isBetween(startMoment,endMoment)
    }
}

module.exports = new TimeHandling()