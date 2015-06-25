/*
-This project uses both link and my ant asset to make a game of avoidance using
the light sensors and the arduino. You are to light your path using the arduino box
using some sort of light such as a flashlight to brighten the screen so you can
see where Link is located.

-The objective of the game is to collect all three coins. 

-If I had more time to work on this project, I would have wanted to just make the game
more overall aesthetically pleasing. Also, I wanted to add some sort of background such
as a cave for the game and other obstacles as well as the ants. I hope you enjoy!

Video Link of game in progress: https://www.youtube.com/watch?v=H-CmstpwVgU&feature=youtu.be
Video Link of wiring: https://www.youtube.com/watch?v=8GyZXZFjJ-c&feature=youtu.be
*/

import cc.arduino.*;
import processing.serial.*;

Hero link;
Enemy[] bugs;
Environment envi;
Sound sound;
Arduino arduino;
int gamestage; //used for title screen, main game, and death screen, win screen
int bugcount; //change this for difficulty
int[] LED, SENSOR;
boolean stageshift;

void setup() {
  size(1300, 700);
  noSmooth();
  bugcount = 15;
  gamestage = 0;
  stageshift = false;
  link = new Hero(1220, 600);
  envi = new Environment();
  sound = new Sound();
  bugs = new Enemy[bugcount];
  for (int i = 0; i < bugcount; i++)
    bugs[i] = new Enemy(random(10, 1100), random(10, 550));
  
  //Arduino
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  LED = new int[3];
  SENSOR = new int[6];
  LED[0] = 12;
  LED[1] = 8;
  LED[2] = 7;
  for (int i = 0; i < 6; i++)
   SENSOR[i] = 0;
  arduino.pinMode(LED[0], Arduino.OUTPUT);
  arduino.pinMode(LED[1], Arduino.OUTPUT);
  arduino.pinMode(LED[2], Arduino.OUTPUT);
}

void draw() {
  //Title Screen
  if (gamestage == 0) {
    envi.titleScreen();
    if (mousePressed) {
      if (mouseX >= 572 && mouseY >= 330 && mouseX <= 676 && mouseY <= 352) {
        gamestage = 1;
        stageshift = true;
      }
    }
  }
  
  //Main Game
  if (gamestage == 1) {
    if (stageshift == true) {
      sound.background();
      stageshift = false;
    }
    for(int i = 0; i < 6; i++)
      SENSOR[i] = arduino.analogRead(i);
    envi.gameBackground();
    if (envi.coinsCollected == 1)
      arduino.digitalWrite(LED[0], 1);
    else if (envi.coinsCollected == 2)
      arduino.digitalWrite(LED[1], 1);
    else if (envi.coinsCollected == 3) {
      arduino.digitalWrite(LED[2], 1);
      sound.noSound();
      stageshift = true;
      gamestage = 3;
    }
    else {
      lightsOff();
    }
    envi.coins(link.x + 30, link.y + 40);
    sound.coinSound();
    
    //Link Movement
    link.checkCollison(bugs, bugcount);
    if (frameCount % 6 == 0) {
      if (keyPressed) {
        link.walk(key,keyCode);
      }
      else
        link.noMove();
    }
    if (!link.dead)
      link.drawChar();
    else {
      sound.noSound();
      stageshift = true;
      gamestage = 2;
    }
    
    //Bugs
    if (frameCount % 6 == 0) {
      for (int i = 0; i < bugcount; i++) {
        if (bugs[i].travel_dist >= bugs[i].final_travel_dist) {
          bugs[i].directionChange(int(random(0,4)));
          bugs[i].travel_dist = 0;
        }
        else {
          bugs[i].movement();
          bugs[i].travel_dist++;
        }
      }
    }
    for (int i = 0; i < bugcount; i++)
      bugs[i].drawBug();
    
    envi.darkness(SENSOR);
    envi.coinText();
  }
  
  //Death Screen
  if (gamestage == 2) {
    if (stageshift == true) {
      sound.deathSound();
      stageshift = false;
    }
    envi.gameOver();
    lightsOff();
    restartGame();
  }
  
  //Win Screen
  if (gamestage == 3) {
    if (stageshift == true) {
      sound.winSound();
      stageshift = false;
    }
    envi.winScreen();
    lightsOff();
    restartGame();
    }
  }
  
  void restartGame() {
    if (mousePressed) {
      if (mouseX >= 586 && mouseY >= 331 && mouseX <= 664 && mouseY <= 350) {
        link.reset(1220, 600);
        envi.reset();
        sound.reset();
        for (int i = 0; i < bugcount; i++)
          bugs[i] = new Enemy(random(10, 1100), random(10, 550));
        stageshift = true;
        gamestage = 1;
      }
    }
  }
  
  void lightsOff() {
    arduino.digitalWrite(LED[0], 0);
    arduino.digitalWrite(LED[1], 0);
    arduino.digitalWrite(LED[2], 0);
  }

