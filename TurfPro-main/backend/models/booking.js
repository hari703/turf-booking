const mongoose = require('mongoose');

const bookingSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    slotId: { type: mongoose.Schema.Types.ObjectId, ref: 'Slot', required: true },
    selectedSport: { type: String, required: true },
    selectedDate: { type: Date, required: true },
    selectedTimeSlot: { type: String, required: true },
    isFullCourt: { type: Boolean, required: true },
    subTotal: { type: Number, required: true },
    discount: { type: Number, required: true },
    payableAmount: { type: Number, required: true },
    advancePayment: { type: Number, required: true },
}, { timestamps: true });

module.exports = mongoose.model('Booking', bookingSchema);
