
const userModel = require("../models/user.model")


class UserDao {

    async  add (user) {
        try {
            const userToSave = userModel.build(user);
            const result = await  userToSave.save();
            return {success: true}
        } catch (e) {
            console.log(e)
            return {success:false}
        }

    }

    async findByEmail (email) {
        try{
            const user = await  userModel.findOne({where : {"email":email}})
            if(user==null) {
                return {success:true , data:null}
            }
            return {success:true , data:user.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }

    async findByPhoneNumber (phoneNumber) {
        try{
            const user = await  userModel.findOne({where : {"phoneNumber":phoneNumber}})
            if(user==null) {
                return {success:true , data:null}
            }
            return {success:true , data:user.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }

    async updateJwt (email , jwt) {
        const result = await userModel.update({"jwt" : jwt } , {where:{"email" :email}, limit:1})
        if ( result[0] > 0) {
            return {success:true }
        } else {
            return {success:false}
        }

    }



}


module.exports = new UserDao() ;