// Stage where every level must to run

void drawStage() {
  if (!gameOver) {
    if (!pause) {
      background(BLACK);
      if (frameCount%30 == 0) levelCounter--; // Counter
      if (!stageSound.isPlaying() && soundEnable) stageSound.play();

      // Draw the background
      if (currentLevel <= 3) { // level 1-3
        starsBackground.draw();
        fill(BLACK, 220);
        if (currentLevel == 3 && levelCounter > -5) {
          image(moonImage, 80, 80, levelCounter+20, levelCounter+20);
          ellipse(80, 80, levelCounter+20, levelCounter+20);
        } else if (currentLevel == 1 || currentLevel == 2) { // level 4-10
          image(moonImage, 80, 80, 128, 128);
          ellipse(80, 80, 128, 128);
        }
      } else {
        stageBackground.draw();
      }
      if (levelCounter < -5 && bigBoss != null) {
        bigBoss.draw();
      }

      if (debugInfo) debugInfo();

      // Draw
      localPlayer.drawPlayer();
      drawEnemies();

      // Support
      health.draw();
      shield.draw();

      playerInerface();

      // Level messages
      if (levelCounter > LEVEL_TIME-3) showMessage("Level "+currentLevel);
      else if (currentLevel%3==0 || currentLevel == 10)
      {
        if (levelCounter > -4 && levelCounter <= 0) showMessage("WARNING!!!\nA boss had came!!!", RED);
        else {
          if (bigBoss == null || bigBoss.getHealth() <= 0) {
            showMessage("Jackpot");
            if (levelCounter%17==0) {
              gameOver = true;
            }
          }
        }
      }
      if (levelCounter < -3 && bigBoss == null) gameOver = true;
    } else { // Show pause menu
      pauseMenu();
    }
    if (puerto.available() > 0) puerto.write(localPlayer.getScore()); // Send the score to arduino
  } else if (localPlayer.getLifes() > 0 || localPlayer.getHealth() > 0) { // change the level
    currentLevel++;
    if (currentLevel == 11) window = END;
    else window = NEXT_LEVEL;
  } else {
    window = GAME_OVER_SCREEN;
    restartStage();
    saveData();
  }
}

/////////////////////////// save the data //////////////////////////////////
void saveData() {
  String data = fireBase.getValue("Game/Profiles/"+playerName);

  String save = "", score = "";

  // Save
  for (int i = 0; i < data.length(); i++) {
    if (data.charAt(i) == ',') break;
    if (Character.isDigit(data.charAt(i))) save += data.charAt(i);
  }

  // Score
  for (int i = data.length()-1; i >= 0; i--) {
    if (data.charAt(i) == ',') break;
    if (Character.isDigit(data.charAt(i))) score += data.charAt(i);
  }

  if (Integer.parseInt(save) < currentLevel) fireBase.setValue("Game/Profiles/"+playerName+"/save", String.valueOf(currentLevel)); // save
  if (Integer.parseInt(score) < localPlayer.getScore()) fireBase.setValue("Game/Profiles/"+playerName+"/score", String.valueOf(localPlayer.getScore())); // highestScore
}

/////////////////////////// initeialize the stage //////////////////////////
void initStage() {
  window = STAGE;
  gameOver = false;
  if (menuSound.isPlaying()) menuSound.pause();
  levelCounter = LEVEL_TIME;

  // Background
  if (currentLevel >= 4 && currentLevel <= 6) {
    stageBackground = new CrazyBackground();
  } else if (currentLevel <= 9) {
    stageBackground = new OceanBackground();
  } else {
    stageBackground = new MadnessBackground();
  }

  for (int i = 0; i < MAX_METEORITES; i++) meteorites[i].revive();
  for (int i = 0; i < MAX_ENEMIES; i++) {
    double ran = random(0, 1);
    if (ran > 0.4) enemies[i] = new Medusa();
    else enemies[i] = new Ufo();
  }

  // bigBoss
  if (currentLevel == 3) bigBoss = new bigMoon();
  else if (currentLevel == 6) bigBoss = new bigSkull();
  else if (currentLevel == 9) bigBoss = new BigMedusa();
  else if (currentLevel == 10) bigBoss = new BigBrain();
  else bigBoss = null;
  System.gc();
}

////////////////////// Level transition /////////////////////////////////
void nextLevel() {
  initStage();
}

/////////////////////////// Draw Enemies /////////////////////////////////////
void drawEnemies() {

  // Count
  if (frameCount%160 == 0) {
    // Metoeorites respawn
    for (int i = 0; i < MAX_METEORITES; i++) {
      if (!meteorites[i].isAlive() && levelCounter > 0) meteorites[i].revive();
    }
    // Enemies respawn
    for (int i = 0; i < MAX_ENEMIES; i++) {
      if (enemies[i].getHealth() <= 0 && levelCounter > 0) enemies[i].respawn();
    }
  }
  // Meteorites draw
  for (int i = 0; i < MAX_METEORITES; i++) { // Draw only alive meteorites
    if (meteorites[i].isAlive()) {
      meteorites[i].drawEnemy();
    }
  }
  // Enemies draw
  for (int i = 0; i < MAX_ENEMIES; i++) {
    if (enemies[i].getHealth() > 0) enemies[i].draw();
  }
}

///////////////////////// Restart /////////////////////////////////////
void restartStage() {
  localPlayer.revive();
  localPlayer.setLifes(3);

  for (int i = 0; i < MAX_METEORITES; i++) meteorites[i].setY(-meteorites[i].getSize());
}

///////////// For impertants messages ///////////////////////////////////
void showMessage(String message) {
  textFont(fontSpecial);
  textAlign(CENTER);
  fill(WHITE, 100);
  text(message, width/2, height/2);
}

void showMessage(String message, color col) {
  textFont(fontSpecial);
  textAlign(CENTER);
  fill(col, 250);
  text(message, width/2, height/2);
}
