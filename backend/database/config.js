const mongoose = require('mongoose');

const dbConnection = async() => {
    try {
        await mongoose.connect('mongodb+srv://bewithurrj:z2sClrBF7E5xIMmH@clusterflutter.fabyzc4.mongodb.net/?retryWrites=true&w=majority',{
            useNewUrlParser:true,
            useUnifiedTopology:true,
            useCreateIndex:true
        });
        console.log('Lets Chat Is Online');
    } catch (error) {
        console.log(error);
        throw new Error('Data Base Error');
    }
}

module.exports = { dbConnection }