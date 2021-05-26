dbProfile = firebase.database().ref('Game/Profiles').orderByChild('score').limitToLast(3);
var profiles="";
var i=1;
dbProfile.on('value',(snapshot)=>{
    snapshot.forEach((childSnapshot)=>{
        console.log("key: "+childSnapshot.key);
        console.log(childSnapshot.val());
        var prevProfile='<li><div>';
                prevProfile+='<h1>'+i+'.- '+childSnapshot.val().name+'</h1>';
                prevProfile+='<h2>Puntos: '+childSnapshot.val().score+"<br> Avance: "+childSnapshot.val().save;
                prevProfile+='</h2></div>';
                prevProfile+='</li>';
                i++;
                $(prevProfile).appendTo('#rank');
    });
});