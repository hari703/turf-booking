const mongoose = require('mongoose');

const paymentSchema = new mongoose.Schema({
    customerName: { type: String, required: true },
    amount: { type: Number, required: true },
    status: { type: String, enum: ['Pending', 'Completed'], default: 'Pending' },
}, { timestamps: true });

module.exports = mongoose.model('Payment', paymentSchema);
