class Enemy {
  PImage[] north, south, east, west, current;
  int frame, travel_dist, final_travel_dist;
  float x, y, speed;
  boolean dead;
  
  public Enemy(float initx, float inity) {
    this.x = initx;
    this.y = inity;
    this.speed = 5.0;
    this.frame = 1;
    this.travel_dist = 0;
    this.final_travel_dist = int(random(6, 20));
    this.north = new PImage[5];
    this.south = new PImage[5];
    this.east = new PImage[5];
    this.west = new PImage[5];
    this.current = new PImage[5];
    directionChange(int(random(0, 4)));
    loadBugs();
  }
  
  void loadBugs() {
    this.north[0] = loadImage("antL_30N.png"); //left
    this.north[1] = loadImage("antM_30N.png"); //middle
    this.north[2] = loadImage("antR_30N.png"); //right
    this.north[3] = loadImage("antM_30N.png"); //middle

    this.south[0] = loadImage("antL_30S.png"); //left
    this.south[1] = loadImage("antM_30S.png"); //middle
    this.south[2] = loadImage("antR_30S.png"); //right
    this.south[3] = loadImage("antM_30S.png"); //middle

    this.east[0] = loadImage("antL_30E.png"); //left
    this.east[1] = loadImage("antM_30E.png"); //middle
    this.east[2] = loadImage("antR_30E.png"); //right
    this.east[3] = loadImage("antM_30E.png"); //middle

    this.west[0] = loadImage("antL_30W.png"); //left
    this.west[1] = loadImage("antM_30W.png"); //middle
    this.west[2] = loadImage("antR_30W.png"); //right
    this.west[3] = loadImage("antM_30W.png"); //middle
  }
  
  void directionChange(int direction) {
    if (direction == 0)
      this.current = this.north;
    if (direction == 1)
      this.current = this.south;
    if (direction == 2)
      this.current = this.east;
    if (direction == 3)
      this.current = this.west;
    this.frame = 1;
  }
  
  void drawBug() {
    image(this.current[frame], this.x, this.y);
  }
  
  void movement() {
    if (this.current == this.north) {
      if (this.y < -47)
        this.y = 647;
      this.y = this.y - this.speed;
    }
    if (this.current == this.south) {
      if (this.y > 647)
        this.y = -47;
      this.y = this.y + this.speed;
    } 
    if (this.current == this.east) {
      if (this.x > 1347)
        this.x = -47;
      this.x = this.x + this.speed;
    }
    if (this.current == this.west) {
      if (this.x < -47)
        this.x = 1347;
      this.x = this.x - this.speed;
    }
    frame = (frame+1) % 4;
  }
}
