const StatusCodes =  require ("http-status-codes");
const fieldDao = require("../dao/field.dao");
const userDao = require("../dao/user.dao");

const UserType = require("../enums/userTypes");
const FieldType = require("../enums/fieldTypes")
const FootSurface = require("../enums/FieldSurfacesTypes/FootSurfaces");
const TennisSurface = require("../enums/FieldSurfacesTypes/TennisSurfaces")
class fieldController {

    async add (req,res) {
        const {name , adresse , type , isNotAvailable,services , prix ,period,surface, description , idProprietaire}=req.body;
        
        if(type!==FieldType.Tennis && type!==FieldType.Football && type!==FieldType.Basketball && type!==FieldType.Golf) {
            return res.status(StatusCodes.CONFLICT).json("error in type")
        }
        if(type===FieldType.Football && surface && surface!==FootSurface.Natural && surface!==FootSurface.Artificial && surface!==FootSurface.Hybrid) {
            return res.status(StatusCodes.CONFLICT).json("error in field type")
        }
        if(type===FieldType.Tennis && surface && surface!==TennisSurface.Green_set && surface!==TennisSurface.Hybride && surface!==TennisSurface.Resin && surface!==TennisSurface.Terre_battue) {
            return res.status(StatusCodes.CONFLICT).json("error in surface type")
        }
        const fieldExists =  await fieldDao.findByNameAdresse(name,adresse);
        //check if the sender of this req is the field owner !!
        const ownerExists = await userDao.findById(idProprietaire);
       
        
        if(fieldExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(ownerExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(ownerExists.data===null) {
            return  res.status(StatusCodes.BAD_REQUEST).json("cannot identify user")
        }
        if(fieldExists.data) {
            return  res.status(StatusCodes.BAD_REQUEST).json("this field already added")
        }
        if(ownerExists.data["role"] !==UserType.Owner) {
            return  res.status(StatusCodes.NOT_FOUND).json("not a field owner")
        }
        const fieldToSave = {
            name,
            adresse,
            type,
            isNotAvailable,
            services,
            prix,
            period,
            surface,
            description,
            idProprietaire,
        }
        const saving = await  fieldDao.add(fieldToSave);
        if(saving.success===false){
            return  res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while adding field , please try again")
        }
        return  res.status(StatusCodes.CREATED).json("new field created successfully")
        
    }
    async getByOwner(req,res){
        const id = req.params.id;
        const fields = await fieldDao.findByIdPropietaire(id);
        console.log(JSON.stringify(fields.data[0]['isNotAvailable']['startDate']));
        console.log(fields.dataValues)
        if(fields.success ===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error");
        }
        return res.status(StatusCodes.OK).json(fields.data);
    }
    async getById(req,res){
        const id = req.params.id;
        const field = await fieldDao.findById(id);
        if(field.success ===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error");
        }
        return res.status(StatusCodes.OK).json(field.data);
    }
    async update (req,res) {
        const {name , adresse , type , isNotAvailable,services , prix ,period,surface, description , idProprietaire}=req.body;
        const id = req.params.id;

        if(type!==FieldType.Tennis && type!==FieldType.Football && type!==FieldType.Basketball && type!==FieldType.Golf) {
            return res.status(StatusCodes.CONFLICT).json("error in type")
        }
        if(type===FieldType.Football && surface && surface!==FootSurface.Natural && surface!==FootSurface.Artificial && surface!==FootSurface.Hybrid) {
            return res.status(StatusCodes.CONFLICT).json("error in field type")
        }
        if(type===FieldType.Tennis && surface && surface!==TennisSurface.Green_set && surface!==TennisSurface.Hybride && surface!==TennisSurface.Resin && surface!==TennisSurface.Terre_battue) {
            return res.status(StatusCodes.CONFLICT).json("error in surface type")
        }
        const fieldExists =  await fieldDao.findById(id);
        //check if the sender of this req is the field owner !!
        const ownerExists = await userDao.findById(idProprietaire);
       
        
        if(fieldExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(ownerExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(ownerExists.data===null) {
            return  res.status(StatusCodes.BAD_REQUEST).json("cannot identify user")
        }
        if(fieldExists.data===null) {
            return  res.status(StatusCodes.BAD_REQUEST).json("field not found")
        }
        if(ownerExists.data["role"] !==UserType.Owner) {
            return  res.status(StatusCodes.NOT_FOUND).json("not a field owner")
        }
        const fieldToUpdate = {
            name,
            adresse,
            type,
            isNotAvailable,
            services,
            prix,
            period,
            surface,
            description,
            idProprietaire,
        }
        const saving = await  fieldDao.update(fieldToUpdate,id);
        if(saving.success===false){
            return  res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while adding field , please try again")
        }
        return  res.status(StatusCodes.CREATED).json(" field updated successfully")
        
        
    }
    async delete(req,res){
        const id = req.params.id;
        const fieldExists = await fieldDao.findById(id);
        if (fieldExists.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error");
        } else {
            if (fieldExists.data===null) {
                return res.status(StatusCodes.BAD_REQUEST).json("field not found");              
            } else {
                
            }
        const response = await fieldDao.delete(id);
        
        if(response.success ===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error2");
        }
        return res.status(StatusCodes.OK).json("field deleted successfully");    
        }
        
    }
}


module.exports = new fieldController()