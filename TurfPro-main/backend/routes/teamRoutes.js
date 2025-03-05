const express = require('express');
const Team = require('../models/Team');
const router = express.Router();

// Create a team
router.post('/', async (req, res) => {
    const { members, sport, name } = req.body;
    try {
        const newTeam = new Team({ members, sport, name });
        await newTeam.save();
        res.status(201).json({ message: 'Team created successfully', team: newTeam });
    } catch (error) {
        res.status(400).json({ message: 'Error creating team', error });
    }
});

// Get all teams for a sport
router.get('/:sport', async (req, res) => {
    try {
        const teams = await Team.find({ sport: req.params.sport }).populate('members');
        res.status(200).json(teams);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching teams', error });
    }
});

module.exports = router;
