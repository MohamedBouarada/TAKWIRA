const StatusCodes =  require ("http-status-codes");
const fieldDao = require("../dao/field.dao");
const userDao = require("../dao/user.dao");

const UserType = require("../enums/userTypes");
const FieldType = require("../enums/fieldTypes")

class fieldController {

    async add (req,res) {
        const {name , adresse , type , availibility,services , prix , description , idProprietaire}=req.body;

        if(type!==FieldType.Tennis && type!==FieldType.Football && type!==FieldType.Basketball && type!==FieldType.Golf) {
            return res.status(StatusCodes.CONFLICT).json("error in type")
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
            availibility,
            services,
            prix,
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
        const idOwner = req.params.id_prop;
        const fields = await fieldDao.getByOwner(idOwner);
        if(fields.success ===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error");
        }
        return res.status(StatusCodes.OK).json(fields.data);
    }

}


module.exports = new fieldController()