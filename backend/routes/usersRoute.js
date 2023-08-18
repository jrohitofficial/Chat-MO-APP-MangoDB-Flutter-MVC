// path: /auth/login

const { Router } = require('express');
const { getUsers } = require('../controllers/usersController');
const { validateJWT } = require('../middlewares/validate_jwt');

const router = Router();

//validateJWT
router.get('/',validateJWT, getUsers)

module.exports = router;

