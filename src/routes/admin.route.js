const express = require("express");
const  router = express.Router();
const adminController = require("../controllers/admin.controller")

router.put("/activateAccount/:id",adminController.activateOwnerAccounts)
router.post("/register" , adminController.registerNewAdminOrNewOwner)



module.exports = router ;