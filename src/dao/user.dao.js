
const userModel = require("../models/user.model")
const sequelize = require("../database/connection") ;
const {Op} = require("sequelize");


class UserDao {

    async  add (user) {
        try {
            const userToSave = userModel.build(user);
            const result = await  userToSave.save();
            return {success: true ,data:result.dataValues.id}
        } catch (e) {
            console.log(e)
            return {success:false , data:null}
        }

    }

    async findById(id){
        try{
            const user = await userModel.findOne({where:{id},
                attributes: {
                    exclude: ["password"]
                }})
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
            const user = await  userModel.findOne({
                where : {"email":email},

            })
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
    async updateUserGeneralInfos(id,updatedUser) {
        try{
            const user = await userModel.findOne({where:{id},
                attributes: {
                    exclude: ["password"]
                }})
            if(!user) {
                return {success:false , data:null}
            }
            user.set(updatedUser);
           const result= await user.save() ;
           return {success:true , data : result.dataValues.id}
        }catch (e) {
            console.log(e)
            return {success:false , data :e.errors[0].message}
        }
    }

    async getAllUsers (orderBy,sort , limit , offset) {
        try{
            const usersList = await  userModel.findAndCountAll({
                order : [
                    [orderBy,sort]
                ],
                attributes : {
                    exclude : ["password"] ,

                } ,
                limit : limit ,
                offset : offset,

            } )
            return {success:true , data:usersList}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }

    }

    async getAllUsersFiltered (orderBy,sort , limit , offset,searchValue,role="*"){
        try{
            const usersList =  await userModel.findAndCountAll({
                where :{
                    [Op.and] : [
                        {
                            [Op.or] :[
                                {firstName: {[Op.like] : `%${searchValue}%`}},
                                {lastName: {[Op.like] : `%${searchValue}%`}},
                                {email: {[Op.like] : `%${searchValue}%`}},
                                {phoneNumber: {[Op.like] : `%${searchValue}%`}},
                            ]
                        },
                       role==="*"? {

                        }: {role}
                    ]


                },
                order : [
                    [orderBy,sort]
                ],
                attributes : {
                    exclude : ["password"] ,

                } ,
                limit : limit ,
                offset : offset,
            })
            return {success:true , data:usersList}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }



}


module.exports = new UserDao() ;