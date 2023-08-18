
const Message = require('../models/message');

const getChat = async (req,res) => {

    const uid = req.uid;
    const mFrom = req.params.from;

    var last30;

    // If mFrom starts with "AAA" => it IS a group message
    if ( mFrom.substring(0, 3) == "AAA") {
        //console.log(mFrom.slice(3))
        
        last30 = await Message.find({to:mFrom.slice(3)})
        .sort({createdAt:'desc'})
        .limit(30);

        res.json({
            ok:true,
            msj:last30,
        })
    } else { // Not a group message (No "AAA")
        last30 = await Message.find({
            $or: [{from:uid,to:mFrom},{from:mFrom,to:uid}]
        })
        .sort({createdAt:'desc'})
        .limit(30);

        res.json({
            ok:true,
            msj:last30,
        })
    }

}

module.exports = {
    getChat
}