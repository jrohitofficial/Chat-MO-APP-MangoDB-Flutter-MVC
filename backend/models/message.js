const { Schema, model } = require("mongoose");

const MessageSchema = Schema({
    from: {
        type: Schema.Types.ObjectId,
        ref:'User',
        required: true
    },
    to: {
        type: Schema.Types.ObjectId,
        ref:'User',
        required: true
    },
    message: {
        type: String,
        required: true,
    },
    groupChat: {
        type: Boolean,
        required: false,
    },
    name: {
        type: String,
        required: true,
    },
},{
    timestamps:true
});

// extract what we need to show
MessageSchema.method('toJSON',function(){
    const { __v,_id, ...object} = this.toObject();
    return object;
});


module.exports = model('Message',MessageSchema);