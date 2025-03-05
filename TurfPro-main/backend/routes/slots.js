const express = require('express');
const Slot = require('../models/Slot');
const router = express.Router();

// Get available slots
router.get('/', async (req, res) => {
  try {
    const slots = await Slot.find({ booked: false });
    res.status(200).json(slots);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch slots' });
  }
});

// Book a slot
router.post('/book', async (req, res) => {
  const { slotId, userId } = req.body;
  try {
    const slot = await Slot.findByIdAndUpdate(slotId, { booked: true, userId }, { new: true });
    res.status(200).json({ message: 'Slot booked successfully', slot });
  } catch (error) {
    res.status(500).json({ message: 'Failed to book slot' });
  }
});

// Cancel a booking
router.delete('/cancel/:slotId', async (req, res) => {
  const { slotId } = req.params;
  try {
    const slot = await Slot.findByIdAndUpdate(slotId, { booked: false, userId: null }, { new: true });
    res.status(200).json({ message: 'Booking cancelled successfully', slot });
  } catch (error) {
    res.status(500).json({ message: 'Failed to cancel booking' });
  }
});

module.exports = router;
