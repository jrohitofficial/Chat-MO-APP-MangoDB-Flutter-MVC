
const Groupchat = require('../models/groupchat');

const createGroup = async (req, res = response) => {

    const {groupname} = req.body 

    //console.log(req.body)

    try{

        const groupChat = new Groupchat(req.body);

        //validate if groupname already exists
        const groupnameExist = await Groupchat.findOne({groupname:groupname});
        if(groupnameExist){
            return res.status(400).json({
                ok: false,
                msg: 'Group name already exists'
            });
        } 

        await groupChat.save();

        res.json({
            ok : true,
            groupname,
            msg:'Group Sucsefully created'
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

const getGroups= async (req,res) => {

//console.log("requested groups")

    const page = Number(req.query.page) || 0;

    const rooms = await Groupchat
        .find({}) // find all
        .skip(page)
        .limit(20);

    res.json({
        ok : true,
        rooms
    });

}


module.exports = {
    getGroups,
    createGroup
};