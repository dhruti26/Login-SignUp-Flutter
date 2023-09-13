const route = require('express').Router()
const userController = require('./user_controller')
console.log('route called')
route.post('/registration', userController.register)
route.post('/login', userController.login)


module.exports = route