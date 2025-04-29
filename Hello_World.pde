////////////////////////////////////////////////////////////////////////////////////sounds
  import processing.sound.*;
//dog bark when space pressed
  SoundFile bark2;
//Background music
  SoundFile background;
/////////////////////////////////////////////////////////////////////////////////global variables
//background changes with state
  color backgroundColor;
//animations
  Animation startScreenAnimation;
  Animation sheepHeardingAnimation;
  
//images
PImage [] startScreenImages= new PImage [4];
PImage [] sheepHeardingImages= new PImage [1];
//Class variables
  Dog d1;
  
  Sheep s1;
 // Sheep s2;
 // Sheep s3;
  
  
  Stick st1;
  Stick st2;
  Stick st3;
  Stick st4;
  Stick st5;
  Stick st6;
  Stick st7;
  Stick st8;
  
  Score sc1;
  //enemy lists
  ArrayList<Sheep> sheepList;
  ArrayList<Stick> stickList;
  ArrayList<Ball> ballList;
  Ball b1;
  Ball b2;
  Ball b3;
//state variable
  int state;


//Obstacles
  //pasture
    Obstacle o1;
    Obstacle o2;

/////////////////////////////////////////////////////////////////////////////////millis timer var
  int startTime;
  int currentTime;
  int interval=2000;
  //sheep direction change boolean
  boolean scared;

