const Joi = require("joi");
const schema = Joi.object({
    email : Joi.string().email({minDomainSegments:2}).required(),
    password :Joi.string().alphanum().empty('').min(8).max(20).required(),

})


const validateUserLogin = async (user)=> {
    try {
        await schema.validateAsync(user)

        return {"success" : true ,  "message": "user is valid"}
    }catch(error) {
        return   {"success" : false ,  "message": error.toString()}

    }
}

module.exports = validateUserLogin