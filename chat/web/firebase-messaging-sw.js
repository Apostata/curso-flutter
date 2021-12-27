importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js');

   /*Update with yours config*/
  const firebaseConfig = {
    apiKey: "AIzaSyDc4ZHJy_i9zJaC7307_vXgWRrDIsbE5qM",
    authDomain: "flutter-chat-app-2f83c.firebaseapp.com",
    projectId: "flutter-chat-app-2f83c",
    storageBucket: "flutter-chat-app-2f83c.appspot.com",
    messagingSenderId: "406068591564",
    appId: "1:406068591564:web:cd35d7a43208ba6635fb69"
 };
  firebase.initializeApp(firebaseConfig);
  
  const messaging = firebase.messaging();
  
