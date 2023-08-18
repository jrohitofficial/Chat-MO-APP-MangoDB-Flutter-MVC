// path: /auth/login

const { Router } = require('express');
const { check } = require('express-validator');
const { createUser,loginUser,renewToken } = require('../controllers/authController');
const { validateFields } = require('../middlewares/validate_fields');
const { validateJWT } = require('../middlewares/validate_jwt');

const router = Router();

//router.post('/new',createUser);
router.post('/new',[
    check('name','Name is obligatory').not().isEmpty(),
    check('email','Email is obligatory').isEmail(),
    check('password','Password is obligatory').not().isEmpty(),
    validateFields
],createUser);

router.post('/',[
    check('email','Email is obligatory').isEmail(),
    check('password','Password is obligatory').not().isEmpty(),
    validateFields
],loginUser);

//validateJWT
router.get('/renew',validateJWT, renewToken)

module.exports = router;

