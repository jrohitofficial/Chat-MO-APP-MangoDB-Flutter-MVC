const { userConnected, userDisconnected, saveMessage } = require('../controllers/socketController');
const { verifyJWT } = require('../helpers/jwt');
const{io} = require('../index');

// sockets messages
io.on('connection', client => {
    console.log(`Client connected!`);

    const roomName = client.handshake.headers['room'];
    const [ok, uid] = verifyJWT(client.handshake.headers['x-token']);

    console.log(`Room Name = ${roomName}`);
    console.log(`uid = ${uid}`);

    //verify auth
    if(!ok) {
        console.log((`Wrong token(${client.handshake.headers['x-token']}) => disconnecting `));
        return client.disconnect();
    } 

    // Update Data Base User online
    userConnected(uid);

    // Join a room
    // Default is the userId 
    // example: 5fc7e4c54f9c5166f69d816d
    if (roomName == "noroom") {
        client.join(uid);
        console.log(`Client ha entrat a room = ${uid}`);
    } else {
        client.join(roomName);
        console.log(`Clinet ha entrat a room = ${uid}`);
    }

    // Listen a Message
    client.on('message',async payload =>{
        
        if (payload.changeroom){ // Mesage Change Room
            
            // Leave Room
            console.log(`Client Left room = ${payload.leaveRoom}`);
            client.leave(payload.leaveRoom);
            // Join Room
            console.log(`Client entered room = ${payload.joinRoom}`);
            client.join(payload.joinRoom);
        } else {        // Chat Message
            console.log(payload);

            await saveMessage(payload); 
            io.to(payload.to).emit('message',payload);
        }
    })

    client.on('disconnect', () => {
        if (roomName == "noroom") {
            console.log(`Disconnecting UID = ${uid}`)
            userDisconnected(uid);
        }
    });
});