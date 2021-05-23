//creamos una referencia a la base de datos para enviar el valor de la pagina en que nos encontramos
// dbProfiles = firebase.database().ref('Game/CProfiles'); //Cantidad de usuarios
/*dbProfiles.child('cantity').on('value', function(snap){
    Cantity = snap.val();
  });*/ //Tomamos la cantidad de usuarios

dbProfile = firebase.database().ref('Game/Profiles/1');
// llamamos los valores cadavez que un cambio  existe en la base de datos
dbProfile.child('name').on('value', function(snap){
    Name.innerText = snap.val(); // enviar los valores a html
    Namejs = snap.val(); // usar los valores en la funcion
  });
dbProfile.child('score').on('value', function(snap){
  Score.innerText = snap.val();
  Scorejs = snap.val();
});
dbProfile.child('save').on('value', (snapshot)=>{
  Pro.innerText = snapshot.val();
  Projs = snapshot.val();
});