void setup(){
  size(1600,1200);
  //initial background color and state
  backgroundColor=color(#41901A);
  state=0;
  rectMode(CENTER);
   startTime=millis();
  
///////////////////////////////////////////////////////////////////////////////////////////initialize all variables
  d1 = new Dog(width/2,height/2,50,50);
  //enemy list
 sheepList =new ArrayList<Sheep>();
 stickList = new ArrayList<Stick>();
 ballList = new ArrayList<Ball>();
 
  s1 = new Sheep(width/2,2*height/3);
 // s2 = new Sheep(width/3,2*height/5);
 // s3 = new Sheep(width/4,height/3);
  sheepList.add(s1);
 // sheepList.add(s2);
 // sheepList.add(s3);
  
  st1 =new Stick();
  st2 =new Stick();
  st3 =new Stick();
  st4 =new Stick();
  st5 =new Stick();
  st6 =new Stick();
  st7 =new Stick();
  st8 =new Stick();
  
  stickList.add(st1);
  stickList.add(st2);
  stickList.add(st3);
  stickList.add(st4);
  stickList.add(st5);
  stickList.add(st6);
  stickList.add(st7);
  stickList.add(st8);
  
  b1 = new Ball(width/3);
  b2 = new Ball(width/4);
  b3 = new Ball(3*width/5);
  ballList.add(b1);
  ballList.add(b2);
  ballList.add(b3);
  
  o1 = new Obstacle(width/10,height/5,width/50,2*height/5);
  o2 = new Obstacle(width/10,4*height/5,width/50,2*height/5);
  
  sc1=new Score();
  
  //barking and background music noises
  bark2 = new SoundFile(this, "bark2.wav");
  background = new SoundFile(this, "background.wav");
  
  //background images
    for (int i=0; i<startScreenImages.length;i++){
   startScreenImages[i]= loadImage("start"+i+".png"); 
  }
   
 //   for (int i=0; i<startScreenImages.length;i++){
  // sheepHeardingImages[i]= loadImage("sheepHearding"+i+".png"); 
//  }
  //animation
  startScreenAnimation =new Animation(startScreenImages, 0.1,2.0);
 // sheepHeardingAnimation =new Animation(startScreenImages, 0.1,2.0);
 
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////draw
void draw(){
  background(backgroundColor);
  //change states
  levelHandler();
  fill(0);

 currentTime=millis();
}
void levelHandler(){
//////////////////////////////////////////////////////////////////////////////////////////////////my finite state machine
switch (state){
  //first level (sheep herding grass background)
  case 0 :
  backgroundColor =color(#15A21B);
  startScreenAnimation.display(width/2,height/2);
  startScreenAnimation.isAnimating=true;
  break;
  case 1 :
  backgroundColor= color(#5ECE3C);
   //sheep hearding level
//  sheepHeardingAnimation.display(width/2,height/2);
  fill(255);
    //draw and move dog
  d1.render();
  d1.move(); 
  d1.wallCollide();
  //draw sheep, detect window collisions and figure out what direction the sheep is going
  for(Sheep aSheep : sheepList){
  aSheep.move();
  aSheep.render();
  aSheep.sheepWindowCollision();
  aSheep.runAway();
  aSheep.inPen();
  aSheep.countSheep();
  if(aSheep.count == 3){
     state=1;
   }
  println(aSheep.count);
  }
  
 //fence
 //this will change in shape later as a pen to herd sheep into
 fill(#BC8F4C);
  o1.render();
  o1.playerCollide(d1);
  o1.sheepCollide(s1);
 // o1.sheepCollide(s2);
  //o1.sheepCollide(s3);
  o2.render();
  o2.playerCollide(d1);
  o2.sheepCollide(s1);
 // o2.sheepCollide(s2);
  //o2.sheepCollide(s3);
    break;
      
 //level 2( stick picking dirt ground)
  case 2:
    //draw and move dog
  d1.render();
  d1.move(); 
  d1.wallCollide();
  //draw color and collide with stick
    backgroundColor= color(#765324);
    for(Stick aStick : stickList){
     aStick.render(); 
     aStick.playerCollide(d1); 
   if(aStick.count == 8){
     state=2;
   }
   }
    
    break;
//level 3(ball catching grass background)
  case 3:
  
  //draw and move dog
  d1.render();
  d1.move(); 
  d1.wallCollide();
  //draw color move and collide with ball, also detect when ball hits walls
  backgroundColor =color(#1FB42A);
for(Ball aBall : ballList){
  aBall.render();
  aBall.move();
  aBall.wallDetect();
  aBall.playerCollide(d1);
}
  break;
  case 4:
  //winscreen
  sc1.playerWinScreen();
  break;
  }
    //background music repeat
    if (background.isPlaying() == false){
  background.play();        
}
  
  
  
}

void keyPressed(){
 ///////////////////////////change levels
  //lvl 1
if(key=='r' && state == 4){
    state=0;
    sc1.resetScore();
  }
  //lvl 2
if(key==' '&& state == 0){
    state=1;
  }
 //lvl 3
//if(key =='3'){
//  state =2;
//}
 //lvl 4
if(key =='4'){
  state =3;
}
 //lvl 5
if(key =='5'){
  state =4;
}
/////////////////////////////////////////////////////////////wasd
if(key == 'a'){
    d1.isMovingLeft =true;
  }
if(key == 'd'){
    d1.isMovingRight =true;
  }
if(key == 'w'){
    d1.isMovingUp =true;
  }
if(key == 's'){
    d1.isMovingDown =true;
} 
if(keyCode == LEFT){
    d1.isMovingLeft =true;
  }
if(keyCode == RIGHT){
    d1.isMovingRight =true;
  }
if(keyCode == UP){
    d1.isMovingUp =true;
  }
if(keyCode == DOWN){
    d1.isMovingDown =true;
} 
//sheep redirect
  if(key ==' '){
   scared=true;
  }
  
  //bark when spacebar is pressed
  if(key == ' '){
    bark2.play();
  }
}

void keyReleased(){
  //wasd
    if(key == 'a'){
    d1.isMovingLeft =false;
  }
    if(key == 'd'){
    d1.isMovingRight =false;
  } 
      if(key == 'w'){
    d1.isMovingUp =false;
  }
    if(key == 's'){
    d1.isMovingDown =false;
  } 
  if(keyCode == LEFT){
    d1.isMovingLeft =false;
  }
if(keyCode == RIGHT){
    d1.isMovingRight =false;
  }
if(keyCode == UP){
    d1.isMovingUp =false;
  }
if(keyCode == DOWN){
    d1.isMovingDown =false;
} 
//sheep redirect release
  if(key ==' '){
   scared=false;
  }
}
