
const {Model , DataTypes} = require("sequelize")
const sequelize = require("../database/connection") ;
const userTypes = require("../enums/userTypes")

class User extends Model{}


User.init({
    id :{
        type: DataTypes.INTEGER ,
        primaryKey : true ,
        autoIncrement : true ,
    },
    username: {
        type: DataTypes.STRING,
        allowNull : false
    },
  
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
    } ,
    role : {
        type : DataTypes.STRING ,
        allowNull : false ,
        validate: {
            isIn: [[userTypes.Client,userTypes.Owner,userTypes.OwnerRequest]]
        }
    },

}, {
    sequelize,
    modelName : "user"
})


module.exports = User
