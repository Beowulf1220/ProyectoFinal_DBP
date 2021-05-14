import netP5.*;                                           // 1
import oscP5.*;
import ketai.net.*;
import ketai.sensors.*;
OscP5 oscP5;
KetaiSensor sensor;
NetAddress remoteLocation;
//Variables de conexión y acelerómetro
float myAccelerometerX, myAccelerometerY, myAccelerometerZ;
String x,y,p,myIPAddress,remoteAddress = "192.168.1.83";
//Variables para el juego
String misil="Misil",ready="Ready",notReady="Not Ready",laser="Laser",titulo="The Space Odyssey";
float anchoMisil,anchoReady,anchoNotReady,anchoLaser,anchoIP,anchoTitulo,xEstrellas[]=new float[200],yEstrellas[]=new float[200];
boolean disparoLaser,disparoMisil,listo;
void setup() {
  orientation(LANDSCAPE);
  textSize(72);
  sensor = new KetaiSensor(this);
  initNetworkConnection();
  sensor.start();
  for(int i=0;i<200;i++){
   xEstrellas[i]=random(width);
   yEstrellas[i]=random(height);
  }
  anchoTitulo=textWidth(titulo);
  anchoLaser=textWidth(laser);
  anchoReady=textWidth(ready);
  anchoNotReady=textWidth(notReady);
  anchoMisil=textWidth(misil);
  anchoIP=textWidth(myIPAddress);
}
void draw() {
  background(0);
  for(int i=0;i<200;i++){
   fill(255);
   ellipse(xEstrellas[i],yEstrellas[i],10,10);
  }
  //Botón misil
  if(disparoMisil){
  fill(53,103,255);
  rect(width/18,height/6,(4.5*width)/18,(4*height)/6,7);
  delay(1000);
  disparoMisil = false;
  }else{
  fill(53,103,180);
  rect(width/18,height/6,(4.5*width)/18,(4*height)/6,7);  
  }
  //Boton de listo
  if(listo){
  fill(127);
  rect((7*width)/18,height/6,(4.5*width)/18,(4*height)/6,7);
  fill(255);
  text(ready,((9.25*width)/18)-(anchoReady/2),(height/2)+18);
  }else{
  fill(127);
  rect((7*width)/18,height/6,(4.5*width)/18,(4*height)/6,7);
  fill(255);
  text(notReady,((9.25*width)/18)-(anchoNotReady/2),(height/2)+18);
  }
  //Boton laser
  if(disparoLaser){
  fill(255,33,25);
  rect((13*width)/18,height/6,(4.5*width)/18,(4*height)/6,7);
  delay(100);
  disparoLaser = false;
  }else{
  fill(159,33,25);
  rect((13*width)/18,height/6,(4.5*width)/18,(4*height)/6,7);  
  }
  //Fondo negro del titulo
  fill(0);
  rect(width/2-(anchoTitulo)/2,(height/12)-36,anchoTitulo,72);
  // Dibujo de los textos
  fill(255);
  text(misil,((3.25*width)/18)-(anchoMisil/2),(height/2)+18);
  text(laser,((15.25*width)/18)-(anchoLaser/2),(height/2)+18);
  text(titulo,width/2-(anchoTitulo)/2,(height/12)+18);
  text(myIPAddress,width/2-(anchoIP)/2,(11*height/12)-18);
  //Envio de datos
  OscMessage myMessage = new OscMessage("botonesApp");
  myMessage.add(disparoMisil);
  myMessage.add(listo);
  myMessage.add(disparoLaser);
  myMessage.add(myAccelerometerY);
  oscP5.send(myMessage, remoteLocation);
}
void mousePressed(){
  //Boton de listo
  if (mouseX > 7*width/18 && mouseX < 7*width/18+(4.5*width)/18 && mouseY > height/6 && mouseY < height/6+(4*height)/6 && listo==false) {
    listo = true;
  }else if(mouseX > 7*width/18 && mouseX < 7*width/18+(4.5*width)/18 && mouseY > height/6 && mouseY < height/6+(4*height)/6 && listo==true) {
    listo = false; 
  }
  //Boton de misil y de laser
  if (mouseX > width/18 && mouseX < width/18+(4.5*width)/18 && mouseY > height/6 && mouseY < height/6+(4*height)/6 && disparoMisil==false) {
    disparoMisil = true;
  }
  if (mouseX > 13*width/18 && mouseX < 13*width/18+(4.5*width)/18 && mouseY > height/6 && mouseY < height/6+(4*height)/6 && disparoLaser==false) {
    disparoLaser = true;
  }
}
void onAccelerometerEvent(float x, float y, float z)
{
  myAccelerometerX = x;
  myAccelerometerY = y;
  myAccelerometerZ = z;
}
void initNetworkConnection()
{
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress(remoteAddress, 12001);
  myIPAddress = KetaiNet.getIP();
}
