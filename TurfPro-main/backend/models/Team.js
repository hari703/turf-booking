const mongoose = require('mongoose');

const teamSchema = new mongoose.Schema({
    members: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    sport: { type: String, required: true },
    name: { type: String, required: true }
}, { timestamps: true });

module.exports = mongoose.model('Team', teamSchema);
