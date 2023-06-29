const QRCode = require('qrcode');
const User = require('./user');
const Express = require('express');
const cors = require('cors');
const fs = require('fs');
const bodyParser = require('body-parser');
const nodemailer = require('nodemailer');

const jsonParser = bodyParser.json();
const app = Express();
app.use(cors({
  origin: '*'
}));

app.listen(3000, (res) => {
  console.log('Server started at http://localhost:3000');
});

app.get('/', (req, res) => {
  console.log('hmm..');
  res.send('Hello World!');
});

app.post('/user', jsonParser, (req, res) => {
  const newUser = new User(req.body);
  newUser.save()
    .then(savedUser => {
      console.log('User saved:', savedUser);
      let stringy = savedUser._id.toString();
      QRCode.toFile('./qrcodes/' + stringy + '.png', stringy, function (err) {
        if (err) {
          console.log(err)
        } else {
          let fileData = fs.readFileSync('./qrcodes/' + stringy + '.png');
          console.log('done');

          const transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
              user: 'email',
              pass: 'password'
            }
          });

          const mailOptions = {
            from: `Otis Otison <SENDER_EMAIL>`,
            to: savedUser.email,
            subject: 'Welcome to X\s Customer Club!',
            html: `
                Hello ${savedUser.firstName}!<br><br>
                Thank you for joining our customer club!<br><br>
                Your QR code is attached to this email.<br><br>

                Please keep it safe and show it to our staff when you visit us.<br><br>

                Best regards,<br>
                X\s Customer Club
            `,
            attachments: [
              { 
                filename: stringy + '.png',
                content: fileData
              }
            ]
          };

          transporter.sendMail(mailOptions, (err, info) => {
            if (err) {
              console.log(err);
            } else {
              console.log('Email sent successfully!', info);
            }
          });

          fs.unlink('./qrcodes/' + stringy + '.png', (err) => {
                if (err) {
                    throw err;
                }
            
                console.log("File deleted successfully.");
            });
        }
      });

      res.send(JSON.stringify({ 'firstName': savedUser.firstName, 'lastName':savedUser.lastName, 'email': savedUser.email, 'cellphone': savedUser.cellphone }));
    })
    .catch(error => {
      console.error('Error saving user:', error);
    });
});

app.post('/addbeer', jsonParser, (req, res) => {
  const userId = req.body.userId;
  console.log('aaa?');
  User.findByIdAndUpdate(userId, { $inc: { beers: 1 } }, { new: true })
    .then(updatedUser => {
      console.log('success!');
      console.log('User updated:', updatedUser);
      res.send(JSON.stringify({'beers':updatedUser.beers,'firstName':updatedUser.firstName}));
    })
    .catch(error => {
      console.error('Error updating user:', error);
    });
});
