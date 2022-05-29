const express = require("express");
const  router = express.Router();
const fieldController = require("../controllers/field.controller")
const upload = require("../services/uploadService")

router.post("/add" ,upload.array("files",5), fieldController.add)
router.get("/getByOwner/:id" , fieldController.getByOwner)
router.get("/:id" , fieldController.getById)
router.put("/:id" , fieldController.update)
router.delete("/:id" , fieldController.delete)
router.get("/search/all" , fieldController.searchForFields)
router.delete("/image/delete/:fieldId/:imageName" , fieldController.deleteImage)
router.post("/image/add/:fieldId" ,upload.single("files"), fieldController.addImage)

module.exports = router ;