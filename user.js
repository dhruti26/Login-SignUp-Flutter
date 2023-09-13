const mongoose = require('mongoose')
const bcrypt = require('bcrypt')
const schema = mongoose.Schema

const user = new schema({
    email:{
        type:String,
        required:true,
        unique: true,
    },
    password:{
        type:String,
        required:true,
    }
})

user.pre('save', async function(){
    try{
        var user = this
        const salt = await(bcrypt.genSalt(10))
        const hashpass = await bcrypt.hash(user.password,salt)

        user.password = hashpass
    }catch(err){
        throw err
    }
})

user.methods.comparePassword = async function(userPassword){
    try{
        const isMatch = await bcrypt.compare(userPassword,this.password)
        return isMatch
    }catch(err){
        throw err
    }
}

const usermodel = mongoose.model('user', user)
module.exports = usermodel