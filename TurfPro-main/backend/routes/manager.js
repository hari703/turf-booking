const express = require('express');
const Turf = require('../models/Turf');
const router = express.Router();

// Manager: Assist users in booking turfs
router.post('/bookTurf', async (req, res) => {
  const { turfId, date, time, duration, userId } = req.body;

  try {
    const turf = await Turf.findById(turfId);
    if (!turf) return res.status(404).json({ message: 'Turf not found' });

    const slotIndex = turf.availableSlots.findIndex(slot =>
      slot.date.toISOString().split('T')[0] === date &&
      slot.time === time
    );

    if (slotIndex === -1) return res.status(400).json({ message: 'Slot not available' });

    turf.availableSlots[slotIndex].bookedBy.push(userId);
    await turf.save();

    res.status(200).json({ message: 'Turf booked successfully', turf });
  } catch (error) {
    res.status(500).json({ message: 'Error booking turf' });
  }
});

// Manager: View available turfs
router.get('/turfs', async (req, res) => {
  try {
    const turfs = await Turf.find();
    res.status(200).json(turfs);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching turfs' });
  }
});

module.exports = router;
