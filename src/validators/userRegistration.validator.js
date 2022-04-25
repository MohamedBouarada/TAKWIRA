const Joi = require('joi');
const userTypes = require("../enums/userTypes")

const schema = Joi.object({
    email : Joi.string().email({minDomainSegments:2}).required(),
    firstName : Joi.string().empty('').alphanum().required(),
    lastName : Joi.string().empty('').alphanum().required(),
    phoneNumber :Joi.string().pattern( new RegExp('^[0-9]{8}$')).length(8).required(),
    password :Joi.string().alphanum().empty('').min(8).max(20).required(),
    repeatPassword : Joi.ref('password'),
    role:Joi.string().empty('').valid(userTypes.OwnerRequest,userTypes.Client,userTypes.Admin,userTypes.Owner).required(),
}).with('password' , 'repeatPassword')


const validateUserRegistration = async (user) => {
    try {
        await schema.validateAsync(user)

        return {"success" : true ,  "message": "user is valid"}
    }catch(error) {
        return   {"success" : false ,  "message": error.toString()}

    }
}

module.exports = validateUserRegistration