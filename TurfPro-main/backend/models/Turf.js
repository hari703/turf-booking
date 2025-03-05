const mongoose = require('mongoose');

const turfSchema = new mongoose.Schema({
    name: { type: String, required: true },
    imageUrl: { type: String, required: true },
    games: { type: String, required: true },
    location: { type: String, required: true },
    openHours: { type: String, required: true },
    discount: { type: String, required: true },
    rating: { type: Number, required: true },
}, { timestamps: true });

module.exports = mongoose.model('Turf', turfSchema);
