
const {Model , DataTypes} = require("sequelize")
const sequelize = require("../database/connection") ;

class Client extends Model{}


Client.init({
    id :{
        type: DataTypes.INTEGER ,
        primaryKey : true ,
        autoIncrement : true ,
    },
    firstName: {
        type: DataTypes.STRING,
        allowNull : false
    },
    lastName : {
        type: DataTypes.STRING,
        allowNull : false
    } ,
    email : {
        type :DataTypes.STRING,
        allowNull : false ,
        unique: "email" ,
        validate : {
            isEmail : true ,

        }
    },
    phoneNumber : {
        type :DataTypes.STRING,
        allowNull : false,
        unique: "phoneNumber",

    },
    password : {
        type : DataTypes.STRING,
        allowNull : false ,
    } ,
    jwt :{
        type :DataTypes.STRING ,
        allowNull :true
    }
}, {
    sequelize,
    modelName : "client"
})


module.exports = Client
