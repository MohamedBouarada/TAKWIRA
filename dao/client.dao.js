
const clientModel = require("../models/client.model")


class ClientDao {

    async  add (client) {
        try {
            const clientToSave = clientModel.build(client);
            const result = await  clientToSave.save();
            return {success: true}
        } catch (e) {
            console.log(e)
            return {success:false}
        }

    }

    async findByEmail (email) {
        try{
            const client = await  clientModel.findOne({where : {"email":email}})
            if(client==null) {
                return {success:true , data:null}
            }
            return {success:true , data:client.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }

    async findByPhoneNumber (phoneNumber) {
        try{
            const client = await  clientModel.findOne({where : {"phoneNumber":phoneNumber}})
            if(client==null) {
                return {success:true , data:null}
            }
            return {success:true , data:client.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }



}


module.exports = new ClientDao() ;