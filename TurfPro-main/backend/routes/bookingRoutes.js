const express = require('express');
const Booking = require('../models/booking');
const Slot = require('../models/Slot');
const router = express.Router();

// Book a slot
router.post('/', async (req, res) => {
    const { userId, slotId, selectedSport, selectedDate, selectedTimeSlot, isFullCourt, subTotal, discount, payableAmount, advancePayment } = req.body;
    try {
        const slot = await Slot.findById(slotId);
        if (!slot || !slot.available) {
            return res.status(400).json({ message: 'Slot not available' });
        }

        const newBooking = new Booking({
            userId,
            slotId,
            selectedSport,
            selectedDate,
            selectedTimeSlot,
            isFullCourt,
            subTotal,
            discount,
            payableAmount,
            advancePayment
        });
        await newBooking.save();
        slot.available = false;
        await slot.save();

        res.status(201).json({ message: 'Booking successful', booking: newBooking });
    } catch (error) {
        res.status(400).json({ message: 'Error booking slot', error });
    }
});

// Cancel a booking
router.delete('/:id', async (req, res) => {
    try {
        const booking = await Booking.findByIdAndDelete(req.params.id);
        if (!booking) return res.status(404).json({ message: 'Booking not found' });

        const slot = await Slot.findById(booking.slotId);
        slot.available = true;
        await slot.save();

        res.status(200).json({ message: 'Booking cancelled successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Error cancelling booking', error });
    }
});

// Get all bookings for a user
router.get('/user/:userId', async (req, res) => {
    try {
        const bookings = await Booking.find({ userId: req.params.userId }).populate('slotId');
        res.status(200).json(bookings);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching bookings', error });
    }
});

module.exports = router;
