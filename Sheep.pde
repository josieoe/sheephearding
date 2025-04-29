class Sheep  {
  
  //variables
  int x;
  int y;
  
  int w;
  int h;
  
  int xSpeed;
  int ySpeed;
  
    //hitbox 
  int left;
  int right;
  int top;
  int bottom;
  
//count variable
int count;
  
//direction booleans
int d;
int scary;
//disapear when in pen
boolean isRendered=true;
  
  //constructor
  Sheep(int startingX, int startingY){
    x=startingX;
    y=startingY;
    
    xSpeed=2;
    ySpeed=2;
    
    w=40;
    h=30;
  }
  
  //functions
  //draws sheep
  void render(){  
    rectMode(CENTER);
if(isRendered==true){
  fill(255);
    rect(x,y,w,h);    
}
  }
  //moves sheep
void move(){
   //change sheep direction
changeDirection();
 //changes position
 x+=xSpeed;
 y+=ySpeed;

  //hitbox
    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;
}
//state machine for directions
void changeDirection(){
 
if(currentTime-startTime>=interval && scared == false){ 
  d=int(random(4));
  switch(d){
    case 0://right
    xSpeed =2;
    ySpeed =0;
    break;
    case 1://left
    xSpeed =-2;
    ySpeed =0;
    break;
    case 2://down
    xSpeed =0;
    ySpeed =2;
    break;
    case 3://up
    xSpeed =0;
    ySpeed =-2;  
    break;
}
startTime=millis();
}
}
//state machine for running away, mostly done, dont know why up and down dont work
void runAway(){
if(scared==true){ 
//asked chat gpt what was wrong with the run away and scary functions. Determined that using "else if" was the issue.
  //check direction to move
  if(abs(d1.x-x)>abs(d1.y-y)){
  if(d1.x<x){
    scary=0;//right
  }
  else{
    scary=1;//left
  }
  }
  else{
    if(d1.y<y){
    scary=2;//down
  }
  else{
    scary=3;//up
  }
}
}
  switch(scary){
    case 0://right
    xSpeed =2;
    ySpeed =0;
    break;
    case 1://left
    xSpeed =-2;
    ySpeed =0;
    break;
    case 2://down
    xSpeed =0;
    ySpeed =2;
    break;
    case 3://up
    xSpeed =0;
    ySpeed =-2;  
    break;
}
}
//checks if sheep collides with window
void sheepWindowCollision(){
 // boolean hit =false;
if (bottom>=height){
ySpeed*=+2;
y=height-h/2;
 //   hit=true;
  }
if (top<=0){
ySpeed*=-2;
y=h/2;
 //  hit=true;
}
if (left<=0){
xSpeed*=+2;
x=width-w/2;
  // hit=true;
}
if (right>=width){
xSpeed*=-2;
x=w/2;
   
  // hit=true;
}

}

void inPen(){
  if(x<width/10-width/80){
   isRendered=false;
   
  }
}
void countSheep(){
  count =0;
  if (isRendered==false){
    count++;
    state=2;
  }
}
}
