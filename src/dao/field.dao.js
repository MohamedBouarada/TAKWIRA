const fieldModel = require('../models/field.model');

class fieldDao {

    async  add (field) {
        try {
            const fieldToSave = fieldModel.build(field);
            const result = await  fieldToSave.save();
            return {success: true}
        } catch (e) {
            console.log(e)
            return {success:false}
        }

    }
    async  update (field,id) {
        try {
            
            const fieldToSave = fieldModel.update(field,{where : {"id":id}});
            return {success: true}
        } catch (e) {
            console.log(e)
            return {success:false}
        }

    }

   

    async findById (id) {
        try{
            const field = await  fieldModel.findOne({where : {"id":id}})
            if(field==null) {
                return {success:true , data:null}
            }
            return {success:true , data:field.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }
    async findByNameAdresse (name,adresse) {
        try{
            const field = await  fieldModel.findOne({where : {"name":name , "adresse":adresse}})
            if(field==null) {
                return {success:true , data:null}
            }
            return {success:true , data:field.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }
    async findByIdPropietaire (id) {
        try{
            console.log(id)
            const fields = await  fieldModel.findAll({where : {"idProprietaire":id}})
            
            if(fields==null) {
                return {success:true , data:null}
            }
            return {success:true , data:fields}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }

    async findByPrice (prix) {
        try{
            const fields = await  fieldModel.findAll({where : {"prix":prix}})
            if(fields==null) {
                return {success:true , data:null}
            }
            return {success:true , data:fields.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }
    async findByAddress (adresse) {
        try{
            const fields = await  fieldModel.findAll({where : {"adresse":adresse}})
            if(fields==null) {
                return {success:true , data:null}
            }
            return {success:true , data:fields.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }
    async delete (id) {
        try{
            const response = await  fieldModel.destroy({where : {"id":id}})
            console.log("field deleted successfully");
            return {success: true}
        }catch (e) {
            console.log(e)
            return {success:false}
        }
    }
}


module.exports = new fieldDao() ;