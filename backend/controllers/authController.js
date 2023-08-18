const { response, json } = require("express");
const bcrypt = require('bcryptjs');
const User = require('../models/user');
const { generateToken } = require("../helpers/jwt");

const createUser = async (req, res = response) => {

    const{ email,password } = req.body 
    // const email = req.body.email // is same

    try{

        const user = new User(req.body);

        // validate if email already exists
        const emailExist = await User.findOne({email:email});
        if(emailExist){
            return res.status(400).json({
                ok: false,
                msg: 'Email already exists'
            });
        }

        // encrypt password
        const salt = bcrypt.genSaltSync();
        user.password = bcrypt.hashSync( password , salt);

        // generate JWT (json web token)
        const token = await generateToken(user.id);
        
        await user.save();

        res.json({
            ok : true,
            user,
            token,
            msg:'User Sucsefully created'
            //message:req.body
        });

    }catch(error){
        console.log(error);
        res.status(500).json({
            ok:false,
            msg:'Unknown Error, Contact Admin'
        });
    }

};

const loginUser = async (req, res = response) => {

    const{ email,password } = req.body 
    //const email = req.body.email // is same

    try{
        //valid user
        const userDB = await User.findOne({email});
        if(!userDB){
            return res.status(404).json({
                ok:false,
                msj: 'user NOT found'
            });
        }

        //valid password
        const validPw = bcrypt.compareSync(password,userDB.password);
        if(!validPw){
            return res.status(400).json({
                ok:false,
                msj: 'Invalid password'
            });
        }

        // generate JWT (json web token)
        const token = await generateToken(userDB.id);

        res.json({
            ok : true,
            user:userDB,
            token
            //message:req.body
        });

    }catch(error){
        console.log(error);
        res.status(500).json({
            ok:false,
            msg:'Unknown Error, contact administrator'
        });
    }

};

const renewToken = async(req,res=response) => {

    try{

        const uid  = req.uid 

        //create new JWT (json web token)
        const token = await generateToken(uid);

        //valid user
        const user = await User.findById(uid);
        if(!user){
            return res.status(404).json({
                ok:false,
                msj: 'User NOT found'
            });
        }

        res.json({
            ok : true,
            user,
            token
        });

    }catch(error){
        console.log(error);
        res.status(500).json({
            ok:false,
            msg:'Unknown error, contact admin'
        });
    }
}


module.exports = {
    createUser,
    loginUser,
    renewToken
}