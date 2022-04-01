const { INTEGER } = require("sequelize");
const {Model , DataTypes} = require("sequelize")
const sequelize = require("../database/connection") ;

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
    },
    availibility : {
        type : DataTypes.JSON,
        allowNull : true,
    },
    services : {
        type : DataTypes.JSON,
        allowNull : true,
    },
    prix : {
        type :DataTypes.REAL,
        allowNull : false,
    },
    description : {
        type : DataTypes.TEXT,
        allowNull : false ,
    } ,
    idProprietaire : {
        type : DataTypes.STRING,
        allowNull : false ,
    }
}, {
    sequelize,
    modelName : "field"
})


module.exports = field