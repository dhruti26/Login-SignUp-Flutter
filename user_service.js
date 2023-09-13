const usermodel = require('./user')
const jwt = require('jsonwebtoken')

class UserService {
    static async registerUser(email,password){
        try{
            console.log(email)
            console.log(password)
            console.log('service called')
            const cre_user = new usermodel({email,password})
            return await cre_user.save()
        }catch(err){
            throw err
        }
    }
    static async checkuser(email){
        try{
            return await usermodel.findOne({email})
        }catch(err){
            throw err
        }
    }
    static async generateToken(tokenData,secretKey,jwt_expire){
        return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expire})
    }
}

module.exports = UserService