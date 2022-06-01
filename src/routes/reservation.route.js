const express = require("express");
const  router = express.Router();
const reservationController = require("../controllers/reservation.controller")
const jwtHandling = require("../services/jwtHandling");
const UserType = require("../enums/userTypes");
const reservationGuard = require("../guards/reservation.guard")


router.post("/add" ,[jwtHandling.jwtVerify([UserType.Client]),reservationGuard], reservationController.add)
router.get("/getForField/:fieldId/:date" , reservationController.getFieldReservation)
router.get("/free/:fieldId/:date" , reservationController.giveAvailableReservation)
module.exports = router ;