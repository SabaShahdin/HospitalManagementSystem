import express from 'express';
import User from '../models/user.js';
import Admin from '../models/Admin.js';

const router = express.Router();

// POST /api/admin/register
router.post('/register', async (req, res) => {
  try {
    const { email, name, contactNumber, department } = req.body;

    // Check if already exists
    const existingUser = await User.findOne({ email });
    if (existingUser) return res.status(400).json({ message: "User already exists" });

    // Create User
    const user = new User({ email, role: 'Admin' });
    await user.save();

    // Create Admin details
    const admin = new Admin({ userId: user._id, name, contactNumber, department });
    await admin.save();

    res.status(201).json({ message: "Admin registered successfully", admin });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
});

export default router;
