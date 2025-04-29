class Score{
  
  //variables
//score boards
  int playerScore;
    // score positions
      int playerScoreX;
      int playerScoreY;
        // winning score
          int winScore;
  
  //constructor
  Score(){
  playerScore=0;
  playerScoreX=width/4;
  playerScoreY=height-height/12;
  playerScore=0;
  }
  
   
void drawScore(int score, int x, int y, int aColor){
  fill(aColor);
  textSize(100);
  text(score,x,y);
 }
 void resetScore(){
  playerScore=0;
}

void winPath(){
  if(playerScore == 3 && state ==0){
    state+=1;
}
if(playerScore == 8 && state ==1){
    state+=1;
}
if(playerScore == 3 && state ==2){
    state+=1;
}
} 
void playerWinScreen(){
  if (playerScore >=winScore){
  backgroundColor =color(#5BBF3E);
  textSize(130);
  textAlign(CENTER);
  stroke(0);
  text("You Win!!", width/2,height/2);
  }
}
}
