const mongoose = require('mongoose');

// Define the item schema
const itemSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true, // Remove extra whitespace from name
  },
  description: {
    type: String,
    default: '',
  },
  photos: [
    {
      type: String, // Store image URLs initially
      required: true,
    },
  ],
  shopId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Shop', // Reference the Shop model
    required: true,
  },
  longitude: {
    type: Number,
    required: true,
  },
  latitude: {
    type: Number,
    required: true,
  },
});

// Export the Mongoose model
module.exports = mongoose.model('Item', itemSchema);
