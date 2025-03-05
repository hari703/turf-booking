const express = require('express');
const Turf = require('../models/Turf');
const multer = require('multer');
const path = require('path');

const router = express.Router();

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/');
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({ storage });

router.post('/addTurf', upload.single('image'), async (req, res) => {
    const { name, games, location, openHours, discount, rating } = req.body;
    const imageUrl = req.file.path;

    try {
        const turf = new Turf({ name, imageUrl, games, location, openHours, discount, rating });
        await turf.save();
        res.status(201).json(turf);
    } catch (error) {
        res.status(400).json({ message: 'Error adding turf', error: error.message });
    }
});

router.get('/', async (req, res) => {
    try {
        const turfs = await Turf.find();
        res.status(200).json(turfs);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching turfs', error: error.message });
    }
});

module.exports = router;
