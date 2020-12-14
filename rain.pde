//created by Zachary Mankowitz over 2020 quarantine

import processing.sound.*;

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


void setup() { 

  if(isSound){
file[0]=new SoundFile(this,1+".wav");
file[1]=new SoundFile(this,2+".wav");
  }

  size(1000, 1000);
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
void draw() {
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
    list.get(selection).setYvel(list.get(selection).getYvel()-.1);
    }
    if(keyCode == RIGHT){
    list.get(selection).setXvel(list.get(selection).getXvel()+.1);
    }
    if(keyCode == LEFT){
    list.get(selection).setXvel(list.get(selection).getXvel()-.1);
    }
    if(keyCode == DOWN){
    list.get(selection).setYvel(list.get(selection).getYvel()+.1);
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
void mouseClicked(){
  for(int i =0; i<list.size();i++){
    if(list.get(i).getSize()>dist(mouseX,mouseY,list.get(i).getXpos(),list.get(i).getYpos())){
      selection =i;
    }
  }
}
