const express = require("express")
const app = express() ;

const {development} = require("./config/config")
const sequelize = require("./database/connection");
const {server} = development ;
const clientRouter = require("./routes/client.route")






app.use(express.json());
app.use(express.urlencoded({extended:true}));
app.use("/client" , clientRouter)




app.listen(server.port , ()=> {
    sequelize.authenticate()
        .then(()=>console.log("connected to db  successfully"))
        .catch(()=>console.log("problem in db"))
    console.log("server running on port  "+ server.port )
} ) ;