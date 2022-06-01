const express = require("express");
const  router = express.Router();
const fieldController = require("../controllers/field.controller")
const upload = require("../services/uploadService")
const jwtHandling = require("../services/jwtHandling");
const UserType = require("../enums/userTypes");
const ownerAndOwnerRequestGuard = require("../guards/ownerAndRequestOwner.guard")

router.post("/add" ,[upload.array("files",5),jwtHandling.jwtVerify([UserType.Owner,UserType.OwnerRequest]),ownerAndOwnerRequestGuard], fieldController.add)
router.get("/getByOwner" ,[jwtHandling.jwtVerify([UserType.Owner,UserType.OwnerRequest]),ownerAndOwnerRequestGuard], fieldController.getByOwner)
router.get("/:id" , fieldController.getById)
router.put("/:id" , fieldController.update)
router.delete("/:id" , fieldController.delete)
router.get("/search/all" , fieldController.searchForFields)
router.delete("/image/delete/:fieldId/:imageName" , fieldController.deleteImage)
router.post("/image/add/:fieldId" ,upload.single("files"), fieldController.addImage)

module.exports = router ;