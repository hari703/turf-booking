const mongoose = require('mongoose');

const slotSchema = new mongoose.Schema({
    sport: { type: String, required: true },
    date: { type: Date, required: true },
    time: { type: String, required: true },
    available: { type: Boolean, default: true }
}, { timestamps: true });

module.exports = mongoose.model('Slot', slotSchema);
