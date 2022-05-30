const express = require("express");
const  router = express.Router();
const reservationController = require("../controllers/reservation.controller")


router.post("/add" , reservationController.add)
module.exports = router ;