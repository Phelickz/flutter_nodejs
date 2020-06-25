var bcrypt = require('bcrypt')
var jwt = require('jsonwebtoken')
const config = require('../DB/config');
const User = require('../models/user.js');



exports.create = (req, res) => {
    var hashedPassword = bcrypt.hashSync(req.body.password, 8);

    User.findOne({
        email: req.body.email,
    }, function (err, user) {
        if (err) return res.status(500).send('Error on the server');
        if (user) return res.status(400).send('Email address already exists')

        User.findOne({
            name: req.body.name,
        }, function (err, user) {
            if (err) return res.status(500).send('Error on the server');
            if (user) return res.status(405).send('Username already exists')

            User.create({
                name: req.body.name,
                email: req.body.email,
                password: hashedPassword
            },
                function (err, user) {
                    if (err) return res.status(500).send("There was a problem registering the user.")
                    // create a token
                    // var token = jwt.sign({ id: user._id }, config.secret, {
                    //     expiresIn: 86400 // expires in 24 hours
                    // });
                    res.status(200).send({ auth: true, data: user });
                });
        })
    })


}


exports.getUser = (req, res) => {
    // var token = req.headers['x-access-token'];
    // if (!token) return res.status(401).send({ auth: false, message: 'No token provided.' });

    // jwt.verify(token, config.secret, function (err, decoded) {
    // if (err) return res.status(500).send({ auth: false, message: 'Failed to authenticate token.' });

    User.findById(req.params.userId,
        { password: 0 }, // projection. so the password doesnt come with the output
        function (err, user) {
            if (err) return res.status(500).send("There was a problem finding the user.");
            if (!user) return res.status(404).send("No user found.");

            res.status(200).send(user);
        });
    // });
}

exports.findAll = (req, res) => {
    User.find()
        .then(users => {
            console.log(users);
            res.send(users);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving notes."
            });
        });
};


exports.login = (req, res) => {
    User.findOne({ email: req.body.email }, function (err, user) {
        if (err) return res.status(500).send('Error on the server.');
        if (!user) return res.status(404).send('No user found.');

        var passwordIsValid = bcrypt.compareSync(req.body.password, user.password);
        if (!passwordIsValid) return res.status(401).send({ auth: false, token: null });

        // var token = jwt.sign({ id: user._id }, config.secret, {
        //     expiresIn: 86400 // expires in 24 hours
        // });

        res.status(200).send(user);
    });
}