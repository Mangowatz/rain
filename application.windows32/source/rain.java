import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class rain extends PApplet {

//created by Zachary Mankowitz over 2020 quarantine



SoundFile[] file=new SoundFile[2];
int selection = 0;
static final int ballNumber = 5;
static final int shapeNumber = 4;
boolean start = false;
final static boolean isSound = false;
int screenX = 1000; int screenY = 1000;
float theta=0;
ArrayList<Ball> list = new ArrayList<Ball>();
ArrayList<Shape> shapeList = new ArrayList<Shape>();
int timeLeftGame=60;
int greenPoints=0;
int elapsedTime;
int timeOffset;
float greenOffset;
float greenCount=0;
int highscore;


public void setup() { 

  if(isSound){
file[0]=new SoundFile(this,1+".wav");
file[1]=new SoundFile(this,2+".wav");
  }

  
  background(255, 255, 255);
  for(int i =0;i<=ballNumber;i++){
  list.add(new Ball(/*random(1,10),random(1,10)*/0,0,(int)random(10,70),10,true));
  }
  
        //shapeList.add(new Shape(250,250,0,1));
        shapeList.add(new Shape(1000,500,1,0));
        shapeList.add(new Shape((int)random(50,300),(int)random(200,300),(int)random(0,2),(int)random(0,4)));
        shapeList.add(new Shape((int)random(500,700),(int)random(200,300),(int)random(0,2),(int)random(0,4)));
        shapeList.add(new Shape((int)random(50,300),(int)random(500,700),(int)random(0,2),(int)random(0,4)));
        shapeList.add(new Shape((int)random(500,300),(int)random(500,700),(int)random(0,2),(int)random(0,4)));
  
      //shapeList.add(new Shape((int)random(50,300),(int)random(200,300),(int)random(0,3),(int)random(0,4)));
    
      //shapeList.add(new Shape((int)random(500,700),(int)random(200,300),(int)random(0,3),(int)random(0,4)));
    
      //shapeList.add(new Shape((int)random(50,300),(int)random(500,700),(int)random(0,3),(int)random(0,4)));
    
      //shapeList.add(new Shape((int)random(500,700),(int)random(500,700),(int)random(0,3),(int)random(0,4)));
  
  
  //list.get(0).setDensity(10);
  
  list.get(0).setXpos(50);
  list.get(0).setYpos(50);
  
  list.get(1).setXpos((int)random(150,900));
  list.get(1).setYpos((int)random(100,900));
  
  list.get(2).setXpos((int)random(150,900));
  list.get(2).setYpos((int)random(100,900));
  
  list.get(3).setXpos((int)random(150,900));
  list.get(3).setYpos((int)random(100,900));
  
  list.get(4).setXpos((int)random(150,900));
  list.get(4).setYpos((int)random(100,900));
  
  list.get(5).setXpos((int)random(150,900));
  list.get(5).setYpos((int)random(100,900));

}
public void draw() {
  background(255, 255, 255);
  noStroke();
  fill(255,0,0);
  square(0,0,100);
  fill(0,255,0);
  square(900,900,100);
  for(int i = 0;i<shapeList.size();i++){
        fill(40,100,200);
        shapeList.get(i).drawShape();
      }

    if(keyCode == UP){
    list.get(selection).setYvel(list.get(selection).getYvel()-.1f);
    }
    if(keyCode == RIGHT){
    list.get(selection).setXvel(list.get(selection).getXvel()+.1f);
    }
    if(keyCode == LEFT){
    list.get(selection).setXvel(list.get(selection).getXvel()-.1f);
    }
    if(keyCode == DOWN){
    list.get(selection).setYvel(list.get(selection).getYvel()+.1f);
    }    
if(!keyPressed){
 keyCode=0; 
}

if(!start)timeOffset=(millis()/1000); //Don't start timer until ball leaves zone

if(list.get(selection).xPos>100||list.get(selection).yPos>100) start=true;
  for(int i =0;i<list.size();i++){
  if(start&&i!=selection){
    list.get(i).follow(list.get(selection));
  }
  list.get(i).update();
  if(i==selection){
    list.get(i).display(true);
  }
  list.get(i).display();
  }
  
  for(int i =0;i<list.size();i++){//checks if any balls touch
  for(int j =0; j<=i;j++){
    if(list.get(i).getYpos()==0) list.get(i).setYpos(100);//should remove balls from getting stuck on top of screen
    if(((list.get(i).getSize()+list.get(j).getSize())>dist(list.get(i).getXpos(),list.get(i).getYpos(),list.get(j).getXpos(),list.get(j).getYpos()))&&(j!=i)){//balls touch
   System.out.println("!!!!! IMPACT " + i +" : "+ j + " Selection: "+selection);
   
   
      list.get(i).setXvel(-((list.get(i).getXvel())-(list.get(j).getXvel())));
      list.get(i).setYvel(-((list.get(i).getYvel())-(list.get(j).getYvel())));
      //list.get(i).setXvel(list.get(i).getXvel()*(list.get(i).getSize()/list.get(j).getSize()));
      //list.get(i).setYvel(list.get(i).getYvel()*(list.get(i).getSize()/list.get(j).getSize()));
     
      
      list.get(j).setXvel(((list.get(j).getXvel()*cos(theta))-(list.get(i).getXvel()*cos(theta)))/(cos(theta)));
      list.get(j).setYvel(((list.get(j).getYvel()*sin(theta))-(list.get(i).getYvel()*sin(theta)))/(sin(theta)));
      //list.get(j).setXvel(list.get(j).getXvel()*(list.get(j).getSize()/list.get(i).getSize()));
      //list.get(j).setYvel(list.get(j).getYvel()*(list.get(j).getSize()/list.get(i).getSize()));
      
     
    }
  
  /*
      list.get(0).setXvel(((list.get(0).getMass()*list.get(0).getXvel())-(list.get(1).getMass()*list.get(1).getXvel()))/(list.get(0).getMass()));
      list.get(0).setYvel(((list.get(0).getMass()*list.get(0).getYvel())-(list.get(1).getMass()*list.get(1).getYvel()))/(list.get(0).getMass()));
     //0=m
     //1-M
      //X:((m*mXvel)-(M*MxVel))/m 
      
     
      
      list.get(1).setXvel(((2*(pow(list.get(0).getMass(),2)*list.get(0).getXvel()))-sqrt((16*list.get(0).getMass()*pow(list.get(0).getXvel(),2))-(4*(pow(list.get(0).getMass(),2)+(list.get(0).getMass()*list.get(1).getMass()))*((pow(list.get(0).getMass(),2)*pow(list.get(0).getXvel(),2))-(list.get(0).getMass()*list.get(1).getMass()*pow(list.get(0).getXvel(),2))))))/(2*(pow(list.get(0).getMass(),2)+(list.get(0).getMass()*list.get(1).getMass()))));
      list.get(1).setYvel(((2*(pow(list.get(0).getMass(),2)*list.get(0).getYvel()))-sqrt((16*list.get(0).getMass()*pow(list.get(0).getYvel(),2))-(4*(pow(list.get(0).getMass(),2)+(list.get(0).getMass()*list.get(1).getMass()))*((pow(list.get(0).getMass(),2)*pow(list.get(0).getYvel(),2))-(list.get(0).getMass()*list.get(1).getMass()*pow(list.get(0).getYvel(),2))))))/(2*(pow(list.get(0).getMass(),2)+(list.get(0).getMass()*list.get(1).getMass()))));
*/
                                                                                                                                                                                                               

  }
  if(list.get(i).touchingBoundry()==0){//vertical
      list.get(i).setXvel(-list.get(i).getXvel());
      System.out.println("shape strike vert");
    }else if(list.get(i).touchingBoundry()==1){//horizontal
      list.get(i).setYvel(-list.get(i).getYvel());
      System.out.println("shape strike horiz");
    } 
  }

  //these calculate the angle between two ball from 0-360 starting from left horizontal and continuing clockwise
    theta = -atan2(list.get(0).getYpos() - list.get(1).getYpos(),list.get(1).getXpos() - list.get(0).getXpos()) * 180 / PI;
    if(theta<0)theta= 180+ abs(180 + theta);
    
  System.out.println("Theta 0-1: "+theta);
  for(int i = 0; i<list.size();i++){
    System.out.println(i+": "+" xVel: "+list.get(i).getXvel()+" yVel: "+list.get(i).getYvel()+" xPos: "+list.get(i).getXpos()+" yPos: "+list.get(i).getYpos());
  }

  elapsedTime = (millis()/1000)-timeOffset;
 
  if((list.get(selection).xPos>900&&list.get(selection).yPos>900)&&greenCount!=1){
    greenPoints++;
  }
  
  textSize(32);
  text("Time left: "+ (timeLeftGame-elapsedTime),700,50);
  text("Points: "+ greenPoints,700,100);
  
  if(timeLeftGame-elapsedTime<=0){
    if(greenCount!=1){ 
      highscore=(greenPoints*50);
  }
    greenCount=1;
    background(100,100,100);
    textSize(100);
    fill(255,0,0);
    text("GAME OVER",200,300);
    text("Highscore: "+highscore,100,600);
    
  }
  
}
public void mouseClicked(){
  for(int i =0; i<list.size();i++){
    if(list.get(i).getSize()>dist(mouseX,mouseY,list.get(i).getXpos(),list.get(i).getYpos())){
      selection =i;
    }
  }
}
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
      if(isSound) file[0].play(1,1);
      xVel*=-1;
      xPos+=1;
      setColor((int)random(0,255),(int)random(0,255),(int)random(0,255));
      System.out.println("IMPACT LEFT WALL");
    }
    if((xPos+getSize()>screenX)){
      //change xVel +
      if(isSound) file[0].play(1,1);
      xVel*=-1;
      xPos-=1;
      setColor((int)random(0,255),(int)random(0,255),(int)random(0,255));
      System.out.println("IMPACT RIGHT WALL");
    }
    if((yPos+getSize()>screenY)){
      if(isSound) file[1].play(1,1);
      yVel*=-1;
      yPos-=1;
      setColor((int)random(0,255),(int)random(0,255),(int)random(0,255));
      System.out.println("IMPACT BOTTOM WALL");
    }
    if((yPos-getSize()<0)){
      if(isSound) file[1].play(1,1);
      yVel*=-1;
      yPos+=1;
      setColor((int)random(0,255),(int)random(0,255),(int)random(0,255));
      System.out.println("IMPACT TOP WALL");
    }
    
    if(abs(xVel)<=.09f){
      xVel=0;
    }
    if(abs(yVel)<=.09f){
      yVel=0;
    }
   
    xVel*=.99f;
    yVel*=.99f;
    xPos+=xVel;
    yPos+=yVel;
    
  }
  private void follow(Ball i){
    
    if(xPos<i.getXpos()){
      xVel+=.1f;
    }
    if(xPos>i.getXpos()){
      xVel+=-.1f;
    }
    if(yPos<i.getYpos()){
      yVel+=.1f;
    }
    if(yPos>i.getYpos()){
      yVel+=-.1f;
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
    for(int i =0;i<shapeList.size()-1;i++){
    if((this.xPos-(size/2)<=boundList.get(i).getXPositive())&&((this.xPos+(size/2))>=boundList.get(i).getXNegative())&&(this.yPos-(size/2)<=boundList.get(i).getYPositive()&&this.yPos+(size/2)>=boundList.get(i).getYNegative())){//vertical boundry
      //background(255,255,255);
      return 0;
    }//else if((yPos-(size/2)<=boundList.get(i).getYPositive()&&(yPos+(size/2))>=boundList.get(i).getYNegative())&&(xPos-(size/2)<=boundList.get(i).getXPositive()&&xPos+(size/2)>=boundList.get(i).getXNegative())){//horizontal boundry
      else if(((yPos+(size/2))>=boundList.get(i).getYPositive()-5&&((yPos+(size/2))<=boundList.get(i).getYPositive()+5))&&true&&(this.xPos<=boundList.get(i).getXPositive()&&this.xPos>boundList.get(i).getXNegative())/*&& it's wthin x bounds*/){
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
//I think I should treat the shape as a wall in the sense of comparing the ball to line, not point, Then it is only x sides per shape instead of thousands. That makes a lot of sense writing it out
 static int count;
 ArrayList<Bound> boundList = new ArrayList<Bound>();
 
class Shape{
  int xPos, yPos, type, rotation;
 
  
  public Shape(int xPos, int yPos, int type, int rotation){
    this.xPos = xPos;
    this.yPos = yPos;
    this.type = type;
    this.rotation = rotation;
    System.out.println("New Shape located at "+xPos+", "+yPos+" of type "+type+" and rotation "+ rotation);
    count++;
  }
  private void setXpos(int xPos){
    this.xPos=xPos;
  }
  private void setYpos(int YPos){
    this.yPos=yPos;
  }
  private void setType(int type){
    this.type=type;
  }
  private void setRotation(int rotation){
    this.rotation=rotation;
  }
  private float getXpos(){
    return xPos;
  }
  private float getYpos(){
    return yPos;
  }
  private float getType(){
    return type;
  }
  private float getRotation(){
    return rotation;
  }
  
  
  /** @param type this is the type of shape. Accepts 0,1,2
  *@param rotation this is the rotation of a shape. Accepts 0,1(90),2(180),3(270)
  *this method draws imovable barriers that Balls bounce off of. There are three shapes which can be flipped
  */
  private void drawShape(){
    
    if(type == 0){//this shape is a straight line
       if(rotation == 0 || rotation == 2){
         rect(xPos,yPos,400,50);//make 400x50 rect with xPos and yPos as center
         boundList.add(new Bound(xPos+400,xPos,yPos+50,yPos));
       }else{
         rect(xPos,yPos,50,400);
         boundList.add(new Bound(xPos+50,xPos,yPos+400,yPos));
       }
    }else if(type==1){//this will be 'L' shape 200x200
      if(rotation==0){
        rect(xPos,yPos+150,200,50);
        rect(xPos,yPos,50,200);
        boundList.add(new Bound(xPos+50,xPos,yPos+200,yPos));
        boundList.add(new Bound(xPos+200,xPos,yPos+50,yPos));
      }else if(rotation==1){
        rect(xPos+50,yPos,200,50);
        rect(xPos,yPos,50,200);
      }else if(rotation==2){
        rect(xPos,yPos,200,50);
        rect(xPos+200,yPos,50,200);
      }else if(rotation==3){
        rect(xPos,yPos+150,200,50);
        rect(xPos+150,yPos,50,200);
      }
    }else if(type ==2){//this will be a 'C' shape
      if(rotation==0){
        rect(xPos,yPos,200,50);
        rect(xPos,yPos,50,200);
        rect(xPos,yPos+150,200,50);
      }else if(rotation==1){
        rect(xPos,yPos,200,50);
        rect(xPos,yPos,50,200);
        rect(xPos+150,yPos,50,200);
      }else if(rotation==2){
        rect(xPos,yPos,200,50);
        rect(xPos+150,yPos,50,200);
        rect(xPos,yPos+150,200,50);
      }else if(rotation==3){
        rect(xPos,yPos+150,200,50);
        rect(xPos,yPos,50,200);
        rect(xPos+150,yPos,50,200);
      }
    }else{
      System.out.println("Unknown shape type");
    }
  }
  
}
class Bound{
  int xUB,xLB,yUB,yLB;
  /* 
  */
  public Bound(int xUpper,int xLower, int yUpper, int yLower ){
    xUB = xUpper;
    xLB = xLower;
    yUB = yUpper;
    yLB = yLower;
  }
  private int getXPositive(){
    return xUB;
  }
  private int getYPositive(){
    return yUB;
  }
  private int getXNegative(){
    return xLB;
  }
  private int getYNegative(){
    return yLB;
  }
}
  public void settings() {  size(1000, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "rain" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
