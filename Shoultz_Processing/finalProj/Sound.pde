import oscP5.*;
import netP5.*;

class Sound {
  OscP5 oscP5;
  NetAddress location;
  OscMessage message;
  boolean[] coinsounds;
  
  public Sound() {
    oscP5 = new OscP5(this, 12000);
    location = new NetAddress("127.0.0.1", 12000);
    coinsounds = new boolean[3];
    for (int i = 0; i < 3; i++)
      coinsounds[i] = false;
  }
  
  void coinSound() {
    for (int i = 0; i < 3; i++) {
      message = new OscMessage("/x");
      if(envi.ifTaken[i] == true && coinsounds[i] == false) {
        message.add(2);
        oscP5.send(message, location);
        message.clear();
        coinsounds[i] = true;
      }
      else {
        message.add(0);
        oscP5.send(message, location);
        message.clear();
      }
    }
  }
  
  void background() {
    message = new OscMessage("/x");
    message.add(1);
    oscP5.send(message, location);
    message.clear();
  }
  
  void deathSound() {
    message = new OscMessage("/x");
    message.add(4);
    oscP5.send(message, location);
    message.clear();
  }
  
  void noSound() {
    message = new OscMessage("/x");
    message.add(3);
    oscP5.send(message, location);
    message.clear();
  }
  
  void winSound() {
    message = new OscMessage("/x");
    message.add(5);
    oscP5.send(message, location);
    message.clear();
  }
  
  void reset() {
    for (int i = 0; i < 3; i++)
      coinsounds[i] = false;
  }
}
