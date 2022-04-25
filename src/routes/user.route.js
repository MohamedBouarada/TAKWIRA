const express = require("express");
const  router = express.Router();
const userController = require("../controllers/user.controller")
const jwtHandling = require("../services/jwtHandling")
const UserType = require("../enums/userTypes");


router.post("/add" , userController.register)
router.post("/login" , userController.login)
router.put("/updateGeneralInfos",jwtHandling.jwtVerify([UserType.Owner,UserType.Client,UserType.Admin]),userController.updateGeneralInfoField)
router.put("/updatePassword" ,jwtHandling.jwtVerify([UserType.Owner,UserType.Client,UserType.Admin]), userController.updatePassword)


module.exports = router ;