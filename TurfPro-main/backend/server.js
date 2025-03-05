const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
const User = require('./models/User');
const Payment = require('./models/Payments');
const Turf = require('./models/Turf'); 
require('dotenv').config();

const app = express();
app.use(express.json());
app.use(cors());

mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log('Connected to MongoDB'))
  .catch((err) => console.error('MongoDB connection error:', err));

app.post('/api/user/forgot-password', async (req, res) => {
  const { email } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    
    res.status(200).json({ message: 'Password reset instructions will be sent.' });
  } }
  catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
});

// Turf routes
app.post('/api/turf', async (req, res) => {
  const newTurf = new Turf(req.body);
  try {
    const savedTurf = await newTurf.save();
    res.status(201).json(savedTurf);
  } catch (error) {
    res.status(400).json({ message: 'Error creating turf' });
  }
});

app.get('/api/turf', async (req, res) => {
  try {
    const turfs = await Turf.find();
    res.status(200).json(turfs);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching turfs' });
  }
});

app.get('/api/turf/:id', async (req, res) => {
  try {
    const turf = await Turf.findById(req.params.id);
    if (!turf) {
      return res.status(404).json({ message: 'Turf not found' });
    }
    res.status(200).json(turf);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching turf' });
  }
});

// Payment routes
const paymentRoutes = require('./routes/paymentsRoutes');
app.use('/api/payments', paymentRoutes);

// Admin, Manager, User routes
const adminRoutes = require('./routes/admin');
const managerRoutes = require('./routes/manager');
const userRoutes = require('./routes/user');

app.use('/api/admin', adminRoutes);
app.use('/api/manager', managerRoutes);
app.use('/api/user', userRoutes);

app.use((req, res, next) => {
  res.status(404).json({ message: 'Not Found' });
});

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Internal Server Error' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});
