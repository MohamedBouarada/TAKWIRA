const { Sequelize } = require('sequelize');
const {development} = require("../config/config")
const {database} = development ;


const sequelize = new Sequelize(
    database.name ,
    database.username ,
    database.password ,
    {
        host :database.host,
        port :database.port ,
        dialect :database.dialect ,
    }
);

(async ()=> {
    try{
        await sequelize.sync({alter:true})
    }catch (e) {
        console.log(e)
    }

})();

module.exports = sequelize ;