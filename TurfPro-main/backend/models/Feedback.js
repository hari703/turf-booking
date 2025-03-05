const mongoose = require('mongoose');

const feedbackSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  message: String,
  response: String,
  status: { type: String, enum: ['pending', 'responded'], default: 'pending' },
  timestamp: { type: Date, default: Date.now }
}, { collection: 'feedback' });

module.exports = mongoose.model('Feedback', feedbackSchema);
