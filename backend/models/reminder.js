const mongoose = require('mongoose')

const ReminderSchema = mongoose.Schema({
    title: String,
    userID: String,
    time: String,
    completed: Boolean,
    date: String
}, {
    timestamps: true
});

module.exports = mongoose.model('Reminder', ReminderSchema);
