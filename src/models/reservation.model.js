const {Model , DataTypes} = require("sequelize")
const sequelize = require("../database/connection") ;
const User = require("./user.model");
const field = require("./field.model");


class Reservation extends Model {}


Reservation.init({
    id :{
        type: DataTypes.INTEGER ,
        primaryKey : true ,
        autoIncrement : true ,
    },
    userId :{
        type: DataTypes.INTEGER,
        references: {
            model: User,
            key: 'id'
        }
    },
    fieldId :{
        type: DataTypes.INTEGER,
        references: {
            model: field,
            key: 'id'
        }
    },
    startDate : {
        type : DataTypes.DATE,
    },
    endDate : {
        type :DataTypes.DATE,
    }
}, {
    sequelize,
    modelName : "reservation"
})


module.exports = Reservation;