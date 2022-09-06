const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.createUser = functions.firestore
    .document('chats/{message}')
    .onCreate((snap, context) => {
      // Get an object representing the document
      // e.g. {'name': 'Marie', 'age': 66}
      const newValue = snap.data();
      console.log(newValue);

      // access a particular field as you would any JS property
      
    return admin.messaging().sendToTopic('chats',{
    notification:{
        title:newValue.username,
        body:newValue.text,
        clickAction: 'planit'
    }
})
      // perform desired operations ...
      return;
    });
