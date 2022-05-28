const { INTEGER } = require("sequelize");
const {Model , DataTypes} = require("sequelize")
const sequelize = require("../database/connection") ;
const userModel = require("./user.model");
const fieldTypes = require("../enums/fieldTypes");
const User = require("./user.model");
class field extends Model{}


field.init({
    id :{
        type: DataTypes.INTEGER ,
        primaryKey : true ,
        autoIncrement : true ,
    },
    name: {
        type: DataTypes.STRING,
        allowNull : false
    },
    adresse : {
        type: DataTypes.STRING,
        allowNull : false
    } ,
    type : {
        type :DataTypes.STRING,
        allowNull : false ,
        validate: {
            isIn: [[fieldTypes.Football,fieldTypes.Tennis,fieldTypes.Basketball,fieldTypes.Golf]]
        }
    },
    isNotAvailable : {
        type : DataTypes.JSON ,
        allowNull : true,
        //start time and finish time
    },
    services : {
        type : DataTypes.TEXT,
        allowNull : true,
    },
    prix : {
        type :DataTypes.DOUBLE,
        allowNull : false,
    },
    period :{
        type : DataTypes.TIME,
        allowNull:false,
    },
    surface : {
        type : DataTypes.STRING,
        allowNull : true,
    },
    description : {
        type : DataTypes.TEXT,
        allowNull : false ,
    } ,
    images : {
        type : DataTypes.STRING,
        allowNull : true
    } ,
    localisation : {
        type : DataTypes.STRING,
        allowNull : false
    }

}, {
    sequelize,
    modelName : "field"
})



module.exports = field