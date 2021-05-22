#include <TimerOne.h>
#include <Wire.h>
#include <MultiFuncShield.h>

int button1 = A1;
int button2 = A2;
int button3 = A3;

int score; // Player socre
int oldScore;
int command;

void setup() {
  score = 0;
  oldScore = 0;
  command = -1;

  Timer1.initialize();
  MFS.initialize(&Timer1);
  Serial.begin(9600);

  pinMode(button1, INPUT);
  pinMode(button2, INPUT);
  pinMode(button3, INPUT);
}
void loop() {

  if (digitalRead(button1) == LOW) command = 1;
  else if (digitalRead(button2) == LOW) command = 2;
  else if (digitalRead(button3) == LOW) command = 3;
  else command = 0;

  if (Serial.available()) {
    score = Serial.read();
    if(oldScore != score){
        oldScore = score;
        MFS.beep(5);
      }
  }
  MFS.write(score);
  delay(100);
  if (command != 0) Serial.write(command);
}
