const express = require('express');
const Payment = require('../models/Payments');
const router = express.Router();

router.post('/addPayment', async (req, res) => {
    const { customerName, amount, status } = req.body;

    try {
        const payment = new Payment({ customerName, amount, status });
        await payment.save();
        res.status(201).json(payment);
    } catch (error) {
        res.status(400).json({ message: 'Error adding payment', error: error.message });
    }
});

router.get('/', async (req, res) => {
    try {
        const payments = await Payment.find();
        res.status(200).json(payments);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching payments', error: error.message });
    }
});

router.put('/updatePayment/:id', async (req, res) => {
    const { id } = req.params;
    const { customerName, amount, status } = req.body;

    try {
        const payment = await Payment.findByIdAndUpdate(id, { customerName, amount, status }, { new: true });
        if (!payment) return res.status(404).json({ message: 'Payment not found' });
        res.status(200).json(payment);
    } catch (error) {
        res.status(500).json({ message: 'Error updating payment', error: error.message });
    }
});

router.delete('/deletePayment/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const payment = await Payment.findByIdAndDelete(id);
        if (!payment) return res.status(404).json({ message: 'Payment not found' });
        res.status(200).json({ message: 'Payment deleted successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Error deleting payment', error: error.message });
    }
});

module.exports = router;
