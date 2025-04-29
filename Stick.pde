class Stick  {
  
  //variables
  float x;
  float y;
  
  float w;
  float h;
  
    //hitbox 
  float left;
  float right;
  float top;
  float bottom;
  
//picked up boolean
  boolean pickedUp;

//count variable
int count=0;

  
  //constructor
  Stick(){
    x=random(0,width-100);
    y=random(0,height-100);
    
    w=10;
    h=15;
  }
  
  //functions
  //draws stick
  void render(){
    if(pickedUp==false){
    fill(#644D0C);
rect(x,y,w,h);  
    }
//hitbox
    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;

  }
  //checks when player collides with stick
   void playerCollide(Dog aDog){
   //left
   if(aDog.top<= bottom &&
      aDog.bottom>=top&&
      aDog.right>left &&
      aDog.left <= left){
        pickedUp=true;
      }
      //right
    if(aDog.top<= bottom &&
      aDog.bottom>=top&&
      aDog.left<right &&
      aDog.right >= right){
         pickedUp=true;
      }
      //top
    if(aDog.left<= right &&
       aDog.right>=left &&
       aDog.bottom>top &&
       aDog.top<= top){
           pickedUp=true;
       }
     //bottom
       if(aDog.left<= right &&
       aDog.right>=left &&
       aDog.top<bottom &&
       aDog.bottom>= bottom){
           pickedUp=true;
       }
       
    if(pickedUp==true){
      count++;
       println(count);
  }
   }
  
}
