const User = require('../models/User');
const Admin = require('../models/Admin');
const Manager = require('../models/Manager');
const bcrypt = require('bcrypt');

async function loginUser(email, password) {
    const user = await User.findOne({ email });
    const admin = await Admin.findOne({ email });
    const manager = await Manager.findOne({ email });

    const account = user || admin || manager;

    if (!account) {
        throw new Error('No account found with this email');
    }

    // Check password based on account type
    let isMatch;
    if (user || manager) {
        // For User and Manager, check hashed password
        isMatch = await bcrypt.compare(password, account.password);
    } else {
        // For Admin, check plain password
        isMatch = (password === account.password);
    }

    if (!isMatch) {
        throw new Error('Invalid credentials');
    }

    return {
        accountType: user ? 'User' : admin ? 'Admin' : 'Manager',
        message: 'Login successful',
        email: account.email
    };
}

module.exports = { loginUser };
