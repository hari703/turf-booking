const express = require('express');
const bcrypt = require('bcrypt');
const User = require('../models/User');
const Turf = require('../models/Turf');
const { loginUser } = require('../Controllers/authControllers');
const router = express.Router();

// User registration
router.post('/register', async (req, res) => {
    const { username, email, password, mobile } = req.body; 

    try {
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: 'User already exists' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const newUser = new User({ username, email, password: hashedPassword, mobile }); 
        await newUser.save();
        res.status(201).json({ message: 'User registered successfully' });
    } catch (error) {
        console.error('Error registering user:', error);
        res.status(400).json({ message: 'Error registering user', error });
    }
});

// User login
router.post('/login', async (req, res) => {
    const { email, password } = req.body;

    try {
        const response = await loginUser(email, password);
        return res.status(200).json(response);
    } catch (error) {
        if (error.message === 'No account found with this email') {
            return res.status(404).json({ message: error.message });
        }
        if (error.message === 'Invalid credentials') {
            return res.status(401).json({ message: error.message });
        }
        console.error('Login error:', error);
        return res.status(500).json({ message: 'Server error', error });
    }
});

// User: Book Turf
router.post('/bookTurf', async (req, res) => {
    const { turfId, date, time, userId } = req.body;

    try {
        const turf = await Turf.findById(turfId);
        if (!turf) return res.status(404).json({ message: 'Turf not found' });

        const slotIndex = turf.availableSlots.findIndex(slot =>
            slot.date.toISOString().split('T')[0] === date &&
            slot.time === time &&
            !slot.bookedBy.includes(userId) 
        );

        if (slotIndex === -1) return res.status(400).json({ message: 'Slot not available' });

        turf.availableSlots[slotIndex].bookedBy.push(userId);
        await turf.save();

        res.status(200).json({ message: 'Turf booked successfully', turf });
    } catch (error) {
        console.error('Error booking turf:', error);
        res.status(500).json({ message: 'Error booking turf', error });
    }
});

// User: View available turfs
router.get('/turfs', async (req, res) => {
    try {
        const turfs = await Turf.find();
        res.status(200).json(turfs);
    } catch (error) {
        console.error('Error fetching turfs:', error);
        res.status(500).json({ message: 'Error fetching turfs', error });
    }
});

module.exports = router;
