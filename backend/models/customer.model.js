const mongoose = require('mongoose');

// Define the customer schema
const customerSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true, // Ensure unique usernames
    trim: true, // Remove extra whitespace
  },
  password: {
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  address: {
    type: String,
  },
  phone: {
    type: String,
  },
  favoriteShops: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Shop', // Reference the Shop model
    },
  ],
  favoriteItems: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Item', // Reference the Item model
    },
  ],
});

// Export the Mongoose model
module.exports = mongoose.model('Customer', customerSchema);
