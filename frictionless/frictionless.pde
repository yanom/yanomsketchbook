/* GPL licenced */
//[CONFIG]
final int gravMag = 1600;
final int windowX = 1024;
final int windowY = 768;
final int goldRectSize = 20;
final int meteorSize = 30;
final float meteorTopSpeed = 0.5;
//[/CONFIG]

PlayerRect player;
GravRect sun;

ArrayList meteors;
Rectangle goldrect = new Rectangle(new PVector(20,20),goldRectSize,goldRectSize,255,255,0);


PFont f;
boolean gamerunning = false;

void setup() { 
  size(1024,768);
  frameRate(120);
  set_up_game();
  f = loadFont("TlwgTypist-48.vlw");
}

void set_up_game() {
  sun = new GravRect(new PVector(windowX/2,windowY/2),35,35,255,0,0,gravMag);
  player = new PlayerRect(new PVector(40, 94), 3, 3, 0, 0, 255);
  player.score = 0;
  placeGoldRect();
  meteors = new ArrayList();
}

void activeCycle() {
  player.update();
  player.render();
  player.moveself();
  goldrect.render();
  
  
  sun.render();
  sun.affect(player);
  if(rectCollision(sun,player)) gamerunning=false;
  
  for (int iii=0; iii<=(meteors.size()-1); iii++) {
    MotileRect thismeteor = (MotileRect) meteors.get(iii);
    thismeteor.render();
    thismeteor.update();
    sun.affect(thismeteor);
    if(thismeteor.pos.x < 0 || thismeteor.pos.x+thismeteor.w > windowX )  meteors.remove(thismeteor);
    if(thismeteor.pos.y < 0 || thismeteor.pos.y+thismeteor.h > windowY )  meteors.remove(thismeteor);
    if(rectCollision(sun,thismeteor))                                     meteors.remove(thismeteor);
    
    if(rectCollision(player,thismeteor)) gamerunning=false;
    
  }
  
  
  if(player.pos.x < 0 || player.pos.x+player.w > windowX ) /*player.speed.x = player.speed.x*-1;*/ gamerunning=false;
  if(player.pos.y < 0 || player.pos.y+player.h > windowY ) /*player.speed.y = player.speed.y*-1;*/ gamerunning=false;
  if(rectCollision(player,goldrect)) {
    player.score++;
    placeGoldRect();
    for(int iii=0; iii<=player.score;iii++) {
      fireMeteor();
    }
  }
  textFont(f,30);
  fill(255);
  String scorestr = "Score: " + player.score;
  text(scorestr,0,750);
}

void titleScreen() {
  textFont(f,48);
  text("Frictionleß",0,40);
  text("Press ENTER to start", 200,200);
  if(checkKey("Enter")) {
    set_up_game();
    gamerunning = true;
  }
}


void draw() {
  background(150);
  if(gamerunning)  { activeCycle(); } else { titleScreen(); } //one-line if-else with brackets - like a boss.
}
