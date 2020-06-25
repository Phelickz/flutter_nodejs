const Reminder = require('../models/reminder.js');

// Create and Save a new Reminder
exports.create = (req, res) => {
    // Validate request
    if (!req.body.title) {
        return res.status(400).send({
            message: "Reminder content can not be empty"
        });
    }

    // Create a Reminder
    const reminder = new Reminder({
        title: req.body.title || "Untitled Reminder",
        userID: req.body.userID,
        time: req.body.time,
        completed: req.body.completed,
        date: req.body.date
    });

    // Save reminder in the database
    reminder.save()
        .then(data => {
            res.status(200).send(data);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while creating the reminder."
            });
        });
};


// Retrieve and return all reminders from the database.
exports.findAll = (req, res) => {
    var query = {userID : req.body.userId}
    Reminder.find(query)
        .then(reminders => {
            res.send(reminders);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving reminders."
            });
        });
};


exports.findImportant = (req, res) => {
    var query = {userID: req.body.userId, important: true};
    Reminder.find(query)
        .then(reminders => {
            res.send(reminders);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving reminders."
            });
        });
};

// Find a single reminder with a reminderId
exports.findOne = (req, res) => {
    Reminder.findById(req.params.reminderId)
        .then(reminder => {
            if (!reminder) {
                return res.status(404).send({
                    message: "reminder not found with id " + req.params.reminderId
                });
            }
            res.send(reminder);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "reminder not found with id " + req.params.reminderId
                });
            }
            return res.status(500).send({
                message: "Error retrieving reminder with id " + req.params.reminderId
            });
        });
};

exports.findOneByUser = (req, res) => {
    Reminder.findById(req.params.userId)
        .then(reminder => {
            if (!reminder) {
                return res.status(404).send({
                    message: "reminder not found with id " + req.params.userId
                });
            }
            res.send(reminder);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "reminder not found with id " + req.params.userId
                });
            }
            return res.status(500).send({
                message: "Error retrieving reminder with id " + req.params.userId
            });
        });
};

// Update a reminder identified by the reminderId in the request
exports.update = (req, res) => {
    // Validate Request
    if (!req.body.content) {
        return res.status(400).send({
            message: "reminder content can not be empty"
        });
    }
    //The {new: true} option in the findByIdAndUpdate() method is used to return the modified document to the then() function instead of the original
    // Find reminder and update it with the request body
    Reminder.findByIdAndUpdate(req.params.reminderId, {
        title: req.body.title || "Untitled reminder",
        content: req.body.content
    }, { new: true })
        .then(reminder => {
            if (!reminder) {
                return res.status(404).send({
                    message: "reminder not found with id " + req.params.reminderId
                });
            }
            res.send(reminder);
        }).catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "reminder not found with id " + req.params.reminderId
                });
            }
            return res.status(500).send({
                message: "Error updating reminder with id " + req.params.reminderId
            });
        });
};

// Delete a reminder with the specified reminderId in the request
exports.delete = (req, res) => {
    Reminder.findByIdAndRemove(req.params.reminderId)
        .then(reminder => {
            if (!reminder) {
                return res.status(404).send({
                    message: "reminder not found with id " + req.params.reminderId
                });
            }
            res.send({ message: "reminder deleted successfully!" });
        }).catch(err => {
            if (err.kind === 'ObjectId' || err.name === 'NotFound') {
                return res.status(404).send({
                    message: "reminder not found with id " + req.params.reminderId
                });
            }
            return res.status(500).send({
                message: "Could not delete Reminder with id " + req.params.reminderId
            });
        });
};
