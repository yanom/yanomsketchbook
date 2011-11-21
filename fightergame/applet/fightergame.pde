//all globals must be declared out here in globalspace.
final int windowSize = 500;
final int difficulty = 1;
final boolean invincible = false;
float globalnoise = .001;

Layer layer1 = new Layer(.1,255,0,0,10000);
Layer layer2 = new Layer(1,0,255,0,1000);
Layer layer3 = new Layer(10,0,100,255,100);


PFont f;  

boolean[] keys = new boolean[526];
boolean gameRunning = false;
boolean paused = false;

void setup () {
  size(windowSize,windowSize);
  frameRate(30);
  f = loadFont("AgencyFB-Reg-48.vlw");
}
void keyPressed() { 
  keys[keyCode] = true;
}
void keyReleased() { 
  keys[keyCode] = false;
}
boolean checkKey(String k) {
  for(int i = 0; i < keys.length; i++) {
    if(KeyEvent.getKeyText(i).toLowerCase().equals(k.toLowerCase())) {
      return keys[i];
    }}
  return false; 
}
void draw() {
  background(0);
    
  if(gameRunning) {
    if (paused) {
      pauseCycle();
    } else {
      runningCycle();
    }
  } else {
    offCycle();
  }
}
void offCycle() {
  layer1.frozenCycle();
  layer2.frozenCycle();
  layer3.frozenCycle();
  fill(255);
  textFont(f,120);
  text("f", 50,100);
  text("A", 150,100);
  text("d", 250,100);
  text("e", 350,100);
  textFont(f,48);
}

void pauseCycle() {
  layer1.frozenCycle();
  layer2.frozenCycle();
  layer3.frozenCycle();
  fill(255);
  textFont(f,48);
  text("Paused", 100,100);
  textFont(f,26);
  text("Press U to unpause", 300,400);
  checkForPauseInput();
}

void runningCycle() {
  println(millis());
  layer1.activeCycle();
  layer2.activeCycle();
  layer3.activeCycle();
  checkForPauseInput();
}

void checkForPauseInput() {
  if (checkKey("P")) {
    paused = true;
  }
  if (checkKey("U")) {
    paused = false;
  }
}



  
