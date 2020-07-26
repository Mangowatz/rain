import processing.sound.*;

SoundFile[] file=new SoundFile[2];
int selection = 0;
float theta=0;
ArrayList<Ball> list = new ArrayList<Ball>();
void setup() {

file[0]=new SoundFile(this,1+".wav");
file[1]=new SoundFile(this,2+".wav");

  size(1000, 1000);
  background(255, 255, 255);
  for(int i =0;i<2;i++){
  list.add(new Ball(random(1,10),random(1,10),(int)random(10,70),10));
  }
  //list.get(0).setDensity(10);
  list.get(1).setXpos(500);

}
void draw() {
  background(255, 255, 255);
  //list.get(1).follow(list.get(0));
  for(int i =0;i<list.size();i++){
  list.get(i).update();
  list.get(i).display();
  }
if(keyPressed){
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
}
  //these calculate the angle between two ball from 0-360 starting from left horizontal and continuing clockwise
    theta = -atan2(list.get(0).getYpos() - list.get(1).getYpos(),list.get(1).getXpos() - list.get(0).getXpos()) * 180 / PI;
    if(theta<0)theta= 180+ abs(180 + theta);
    if((list.get(0).getSize()+list.get(1).getSize())>dist(list.get(0).getXpos(),list.get(0).getYpos(),list.get(1).getXpos(),list.get(1).getYpos())){//balls touch
   System.out.println("IMPACT");
   /*
      list.get(0).setXvel(-((list.get(0).getXvel())-(list.get(1).getXvel())));
      list.get(0).setYvel(-((list.get(0).getYvel())-(list.get(1).getYvel())));
      
      list.get(1).setXvel(((list.get(1).getXvel()*cos(theta))-(list.get(0).getXvel()*cos(theta)))/(cos(theta)));
      list.get(1).setYvel(((list.get(1).getYvel()*sin(theta))-(list.get(0).getYvel()*sin(theta)))/(sin(theta)));
  
  */
      list.get(0).setXvel(((list.get(0).getMass()*list.get(0).getXvel())-(list.get(1).getMass()*list.get(1).getXvel()))/(list.get(0).getMass()));
      list.get(0).setYvel(((list.get(0).getMass()*list.get(0).getYvel())-(list.get(1).getMass()*list.get(1).getYvel()))/(list.get(0).getMass()));
     //0=m
     //1-M
      //X:((m*mXvel)-(M*MxVel))/m 
      
     
      
      list.get(1).setXvel(((2*(pow(list.get(0).getMass(),2)*list.get(0).getXvel()))-sqrt((16*list.get(0).getMass()*pow(list.get(0).getXvel(),2))-(4*(pow(list.get(0).getMass(),2)+(list.get(0).getMass()*list.get(1).getMass()))*((pow(list.get(0).getMass(),2)*pow(list.get(0).getXvel(),2))-(list.get(0).getMass()*list.get(1).getMass()*pow(list.get(0).getXvel(),2))))))/(2*(pow(list.get(0).getMass(),2)+(list.get(0).getMass()*list.get(1).getMass()))));
      list.get(1).setYvel(((2*(pow(list.get(0).getMass(),2)*list.get(0).getYvel()))-sqrt((16*list.get(0).getMass()*pow(list.get(0).getYvel(),2))-(4*(pow(list.get(0).getMass(),2)+(list.get(0).getMass()*list.get(1).getMass()))*((pow(list.get(0).getMass(),2)*pow(list.get(0).getYvel(),2))-(list.get(0).getMass()*list.get(1).getMass()*pow(list.get(0).getYvel(),2))))))/(2*(pow(list.get(0).getMass(),2)+(list.get(0).getMass()*list.get(1).getMass()))));

 }
  System.out.println("Theta"+theta);
  System.out.println("0: "+" xVel: "+list.get(0).getXvel()+" yVel: "+list.get(0).getYvel()+" xPos: "+list.get(0).getXpos()+" yPos: "+list.get(0).getYpos());
  System.out.println("1: "+" xVel: "+list.get(1).getXvel()+" yVel: "+list.get(1).getYvel()+" xPos: "+list.get(1).getXpos()+" yPos: "+list.get(1).getYpos());
  
}
void mouseClicked(){
  for(int i =0; i<list.size();i++){
    if(list.get(i).getSize()>dist(mouseX,mouseY,list.get(i).getXpos(),list.get(i).getYpos())){
      selection =i;
    }
  }
}
