const express = require('express');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

// DB Settings
require('./database/config').dbConnection();

// Express App
const app = express();

// Json and Cors Middlewares
app.use(cors());
app.use(express.json());



// path public
const public = path.resolve(__dirname,'public');
app.use(express.static(public));

// Routes
app.use('/api/login', require('./routes/authRoute'));
app.use('/api/users', require('./routes/usersRoute'));
app.use('/api/messages', require('./routes/messagesRoute'));
app.use('/api/groups', require('./routes/groupRoute'));

/*
// For testing with heroku server
app.route("/check").get((req,res) =>{
 return res.json("Your App is Working");
})
*/

//Node server (socket)
const server = require('http').createServer(app);

// Listen to Server (Socket)
server.listen(process.env.PORT,(err)=>{
    if(err) throw new Error(err);
    console.log('Server running on Port: ',process.env.PORT);
});

// Connect socket (with cors, for web app)
module.exports.io = require('socket.io')(server, {
    cors: {
      origin: '*',
    }
  }
);

require('./sockets/socket');