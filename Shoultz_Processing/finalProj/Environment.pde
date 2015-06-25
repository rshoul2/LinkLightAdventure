class Environment {
  PImage itemspritesheet;
  PImage[] coins;
  boolean[] ifTaken;
  int[] coinsX, coinsY;
  int coinsCollected, coinSound;
  PFont font1, font2;
  
  public Environment() {
    this.coins = new PImage[3];
    this.coinsX = new int[3];
    this.coinsY = new int[3];
    this.ifTaken = new boolean[3]; 
    this.font1 = loadFont("AgencyFB-Bold-25.vlw");
    this.font2 = loadFont("AngsanaNew-48.vlw");
    textFont(font1);
    textSize(25);
    for (int i = 0; i < 3; i++)
     ifTaken[i] = false;
    loadCoins("coins.png");
    coinsCollected = 0;
    coinSound = 0;
  }
  
  //Game background
  void gameBackground() {
    background(175,167,167);
  }
  
  //Title Screen
  void titleScreen() {
    background(0);
    textFont(font2);
    textSize(80);
    textAlign(CENTER);
    fill(0, 179, 12);
    text("Link's Light Quest", 640, 250);
    textSize(35);
    text("Start Game", 625, 350);
    fill(255);
    textSize(30);
    textAlign(LEFT);
    text("-Use the lightboard to light your path to the coins!", 20, 600);
    text("-Avoid the ants though and you'll make it out alive.", 20, 625);
  }
  
  //Game over screen
  void gameOver() {
    background(0);
    textFont(font2);
    textSize(100);
    textAlign(CENTER);
    fill(255, 0, 0);
    text("GAME OVER!", 640, 250);
    textSize(35);
    text("Restart?", 625, 350);
  }
  
  void winScreen() {
    background(0);
    textFont(font2);
    textSize(100);
    textAlign(CENTER);
    fill(0, 179, 12);
    text("YOU WIN!", 640, 250);
    textSize(35);
    text("Restart?", 625, 350);
  }
  
  //in Game Text
  void coinText() {
    fill(255, 0, 0);
    textAlign(LEFT);
    textSize(30);
    text("Coins: ", 15, 25);
    text(this.coinsCollected, 75, 25);
  }
  
  //Light Sensor handling
  void darkness(int[] lights) {
    fill(0);
    if (lights[0] < 900)
      rect(866, 350, 434, 350); //bottom right
    if (lights[1] < 900)
      rect(433, 350, 434, 350); //bottom middle
    if (lights[2] < 900)
      rect(0, 350, 434, 350); //bottom left
    if (lights[3] < 900)
      rect(866, 0, 434, 350); //top right
    if (lights[4] < 900)
      rect(433, 0, 434, 350); //top middle
    if (lights[5] < 900)
      rect(0, 0, 434, 350); //top left
  }
  
  //Coins
  void loadCoins(String image) {
    itemspritesheet = loadImage(image);
    for (int i = 0; i < 3; i++) {
     this.coins[i] = itemspritesheet.get(46, 32, 12, 32);
     this.coinsX[i] = int(random(2,122))*10;
     this.coinsY[i] = int(random(2, 62))*10;
    }
  }
  
  void coinCollection(int x, int y) {
    for (int i = 0; i < 3; i++) {
      if (x >= this.coinsX[i] && x <= this.coinsX[i] + 18
                              && y >= this.coinsY[i]
                              && y <= this.coinsY[i] + 48)
        ifTaken[i] = true;
    }
  }
  
  void checkCoins() {
    if (ifTaken[0] || ifTaken[1] || ifTaken[2])
      coinsCollected = 1;
    if ((ifTaken[0] && ifTaken[1]) || (ifTaken[0] && ifTaken[2])
                                   || (ifTaken[1] && ifTaken[2]))
      coinsCollected = 2;
    if (ifTaken[0] && ifTaken[1] && ifTaken[2])
      coinsCollected = 3;
  }
  
  void drawCoins() {
    for (int i = 0; i < 3; i++) {
      if (!ifTaken[i])
        image(this.coins[i], this.coinsX[i], this.coinsY[i], 12, 32);
    } 
  }
  
  void coins(int x, int y) {
    this.checkCoins();
    this.coinCollection(x, y);
    this.drawCoins();
  }
  
  void reset() {
    this.coinsCollected = 0;
    for (int i = 0; i < 3; i++) {
     this.coinsX[i] = int(random(2,122))*10;
     this.coinsY[i] = int(random(2, 62))*10;
    }
    for (int i = 0; i < 3; i++)
     ifTaken[i] = false;
  }
}
