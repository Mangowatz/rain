//well. i misnamed the file and apparently i can't change it. oh well

int xOldMouse, yOldMouse;


class Ball {
    float xVel;
    float yVel;
    int size,red,green,blue;
    int xPos = 80;
    int yPos = 70;
    boolean clr = false;
    float density;
  public Ball(float xVel, float yVel, int size,float density, boolean clr){
    this.xVel = xVel;
    this.yVel = yVel;
    this.size = size;
    this.clr = clr;
    System.out.println("New Ball with velocity "+xVel+", "+yVel+" and size "+size+" and color "+ clr);
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
  private void setColor(int red, int green, int blue){
    this.red=red;
    this.green=green;
    this.blue=blue;
  }
  private boolean isColor(){
    return clr;
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
    return density*getSize();
  }
  
  
  private void update(){
    if((xPos-getSize()<0)){
      //change xVel +
     // file[0].play(1,1);
      xVel*=-1;
      xPos+=1;
      setColor((int)random(0,255),(int)random(0,255),(int)random(0,255));
      System.out.println("IMPACT LEFT WALL");
    }
    if((xPos+getSize()>screenX)){
      //change xVel +
     // file[0].play(1,1);
      xVel*=-1;
      xPos-=1;
      setColor((int)random(0,255),(int)random(0,255),(int)random(0,255));
      System.out.println("IMPACT RIGHT WALL");
    }
    if((yPos+getSize()>screenY)){
    //  file[1].play(1,1);
      yVel*=-1;
      yPos-=1;
      setColor((int)random(0,255),(int)random(0,255),(int)random(0,255));
      System.out.println("IMPACT BOTTOM WALL");
    }
    if((yPos-getSize()<0)){
   //   file[1].play(1,1);
      yVel*=-1;
      yPos+=1;
      setColor((int)random(0,255),(int)random(0,255),(int)random(0,255));
      System.out.println("IMPACT TOP WALL");
    }
    /*
    if(abs(xVel)>100){
      xVel=0;
      xPos = 100;
      yPos=100;
    }
    else if(abs(yVel)>100){
      yVel=0;
       xPos = 100;
      yPos=100;
    }
    */
    xVel*=.99;
    yVel*=.99;
    xPos+=xVel;
    yPos+=yVel;
    
  }
  private void follow(Ball i){
    
    if(xPos<i.getXpos()){
      xVel+=.1;
    }
    if(xPos>i.getXpos()){
      xVel+=-.1;
    }
    if(yPos<i.getYpos()){
      yVel+=.1;
    }
    if(yPos>i.getYpos()){
      yVel+=-.1;
    }
    
  }
  private void display(){
    if(isColor()){
    fill(red,green,blue);
    }else{
      fill(255,255,255);
    }
    circle(xPos,yPos,size);
  }
  private void display(boolean bool){
    //circle(xPos,yPos,size);
    square(xPos-size/2,yPos-size/2,size);
  }
  
  private int touchingBoundry(){
    for(int i =0;i<shapeList.size();i++){
    if((xPos+(size/2)>boundList.get(i).getXUpper()&&(xPos-(size/2))<boundList.get(i).getXLower())&&(yPos+(size/2)>=boundList.get(i).getYUpper()&&yPos-(size/2)<=boundList.get(i).getYLower())){//vertical boundry
      //background(255,255,255);
      return 0;
    }else if((yPos+(size/2)<boundList.get(i).getYUpper()&&(yPos-(size/2))>boundList.get(i).getYLower())&&(xPos+(size/2)>=boundList.get(i).getXUpper()&&xPos-(size/2)<=boundList.get(i).getXLower())){//horizontal boundry
      background(55,25,25);
      return 1;
    }
    }return 2;
  }
}

/*
Lets create an arrayList of boundry zones defined as xAxisLowerBound,xAxisUpperBound, yUpperBound, yLower bound (vice versa for horiz.)
if
*/
