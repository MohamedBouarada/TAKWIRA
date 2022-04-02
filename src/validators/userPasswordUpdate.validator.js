const Joi = require("joi");


const schema = Joi.object({
    email : Joi.string().email({minDomainSegments:2}).required(),
    oldPassword :Joi.string().alphanum().empty('').min(8).max(20).required(),
    newPassword:Joi.string().alphanum().empty('').min(8).max(20).required(),
    repeatNewPassword : Joi.ref('newPassword')

}).with('newPassword' , 'repeatNewPassword')

const validatePasswordUpdate = async (user) => {
    try {
        await schema.validateAsync(user)

        return {"success" : true ,  "message": "user is valid"}
    }catch(error) {
        return   {"success" : false ,  "message": error.toString()}

    }
}

module.exports = validatePasswordUpdate