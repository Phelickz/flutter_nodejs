const mongoose = require('mongoose')

const NoteSchema = mongoose.Schema({
    title: String,
    content: String,
    userID: String,
    important: Boolean,
    date: String
}, {
    timestamps: true
});

module.exports = mongoose.model('Note', NoteSchema);
