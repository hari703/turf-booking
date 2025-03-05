const express = require('express');
const Team = require('../models/Team');
const router = express.Router();

// Create a team
router.post('/create', async (req, res) => {
  const { teamName, members, sport } = req.body;
  try {
    const team = new Team({ teamName, members, sport });
    await team.save();
    res.status(201).json({ message: 'Team created successfully', team });
  } catch (error) {
    res.status(400).json({ message: 'Failed to create team' });
  }
});

// Find teams
router.get('/', async (req, res) => {
  try {
    const teams = await Team.find();
    res.status(200).json(teams);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch teams' });
  }
});

module.exports = router;
