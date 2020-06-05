var express = require('express');
var bodyParser = require('body-parser');
const config = require('./DB/config');
const mongoose = require('mongoose');
// const morgan = require('morgan');
const app = express();
const port = 3000;
const dbUrl = config.url;
const route = require('./routes');


app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
// app.use(morgan('short')) //real time activity update in console
app.use(route);

mongoose.Promise = global.Promise;

//Connecting to database

mongoose.connect(dbUrl, {
    useFindAndModify : false,
    useUnifiedTopology: true,
    useNewUrlParser: true
}).then(() => {
    console.log('Successfully Connected');
}).catch(err => {
    console.log('could not connect');
    process.exit();
})

// define a simple route

app.listen(port, ()=>{
    console.log(`Server is listen on port ${port}`)
});
