const express = require('express');
const router = express.Router();

const notes = require('./controllers/controller.js');
const users = require('./controllers/userController')
const reminders = require('./controllers/reminders.js')


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

router.post('/important', notes.findImportant);

// Retrieve a single Note with noteId
router.get('/notes/:noteId', notes.findOne);

// Retrieve a single Note with userID
router.post('/notes/user', notes.findByUser);

// Update a Note with noteId
router.put('/notes/:noteId', notes.update);

// Delete a Note with noteId
router.delete('/notes/:noteId', notes.delete);


router.post('/reminders', reminders.create);

// Retrieve all Notes
router.post('/reminders/user', reminders.findAll);

router.get('/completed', reminders.findImportant);

// Retrieve a single Note with noteId
router.get('/reminders/:reminderId', reminders.findOne);

// Retrieve a single Note with userID
router.get('/reminders/:userId', reminders.findOneByUser);

// Update a Note with noteId
router.put('/reminders/:reminderId', reminders.update);

// Delete a Note with noteId
router.delete('/reminders/:reminderId', reminders.delete);


module.exports = router;