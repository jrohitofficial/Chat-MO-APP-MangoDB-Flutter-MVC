const jwt = require('jsonwebtoken');

const validateJWT = (req,res,next) => {

    // read token
    const token = req.header('x-token');
    if(!token){
        return res.status(401).json({
            ok:false,
            msj:'Petition has no token'
        });
    }

    try {
        // Try to verify token, if not go to catch
        const { uid } = jwt.verify(token,process.env.JWTKEY);
        req.uid = uid;

        next();

    } catch (error) {
        return res.status(401).json({
            ok:false,
            msj:'token invalid'
        });
    }

    
}

module.exports = {
    validateJWT
}