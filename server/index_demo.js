// Import the User model
const QRCode = require('qrcode');
const User = require('./user');

// Create a new user
const newUser = new User({
  firstName: 'John',
  lastName: 'Doe',
  email: 'johndoe@example.com',
  cellphone: '1234567890'
});

// Save the new user to the database
newUser.save()
  .then(savedUser => {
    console.log('User saved:', savedUser);
    let stringy = savedUser._id.toString();
    QRCode.toDataURL(stringy, function (err, url) {
        if (err) {
            console.log('Error', err);
        } else {
            console.log(url);
        }
    });
  })
  .catch(error => {
    console.error('Error saving user:', error);
  });

// Find all users
User.find()
  .then(users => {
    console.log('All users:', users);
  })
  .catch(error => {
    console.error('Error finding users:', error);
  });

// Find a user by email
User.findOne({ email: 'johndoe@example.com' })
  .then(user => {
    console.log('User found:', user);
  })
  .catch(error => {
    console.error('Error finding user:', error);
  });

// Update a user
User.findOneAndUpdate({ email: 'johndoe@example.com' }, { firstName: 'Jane' })
  .then(updatedUser => {
    console.log('User updated:', updatedUser);
  })
  .catch(error => {
    console.error('Error updating user:', error);
  });

// Delete a user
User.findOneAndDelete({ email: 'johndoe@example.com' })
  .then(deletedUser => {
    console.log('User deleted:', deletedUser);
  })
  .catch(error => {
    console.error('Error deleting user:', error);
  });
