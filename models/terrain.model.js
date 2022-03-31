const { INTEGER } = require("sequelize");
const {Model , DataTypes} = require("sequelize")
const sequelize = require("../database/connection") ;

class Terrain extends Model{}


Terrain.init({
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
    image :{
        type: VARBINARY(max),
        allowNull : false,
    },
    availablity : {
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
    modelName : "terrain"
})


module.exports = Terrain