// path: /auth/login

const { Router } = require('express');
const { getChat } = require('../controllers/messagesController');
const { validateJWT } = require('../middlewares/validate_jwt');

const router = Router();

//validateJWT
router.get('/:from',validateJWT, getChat)

module.exports = router;