const StatusCodes =  require ("http-status-codes");
const fieldDao = require("../dao/field.dao");
const userDao = require("../dao/user.dao");

const UserType = require("../enums/userTypes");
const FieldType = require("../enums/fieldTypes")
const FootSurface = require("../enums/FieldSurfacesTypes/FootSurfaces");
const TennisSurface = require("../enums/FieldSurfacesTypes/TennisSurfaces")
const convertUtility = require("../utils/jsonString.utility")
const fs = require("fs");
const path = require("path");

class fieldController {

    async add (req,res) {
            console.log('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        const {name , adresse , type , isNotAvailable,services , prix ,period,surface, description , userId,localisation,ouverture,fermeture}=req.body;
        console.log(isNotAvailable);
        
         let photos = ""
        if(req.files) {
            const files = req.files ;

            const photoList = files.map((element) => { return {name: element.filename}});
            photos = convertUtility.convertJsonToString(photoList);
        }
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
        const ownerExists = await userDao.findById(userId);
       
        
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
        if(ownerExists.data["role"] !==UserType.Owner && ownerExists.data["role"] !==UserType.OwnerRequest) {
            return  res.status(StatusCodes.NOT_FOUND).json("not a field owner")
        }
        console.log(isNotAvailable);
        const fieldToSave = {
            name,
            adresse,
            type,
            isNotAvailable:convertUtility.convertStringToJson(convertUtility.convertJsonToString(isNotAvailable)), 
            services,
            prix,
            period,
            surface,
            description,
            userId,
            images:photos,
            localisation,
            ouverture,
            fermeture
        }
        const saving = await  fieldDao.add(fieldToSave);
        if(saving.success===false){
            return  res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error while adding field , please try again")
        }
        return  res.status(StatusCodes.CREATED).json("new field created successfully")
        
    }
    // async getByOwner(req,res){
    //     const id = req.params.id;
    //     const fields = await fieldDao.findByIdPropietaire(id);
    //     console.log(JSON.stringify(fields.data[0]['isNotAvailable']['startDate']));
    //     console.log(fields.dataValues)
    //     if(fields.success ===false){
    //         return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error");
    //     }
    //    // const photoString = convertUtility.convertStringToJson(fields.dataValues.images)
    //    // return res.status(StatusCodes.OK).json({...fields.data , images : photoString});
    //     return res.status(StatusCodes.OK).json(fields.data);
    // }
    async getByOwner(req,res){
        const id = req.infos.authId;
        const fields = await fieldDao.findByIdPropietaire(id);
        console.log(JSON.stringify(fields.data[0]['isNotAvailable']['startDate']));
        console.log(fields.dataValues)
        if(fields.success ===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error");
        }
        //return res.json(fields.data)
        const formattedList = fields.data.map((element)=>{
            const avString = convertUtility.convertStringToJson(element.dataValues.isNotAvailable) ;
            const notAvailable={'startDate':avString.startDate,'finishDate':avString.finishDate}
            const str=convertUtility.convertJsonToString(notAvailable);
            return {...element.dataValues,isNotAvailable:str}
        })
        //return res.json(fields.data)
      // const photoString = convertUtility.convertStringToJson(fields.dataValues.images)
       // fields.data
       // return res.status(StatusCodes.OK).json({...fields.data , images : photoString});
        return res.status(StatusCodes.OK).json(formattedList);
    }
    async getById(req,res){
        const id = req.params.id;
        const field = await fieldDao.findById(id);
        if(field.success ===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error");
        }
        if(!field.data){
            return res.status(StatusCodes.NOT_FOUND).json("no field found with tis id")
        }
        const photoString = convertUtility.convertStringToJson(field.data.images)
        return res.status(StatusCodes.OK).json({...field.data , images : photoString});
    }
    async update (req,res) {
        const {name ,ouverture,fermeture, adresse , type , isNotAvailable,services , prix ,period,surface, description , userId}=req.body;
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
        const ownerExists = await userDao.findById(userId);
       
        
        if(fieldExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error1")
        }
        if(ownerExists.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error2")
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
            userId,
            ouverture,
            fermeture
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

    async searchForFields(req,res) {
        const sort = req.query.sort || "ASC";
        const orderBy = req.query.order || "createdAt";
        const page= req.query.page ? parseInt(req.query.page.toString(),10) :  1 ;
        const perPage = req.query.perPage? parseInt(req.query.perPage.toString(),10) :  5 ;
        const offset = (page - 1) * perPage;
        const searchValue = req.query.searchValue ? req.query.searchValue : ""
        const type = req.query.type ? req.query.type : "*"
        const surface = req.query.surface ? req.query.surface : "*"
        const result = await fieldDao.getAllFieldsPaginatedAndSorted(orderBy,sort,perPage,offset,searchValue,type,surface);
        if(result.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error occurred")
        }
        const pagesNumber= Math.ceil(result.data.count/perPage)
        return res.status(StatusCodes.OK).json({result, pagesNumber})
    }
    async deleteImage(req,res) {
        const {imageName,fieldId} = req.params ;
        fs.unlink(path.resolve(path.join(__dirname,"..","..","uploads",imageName)),(err)=>{
            if (err){
                return res.status(StatusCodes.NOT_FOUND).json("file not found")
            }
        })
        const field = await  fieldDao.findById(fieldId);
        if(field.success===false) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(!field.data) {
            return res.status(StatusCodes.NOT_FOUND).json("field not found")
        }
        const photoList = convertUtility.convertStringToJson(field.data.images)
        const filteredPhotos = photoList.filter((element)=> element.name !== imageName)
         field.data.images = convertUtility.convertJsonToString(filteredPhotos);
        const updateResult =await fieldDao.addImage(fieldId , field.data.images);
        if(updateResult.success){
            return  res.status(StatusCodes.OK).json("image deleted successfully")
        }
        return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error in deleting image")

    }

    async addImage(req,res) {
        console.log(req)
        const {fieldId} = req.params ;
        const field = await fieldDao.findById(fieldId) ;
        if(field.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error")
        }
        if(! field.data) {
            return res.status(StatusCodes.NOT_FOUND).json("no field found")
        }
        const data = field.data ;
        const imageFromDB = convertUtility.convertStringToJson(data.images)
        const imageList = imageFromDB? imageFromDB : [];
        if( imageList.length >=5) {
            return res.status(StatusCodes.BAD_REQUEST).json("max image  number reached")
        }
        const newList = imageList.concat([{name: req.file.filename}]);
        data.images = convertUtility.convertJsonToString(newList);
        const updateResult = await fieldDao.addImage(fieldId,data.images);
        if(updateResult.success===false){
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json("error in updating")
        }
        return res.status(StatusCodes.OK).json("image added successfully")
    }

}


module.exports = new fieldController()