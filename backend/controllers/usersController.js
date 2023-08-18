const { response } = require("express");

const User = require('../models/user');


const getUsers = async (req,res=response) =>{

    const page = Number(req.query.page) || 0;

    const users = await User
        .find({_id:{ $ne: req.uid}}) //find all useres except mine, ne=notexist
        .sort('-online')// '-' show first online users
        .skip(page)
        .limit(20);

    res.json({
        ok : true,
        users
    });
};

module.exports = {
    getUsers
}