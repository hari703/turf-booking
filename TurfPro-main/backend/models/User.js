const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    username: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    mobile: { type: String, required: true }, 
    role: { type: String, default: 'user' },
    bookings: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Booking' }] 
}, { collection: 'users', timestamps: true }); // Combined options into one object

module.exports = mongoose.model('User', userSchema);
