import netP5.*;
import oscP5.*;
import ketai.net.*;
import ketai.sensors.*;
import android.os.Bundle;
import android.view.WindowManager;

OscP5 oscP5;
KetaiSensor sensor;
public static NetAddress remoteLocation;

//Variables de conexión y acelerómetro
float myAccelerometerX, myAccelerometerY, myAccelerometerZ;
String x, y, p, myIPAddress;
public static String remoteAddress;

//Variables para el juego
String misil="Misil", ready="Ready", notReady="Not Ready", laser="Laser", titulo="The Space Odyssey";
float anchoMisil, anchoReady, anchoNotReady, anchoLaser, anchoIP, anchoTitulo, xEstrellas[]=new float[200], yEstrellas[]=new float[200];
boolean disparoLaser, disparoMisil, listo;

// Setup
void setup() {
  orientation(LANDSCAPE);
  textSize(72);
  sensor = new KetaiSensor(this);
  initNetworkConnection();
  sensor.start();
  for (int i=0; i<200; i++) {
    xEstrellas[i]=random(width);
    yEstrellas[i]=random(height);
  }
  remoteAddress = null;
  remoteLocation = null;
  anchoTitulo=textWidth(titulo);
  anchoLaser=textWidth(laser);
  anchoReady=textWidth(ready);
  anchoNotReady=textWidth(notReady);
  anchoMisil=textWidth(misil);
  anchoIP=textWidth(myIPAddress);
}

// Draw
void draw() {
  background(0);
  for (int i=0; i<200; i++) {
    fill(255);
    ellipse(xEstrellas[i], yEstrellas[i], 10, 10);
  }
  //Botón misil
  if (disparoMisil) {
    fill(53, 103, 255);
    rect(width/18, height/6, (4.5*width)/18, (4*height)/6, 7);
  } else {
    fill(53, 103, 180);
    rect(width/18, height/6, (4.5*width)/18, (4*height)/6, 7);
  }
  //Boton de listo
  if (listo) {
    fill(127);
    rect((7*width)/18, height/6, (4.5*width)/18, (4*height)/6, 7);
    fill(255);
    text(ready, ((9.25*width)/18)-(anchoReady/2), (height/2)+18);
  } else {
    fill(127);
    rect((7*width)/18, height/6, (4.5*width)/18, (4*height)/6, 7);
    fill(255);
    text(notReady, ((9.25*width)/18)-(anchoNotReady/2), (height/2)+18);
  }
  //Boton laser
  if (disparoLaser) {
    fill(255, 33, 25);
    rect((13*width)/18, height/6, (4.5*width)/18, (4*height)/6, 7);
  } else {
    fill(159, 33, 25);
    rect((13*width)/18, height/6, (4.5*width)/18, (4*height)/6, 7);
  }
  //Fondo negro del titulo
  fill(0);
  rect(width/2-(anchoTitulo)/2, (height/12)-36, anchoTitulo, 72);
  // Dibujo de los textos
  fill(255);
  text(misil, ((3.25*width)/18)-(anchoMisil/2), (height/2)+18);
  text(laser, ((15.25*width)/18)-(anchoLaser/2), (height/2)+18);
  text(titulo, width/2-(anchoTitulo)/2, (height/12)+18);
  textAlign(CENTER);
  text(myIPAddress+"  Conected: "+(remoteLocation != null ? "True :)" : "False :("), width/2, height-20);
  textAlign(0);
  //Envio de datos
  println("> "+remoteLocation);
  if (remoteLocation != null) {
    //println(conectado);
    sendData();
  }
}
void mousePressed() {
  //Boton de listo
  if (mouseX > 7*width/18 && mouseX < 7*width/18+(4.5*width)/18 && mouseY > height/6 && mouseY < height/6+(4*height)/6 && listo==false) {
    listo = true;
  } else if (mouseX > 7*width/18 && mouseX < 7*width/18+(4.5*width)/18 && mouseY > height/6 && mouseY < height/6+(4*height)/6 && listo==true) {
    listo = false;
  }
  //Boton de misil y de laser
  if (mouseX > width/18 && mouseX < width/18+(4.5*width)/18 && mouseY > height/6 && mouseY < height/6+(4*height)/6) {
    disparoMisil = true;
  }
  if (mouseX > 13*width/18 && mouseX < 13*width/18+(4.5*width)/18 && mouseY > height/6 && mouseY < height/6+(4*height)/6) {
    disparoLaser = true;
  }
}

void mouseReleased() {
  disparoLaser = false;
  disparoMisil = false;
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
  myIPAddress = KetaiNet.getIP();
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/conection"))
  {
    remoteAddress = theOscMessage.get(0).stringValue(); // PC address is catched here
    remoteLocation = new NetAddress(remoteAddress, 12000);
    //println(remoteLocation);
  }
}

void sendData() {
  OscMessage myMessage = new OscMessage("sensores"); // Confirm the conection
  // 0 value
  myMessage.add("true");
  // 1st value
  if (disparoMisil) myMessage.add("true");
  else myMessage.add("false");
  // 2nd value
  if (listo) myMessage.add("true");
  else myMessage.add("false");
  // 3th value
  if (disparoLaser) myMessage.add("true");
  else myMessage.add("false");
  // 4th value
  myMessage.add(myAccelerometerX);
  // 5th value
  myMessage.add(myAccelerometerY);
  // 6th value
  myMessage.add(myAccelerometerZ);

  oscP5.send(myMessage, remoteLocation);
  //println("Sending data to PC: "+remoteLocation);
}

//Keep screen awake
void onCreate(Bundle bundle) {
  super.onCreate(bundle);
  getActivity().getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
}
