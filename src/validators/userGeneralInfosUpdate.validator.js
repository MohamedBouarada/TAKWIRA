const Joi = require('joi');


const schema = Joi.object({
    email : Joi.string().email({minDomainSegments:2}).required(),
    firstName : Joi.string().empty('').alphanum(),
    lastName : Joi.string().empty('').alphanum(),
    phoneNumber :Joi.string().pattern( new RegExp('^[0-9]{8}$')).length(8),

})

const validateUserUpdate = async (user) => {
    try {
        await schema.validateAsync(user)

        return {"success" : true ,  "message": "user is valid"}
    }catch(error) {
        return   {"success" : false ,  "message": error.toString()}

    }
}

module.exports = validateUserUpdate