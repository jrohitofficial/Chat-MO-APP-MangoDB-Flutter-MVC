const jwt = require('jsonwebtoken');

const generateToken = (uid) => {

    return new Promise((resolve,reject)=>{
        //jwt has three parts
        //1.- header
        //2.- payload
        const payload = { uid };

        //3.- a secret
        jwt.sign(payload, process.env.JWTKEY,{
            expiresIn:'12h',
        }, (error, token) => {
            if(error){
                //Could Not Create Token
                reject('Could not connect to jwt');
            }else{
                // Token Sucsefully created!!
                resolve(token);
            }
        })
    });
};

const verifyJWT = (token = '') =>{
    try {
        // Try to verify the Token, if not go to Catch
        const { uid } = jwt.verify(token,process.env.JWTKEY);
        //console.log("token = " + token + " this");
        return [true,uid];
    } catch (error) {
        //console.log("token = " + token + " this");
        return [false,null];
    }
};

module.exports = {
    generateToken,
    verifyJWT
}