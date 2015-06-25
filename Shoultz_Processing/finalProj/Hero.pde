class Hero {
  PImage spritesheet;
  PImage[] north, south, east, west, current;
  int x, y, frame, speed;
  boolean dead;
  
  public Hero(int initx, int inity) {
    this.x = initx;
    this.y = inity;
    this.frame = 1;
    this.speed = 12;
    this.dead = false;
    this.north = new PImage[4];
    this.south = new PImage[4];
    this.east = new PImage[4];
    this.west = new PImage[4];
    this.current = this.west;
    loadSheet("link.png");
  }
  
  void loadSheet(String image) {
    spritesheet = loadImage(image);
    //Northwalk
    this.north[0] = spritesheet.get(0, 0, 24, 32); //right foot
    this.north[1] = spritesheet.get(24, 0, 24, 32); //middle
    this.north[2] = spritesheet.get(48, 0, 24, 32); //left foot
    this.north[3] = spritesheet.get(24, 0, 24, 32); //middle
    //Southwalk
    this.south[0] = spritesheet.get(0, 64, 24, 32); //right foot
    this.south[1] = spritesheet.get(24, 64, 24, 32); //middle
    this.south[2] = spritesheet.get(48, 64, 24, 32); //left foot
    this.south[3] = spritesheet.get(24, 64, 24, 32); //middle
    //Eastwalk
    this.east[0] = spritesheet.get(0, 32, 24, 32); //right foot
    this.east[1] = spritesheet.get(24, 32, 24, 32); //middle
    this.east[2] = spritesheet.get(48, 32, 24, 32); //left foot
    this.east[3] = spritesheet.get(24, 32, 24, 32); //middle
    //Westwalk
    this.west[0] = spritesheet.get(0, 96, 24, 32); //right foot
    this.west[1] = spritesheet.get(24, 96, 24, 32); //middle
    this.west[2] = spritesheet.get(48, 96, 24, 32); //left foot
    this.west[3] = spritesheet.get(24, 96, 24, 32); //middle
  }
  
  void walk(int k, int kc) {
    if (k == CODED) {
      if (kc == UP) {
        this.current = this.north;
        if (this.y >= 0)
          this.y = this.y - this.speed;
      }
      if (kc == RIGHT) {
        this.current = this.east;
        if (this.x <= 1236)
          this.x = this.x + this.speed;
      }
      if (kc == DOWN && y <= 700) {
        this.current = this.south;
        if (this.y <= 610)
          this.y = this.y + this.speed;
      }
      if (kc == LEFT) {
        this.current = this.west;
        if (this.x >= 0)
          this.x = this.x - this.speed;
      }
      this.frame = (this.frame + 1) % 4;
    }
  }
  
  void noMove() {
    this.frame = 1;
  }
  
  void checkCollison(Enemy[] en, int count) {
    for (int i = 0; i < count; i++) {
      if (en[i].current == en[i].north || en[i].current == en[i].south) {
        if (this.x >= en[i].x && this.y >= en[i].y && this.x <= en[i].x+30 
                                                   && this.y <= en[i].y+47) 
          this.dead = true; //top left
        if (this.x+60 >= en[i].x && this.y >= en[i].y && this.x+60 <= en[i].x+30 
                                                   && this.y <= en[i].y+47) 
          this.dead = true; //top right
        if (this.x >= en[i].x && this.y+80 >= en[i].y && this.x <= en[i].x+30 
                                                   && this.y+80 <= en[i].y+47) 
          this.dead = true; //bottom left
        if (this.x+60 >= en[i].x && this.y+80 >= en[i].y && this.x+60 <= en[i].x+30 
                                                   && this.y+80 <= en[i].y+47) 
          this.dead = true; //bottom right
        if (this.x+30 >= en[i].x && this.y >= en[i].y && this.x+30 <= en[i].x+30 
                                                   && this.y <= en[i].y+47) 
          this.dead = true; //top middle
        if (this.x >= en[i].x && this.y+40 >= en[i].y && this.x <= en[i].x+30 
                                                   && this.y+40 <= en[i].y+47) 
          this.dead = true; //left middle
        if (this.x+30 >= en[i].x && this.y+80 >= en[i].y && this.x+30 <= en[i].x+30 
                                                   && this.y+80 <= en[i].y+47) 
          this.dead = true; //bottom middle
        if (this.x+60 >= en[i].x && this.y+40 >= en[i].y && this.x+60 <= en[i].x+30 
                                                   && this.y+40 <= en[i].y+47) 
          this.dead = true; //right middle
      }
      if (en[i].current == en[i].east || en[i].current == en[i].west) {
        if (this.x >= en[i].x && this.y >= en[i].y && this.x <= en[i].x+47 
                                                   && this.y <= en[i].y+30) 
          this.dead = true; //top left
        if (this.x+60 >= en[i].x && this.y >= en[i].y && this.x+60 <= en[i].x+47 
                                                   && this.y <= en[i].y+30) 
          this.dead = true; //top right
        if (this.x >= en[i].x && this.y+80 >= en[i].y && this.x <= en[i].x+47 
                                                   && this.y+80 <= en[i].y+30) 
          this.dead = true; //bottom left
        if (this.x+60 >= en[i].x && this.y+80 >= en[i].y && this.x+60 <= en[i].x+47 
                                                   && this.y+80 <= en[i].y+30) 
          this.dead = true; //bottom right
        if (this.x+30 >= en[i].x && this.y >= en[i].y && this.x+30 <= en[i].x+47 
                                                   && this.y <= en[i].y+30) 
          this.dead = true; //top middle
        if (this.x >= en[i].x && this.y+40 >= en[i].y && this.x <= en[i].x+47 
                                                   && this.y+40 <= en[i].y+30) 
          this.dead = true; //left middle
        if (this.x+30 >= en[i].x && this.y+80 >= en[i].y && this.x+30 <= en[i].x+47 
                                                   && this.y+80 <= en[i].y+30) 
          this.dead = true; //bottom middle
        if (this.x+60 >= en[i].x && this.y+40 >= en[i].y && this.x+60 <= en[i].x+47 
                                                   && this.y+40 <= en[i].y+30) 
          this.dead = true; //right middle
      }
    }
  }
  
  void drawChar() {
      image(this.current[frame], this.x, this.y, 60, 80);
  }
  
  void reset(int initx, int inity) {
    this.x = initx;
    this.y = inity;
    this.dead = false;
    this.current = this.west;
  }
}
