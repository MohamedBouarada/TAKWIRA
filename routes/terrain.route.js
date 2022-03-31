const express = require("express");
const  router = express.Router();
const terrainController = require("../controllers/terrain.controller")


router.post("/add" , terrainController.register)
router.post("/getByOwer/:id_prop" , terrainController.get)


module.exports = router ;