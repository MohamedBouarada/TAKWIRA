const StatusCodes =  require ("http-status-codes");
const terrainDao = require("../dao/terrain.dao");
const jwtHandling = require("../services/jwtHandling");
const UserType = require("../enums/userTypes");


class TerrainController {

    async add (req,res) {
        const {name , adresse , type , availibility , prix , description , id_prop}=req.body;
        const terrainExists =  await terrainDao.findByNameAdresse(name,adresse);
        //check if the sender of this req is the field owner !!
        const ownerExists = await ownerDao.findById(id_prop);
        if(terrainExists.success===false || ownerExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(terrainExists.data) {
            return  res.status(StatusCodes.BAD_REQUEST).json("this field already added")
        }
        if(ownerExists.data ===null) {
            return  res.status(StatusCodes.NOT_FOUND).json("you are not a field owen")
        }
        const terrainToSave = {
            name,
            adresse,
            type,
            availibility,
            prix,
            description,
            id_prop,
        }
        const saving = await  terrainDao.add(terrainToSave);
        if(saving.success===false){
            return  res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while adding field , please try again")
        }
        return  res.status(StatusCodes.CREATED).json("new field created successfully")
        
    }
    async getByOwner(req,res){
        const idOwner = req.body.id_prop;
        const terrains = await terrainDao.getByOwner(idOwner);
        if(terrains.success ===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error");
        }
        return res.status(StatusCodes.OK).json(terrains.data);
    }

}


module.exports = new TerrainController()