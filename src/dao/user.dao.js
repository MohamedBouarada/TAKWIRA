
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

    async findById(id){
        try{
            const user = await userModel.findOne({where:{id}})
            if(user==null) {
                return {success:true , data:null}
            }
            return {success:true , data:user.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
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
    async findByRole(role) {
        try{
            const list = await userModel.findAll({where:{"role":role}})
            return {success:true , data:list}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }

    }
    async updateRole(email,newRole) {
        const result = await userModel.update({"role" : newRole} , {where:{"email":email},limit:1})
        if ( result[0] > 0) {
            return {success:true }
        } else {
            return {success:false}
        }
    }
    async updateUserByEmail(email,updatedUser) {
        try{
            const result = await userModel.update(updatedUser,{where:{"email":email},limit:1})
            if ( result[0] > 0) {
                return {success:true }
            } else {
                return {success:false}
            }
        }catch (e) {
            console.log(e)
            return {success:false}
        }
    }



}


module.exports = new UserDao() ;