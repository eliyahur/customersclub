// Import required modules
const mongoose = require('mongoose');

// Connect to the MongoDB database
mongoose.connect('mongodb://127.0.0.1:27017/mydatabase', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
  .then(() => {
    console.log('Connected to the database');
  })
  .catch(error => {
    console.error('Database connection error:', error);
  });

// Define the user schema
const userSchema = new mongoose.Schema({
  firstName: {
    type: String,
    required: true
  },
  lastName: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true
    // unique: true
  },
  cellphone: {
    type: String,
    required: true
  },
  beers: {
    type: Number,
    required: true,
    default: 0
  }
});

// Define the user model
const User = mongoose.model('User', userSchema);

// Export the user model
module.exports = User;
