const terrainModel = require('../models/terrain.model');

class TerrainDao {

    async  add (terrain) {
        try {
            const terrainToSave = terrainModel.build(terrain);
            const result = await  terrainToSave.save();
            return {success: true}
        } catch (e) {
            console.log(e)
            return {success:false}
        }

    }

    async findById (id) {
        try{
            const terrain = await  terrainModel.findOne({where : {"id":id}})
            if(terrain==null) {
                return {success:true , data:null}
            }
            return {success:true , data:terrain.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }
    async findByNameAdresse (name,adresse) {
        try{
            const terrain = await  terrainModel.findOne({where : {"name":name , "adresse":adresse}})
            if(terrain==null) {
                return {success:true , data:null}
            }
            return {success:true , data:terrain.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }
    async findByIdPropietaire (id) {
        try{
            const terrains = await  terrainModel.findAll({where : {"idProprietaire":id}})
            if(terrains==null) {
                return {success:true , data:null}
            }
            return {success:true , data:terrains.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }

    async findByPrice (prix) {
        try{
            const terrains = await  terrainModel.findAll({where : {"prix":prix}})
            if(terrains==null) {
                return {success:true , data:null}
            }
            return {success:true , data:terrains.dataValues}
        }catch (e) {
            console.log(e)
            return {success:false , data:null}
        }
    }

}


module.exports = new TerrainDao() ;