const express = require("express");
const  router = express.Router();
const adminController = require("../controllers/admin.controller")

router.put("/activateAccount/:id",adminController.activateOwnerAccounts)
router.post("/register" , adminController.registerNewAdminOrNewOwner)
router.get("/users/all" , adminController.getAllUsers)
router.get("/users/filtered" , adminController.searchForUsers)
router.get("/users/find/:id" , adminController.getUserById)



module.exports = router ;