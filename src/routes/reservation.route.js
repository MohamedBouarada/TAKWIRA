const express = require("express");
const  router = express.Router();
const reservationController = require("../controllers/reservation.controller")


router.post("/add" , reservationController.add)
router.get("/getForField/:fieldId/:date" , reservationController.getFieldReservation)
router.get("/free/:fieldId/:date" , reservationController.giveAvailableReservation)
module.exports = router ;