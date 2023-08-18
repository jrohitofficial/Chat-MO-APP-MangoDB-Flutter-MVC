const { Schema, model } = require("mongoose");

const GroupchatSchema = Schema({
   
    groupname: {
        type: String,
        required: true,
    }
},{
    timestamps:true
});

// extract what we need to show
GroupchatSchema.method('toJSON',function(){
    const { __v,_id, ...object} = this.toObject();
    object.uid = _id;
    return object;
});


module.exports = model('Groupchat',GroupchatSchema);