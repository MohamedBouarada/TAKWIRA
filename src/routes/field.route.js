const express = require("express");
const  router = express.Router();
const fieldController = require("../controllers/field.controller")


router.post("/add" , fieldController.add)
router.get("/getByOwner/:id" , fieldController.getByOwner)
router.get("/:id" , fieldController.getById)
router.put("/:id" , fieldController.update)
router.delete("/:id" , fieldController.delete)


module.exports = router ;