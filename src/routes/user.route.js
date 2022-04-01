const express = require("express");
const  router = express.Router();
const userController = require("../controllers/user.controller")


router.post("/add" , userController.register)
router.post("/login" , userController.login)
router.put("/updateGeneralInfos",userController.updateGeneralInfoField)


module.exports = router ;