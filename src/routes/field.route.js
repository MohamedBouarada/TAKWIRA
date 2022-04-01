const express = require("express");
const  router = express.Router();
const fieldController = require("../controllers/field.controller")


router.post("/add" , fieldController.add)
router.post("/getByOwer/:id_prop" , fieldController.getByOwner)


module.exports = router ;