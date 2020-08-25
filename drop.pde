//well. i misnamed the file and apparently i can't change it. oh well

int xOldMouse, yOldMouse;


class Ball {
    float xVel;
    float yVel;
    int size;
    int xPos = 80;
    int yPos = 70;
    float density;
  public Ball(float xVel, float yVel, int size,float density){
    this.xVel = xVel;
    this.yVel = yVel;
    this.size = size;
  }
  
  private void setXvel(float xVel){
    this.xVel=xVel;
  }
  private void setYvel(float yVel){
    this.yVel=yVel;
  }
  private void setSize(int size){
    this.size=size;
  }
   private void setXpos(int xPos){
     xOldMouse =this.xPos;
     this.xPos=xPos;
  }
   private void setYpos(int yPos){
    yOldMouse =this.yPos;
     this.yPos=yPos;
  }
  private void setDensity(float density){
    this.density=density;
  }
  private float getXvel(){
    return xVel;
  }
  private float getYvel(){
    return yVel;
  }
  private float getXpos(){
    return xPos;
  }
  private float getYpos(){
    return yPos;
  }
  private int getSize(){
    return size/2;
  }
  private float getDensity(){
    return density;
  }
  private float getMass(){
    return density*PI*pow(getSize(),2);
  }
  
  
  private void update(){
    if((xPos-getSize()<0)){
      //change xVel +
     // file[0].play(1,1);
      xVel*=-1;
      xPos+=1;
      fill(random(0,255),random(0,255),random(0,255));
      System.out.println("IMPACT LEFT WALL");
    }
    if((xPos+getSize()>1000)){
      //change xVel +
     // file[0].play(1,1);
      xVel*=-1;
      xPos-=1;
      fill(random(0,255),random(0,255),random(0,255));
      System.out.println("IMPACT RIGHT WALL");
    }
    if((yPos+getSize()>1000)){
    //  file[1].play(1,1);
      yVel*=-1;
      yPos-=1;
      fill(random(0,255),random(0,255),random(0,255));
      System.out.println("IMPACT BOTTOM WALL");
    }
    if((yPos-getSize()<0)){
   //   file[1].play(1,1);
      yVel*=-1;
      yPos+=1;
      fill(random(0,255),random(0,255),random(0,255));
      System.out.println("IMPACT TOP WALL");
    }
    
    
    xVel*=.99;
    yVel*=.99;
    xPos+=xVel;
    yPos+=yVel;
    
  }
  private void follow(Ball i){
    
    if(xPos<i.getXpos()){
      xVel=1;
    }
    if(xPos>i.getXpos()){
      xVel=-1;
    }
    
    if(yPos<i.getYpos()){
      yVel=1;
    }
    if(yPos>i.getYpos()){
      yVel=-1;
    }
    
  }
  private void display(){
    circle(xPos,yPos,size);
  }
  
}
