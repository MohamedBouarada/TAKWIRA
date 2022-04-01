
require("dotenv").config() ;


config ={
    "development" : {
        "server" : {
            "port" : process.env.SERVER_PORT || 3000 ,
        },
        "database" : {
            "dialect" : process.env.DATABASE_DIALECT,
            "username" : process.env.DATABASE_USERNAME ,
            "password" : process.env.DATABASE_PASSWORD ,
            "host" : process.env.DATABASE_HOST ,
            "name" : process.env.DATABASE_NAME ,
            "port" : process.env.DATABASE_PORT ,

        }
    }
}

module.exports = config