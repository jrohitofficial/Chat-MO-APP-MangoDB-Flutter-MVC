const { Schema, model } = require("mongoose");

const UserSchema = Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true,
    },
    online: {
        type: Boolean,
        default: false,
    },
    time: {
        type: String,
        default: new Date(),
    },
});

// extract only what we need to show
UserSchema.method('toJSON',function(){
    const { __v,_id, password, ...object} = this.toObject();
    object.uid = _id;
    //console.log(object)
    return object;
});


module.exports = model('User',UserSchema);