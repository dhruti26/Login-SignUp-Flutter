const express = require('express')
const mongoose = require('mongoose')
const usermodel = require('./user')
const dotenv = require('dotenv')
const body_parser = require('body-parser')
const userRoute = require('./user_route')
const cors = require("cors")


dotenv.config()

const app = express()
app.use(body_parser.json())
app.use(cors())
app.use('/', userRoute)

app.get('/', (req,res) => {
    res.send('hello world')
})

mongoose.connect(`mongodb://localhost:27017/user1login`
).then(() => app.listen(3000, () => console.log('connected')))
.catch(e => console.log(e))