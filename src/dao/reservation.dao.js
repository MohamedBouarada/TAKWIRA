const reservationModel = require("../models/reservation.model")
const {Op} = require("sequelize");


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
    async getWithFieldId(fieldId) {
        try{
            const reservationList = await reservationModel.findAll({
                where : {
                   fieldId,



                }
            })
            return {success:true,data:reservationList}
        }catch (e) {
console.log(e)
            return {success:false,data:null}
        }
    }
    async getFieldReservationInfos(fieldId,date,endDate){
        try{
            const reservationList = await reservationModel.findAll({
                where :{
                    fieldId,
                    startDate : {
                        [Op.gte] : date
                    } ,
                    endDate : {
                        [Op.lte] :endDate
                    }

                },


            })
            return {success:true , data:reservationList}
        }catch (e) {
console.log(e)
            return {success:false,data:null}
        }
    }
}


module.exports = new ReservationDao()