const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.triggerNotification = functions.firestore.document('EventList/{eventID}').onCreate(async (event) => {
    var payLoad = {
        notification: {title: 'New Post released!!' , body: 'Check out the brand new post of team Effe\'20'},
        data: {click_action: 'FLUTTER_NOTIFICATION_CLICK' , message: 'Sample Push Message!'},
        topic: 'events',
    };
    let response = await admin.messaging().send(payLoad);
    console.log(response);
});

    
   

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
