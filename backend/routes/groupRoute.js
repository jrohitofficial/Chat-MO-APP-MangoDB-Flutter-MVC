
const { Router } = require('express');
const { createGroup, getGroups } = require('../controllers/gourpController');
const { validateJWT } = require('../middlewares/validate_jwt');

const router = Router();

// create Group
router.post('/',validateJWT, createGroup); //validateJWT, 

// get group
router.get('/',validateJWT, getGroups); // validateJWT, 

module.exports = router;