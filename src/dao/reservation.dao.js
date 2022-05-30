const reservationModel = require("../models/reservation.model")

class ReservationDao {
    async add(reservation){
        try{
            const reservationToSave = reservationModel.build(reservation);
            await reservationToSave.save()
            return {success:true}

        }catch (e) {
          console.log(e)
            return {success:false}
        }
    }
}


module.exports = new ReservationDao()