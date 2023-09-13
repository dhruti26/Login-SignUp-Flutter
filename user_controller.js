const UserService = require('./user_service')
const userService = require('./user_service')


exports.register = async(req,res,next) => {
    try{
        console.log(req.body)
        console.log('controller called')
        const {email,password} = req.body
        const successRes = UserService.registerUser(email,password)
        res.json({status:true,success:"User Registration Successful"})
    }catch(err){

    }
}

exports.login = async(req,res,next) => {
    try{
        console.log(req.body)
        console.log('login controller called')
        const {email,password} = req.body

        const user = await userService.checkuser(email)

        if(!user){
            throw new Error('User does not exist')
        }
        const isMatch = await user.comparePassword(password)

        if(isMatch === false){
            throw new Error('Invalid Password')
        }

        let tokenData = {_id:user._id, email:user.email}

        const token = await UserService.generateToken(tokenData,"secretKey",'1h')
        res.status(200).json({status:true,token:token})

    }catch(err){

    }
}