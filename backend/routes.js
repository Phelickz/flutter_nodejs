const express = require('express');
const router = express.Router();

const notes = require('./controllers/controller.js');
const users = require('./controllers/userController')


//defining a simple route
router.get('/', (req, res) => {
    res.json({"message": "Welcome to EasyNotes application. Take notes quickly. Organize and keep track of all your notes."});
});

//Create a new user
router.post('/register', users.create)

//Get user
router.get('/me/:userId', users.getUser)

//Login user
router.post('/login', users.login)

router.get('/users', users.findAll);

// Create a new Note
router.post('/notes', notes.create);

// Retrieve all Notes
router.get('/notes', notes.findAll);

router.get('/important', notes.findImportant);

// Retrieve a single Note with noteId
router.get('/notes/:noteId', notes.findOne);

// Retrieve a single Note with userID
router.get('/notes/:userId', notes.findOneByUser);

// Update a Note with noteId
router.put('/notes/:noteId', notes.update);

// Delete a Note with noteId
router.delete('/notes/:noteId', notes.delete);


module.exports = router;