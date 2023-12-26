import{ initializeApp } from "firebase/app";
import{ getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries
// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyBClEfOulOXnC4F6SXiX4AcWJAAjITqO_s",
  authDomain: "bookingsaloonsapps.firebaseapp.com",
  databaseURL: "https://bookingsaloonsapps-default-rtdb.europe-west1.firebasedatabase.app",
  projectId: "bookingsaloonsapps",
  storageBucket: "bookingsaloonsapps.appspot.com",
  messagingSenderId: "271964176052",
  appId: "1:271964176052:web:f7aa6ee111d31dbc56a1e1",
  measurementId: "G-M2G34DS3N2"
};
// Initialize Firebase
const app = initializeApp(firebaseConfig);
let analytics;
// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
analytics = getAnalytics(app);
