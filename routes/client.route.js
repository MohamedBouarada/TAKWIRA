const express = require("express");
const  router = express.Router();
const clientController = require("../controllers/client.controller")


router.post("/add" , clientController.register)
router.post("/login" , clientController.login)


module.exports = router ;