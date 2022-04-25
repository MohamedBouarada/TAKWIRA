const express = require("express")
const app = express() ;

const {development} = require("./config/config")
const sequelize = require("./database/connection");
const {server} = development ;
const userRouter = require("./routes/user.route");
const adminRouter = require("./routes/admin.route");

const cors = require('cors')

const fieldRouter = require("./routes/field.route");




app.use(express.json());
app.use(express.urlencoded({extended:true}));
app.use(cors())
app.use("/user" , userRouter);
app.use("/admin" , adminRouter);
app.use("/field", fieldRouter);



app.listen(server.port , ()=> {
    sequelize.authenticate()
        .then(()=>console.log("connected to db  successfully"))
        .catch(()=>console.log("problem in db"))
    console.log("server running on port  "+ server.port )
} ) ;