const express = require('express');
const bcrypt = require('bcrypt');
const User = require('../models/User');
const Turf = require('../models/Turf');
const Manager = require('../models/Manager');
const Feedback = require('../models/Feedback');
const Slot = require('../models/Slot');
const router = express.Router();

// Slot routes
router.post('/slots', async (req, res) => {
    const { sport, date, time } = req.body;
    const newSlot = new Slot({ sport, date, time });
    try {
        await newSlot.save();
        res.status(201).json({ message: 'Slot created successfully', slot: newSlot });
    } catch (error) {
        res.status(400).json({ message: 'Error creating slot', error: error.message });
    }
});

router.get('/slots', async (req, res) => {
    try {
        const slots = await Slot.find();
        res.status(200).json(slots);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching slots', error: error.message });
    }
});

// Manager routes
router.post('/addManager', async (req, res) => {
    const { name, email, phone, password } = req.body;

    if (!name || !email || !phone || !password) {
        return res.status(400).json({ message: 'All fields are required.' });
    }

    try {
        const hashedPassword = await bcrypt.hash(password, 10);
        const manager = new Manager({
            name,
            email,
            phone,
            password: hashedPassword,
        });

        await manager.save();
        res.status(201).json({ message: 'Manager added successfully', manager });
    } catch (error) {
        res.status(400).json({ message: 'Error adding manager', error: error.message });
    }
});

// Update Manager
router.put('/updateManager/:id', async (req, res) => {
    const { id } = req.params;
    const { name, email, phone } = req.body;

    if (!name || !email || !phone) {
        return res.status(400).json({ message: 'All fields are required.' });
    }

    try {
        const updatedManager = await Manager.findByIdAndUpdate(
            id,
            { name, email, phone },
            { new: true }
        );

        if (!updatedManager) {
            return res.status(404).json({ message: 'Manager not found.' });
        }

        res.status(200).json({ message: 'Manager updated successfully', updatedManager });
    } catch (error) {
        res.status(400).json({ message: 'Error updating manager', error: error.message });
    }
});

// Delete Manager
router.delete('/deleteManager/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const deletedManager = await Manager.findByIdAndDelete(id);

        if (!deletedManager) {
            return res.status(404).json({ message: 'Manager not found.' });
        }

        res.status(200).json({ message: 'Manager deleted successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Error deleting manager', error: error.message });
    }
});

// Get Managers
router.get('/managers', async (req, res) => {
    try {
        const managers = await Manager.find();
        res.status(200).json(managers);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching managers', error: error.message });
    }
});

// Feedback routes
router.put('/feedback/:id', async (req, res) => {
    const { id } = req.params;
    const { response } = req.body;

    try {
        const feedback = await Feedback.findByIdAndUpdate(
            id,
            { response, status: 'responded' },
            { new: true }
        );

        if (!feedback) return res.status(404).json({ message: 'Feedback not found' });
        res.status(200).json({ message: 'Feedback responded to', feedback });
    } catch (error) {
        res.status(500).json({ message: 'Failed to respond to feedback', error: error.message });
    }
});

router.get('/feedback', async (req, res) => {
    try {
        const feedbacks = await Feedback.find().populate('userId');
        res.status(200).json(feedbacks);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching feedback', error: error.message });
    }
});

// Dashboard route
router.get('/dashboard', (req, res) => {
    res.json({ message: 'Admin dashboard data' });
});

module.exports = router;
