//I think I should treat the shape as a wall in the sense of comparing the ball to line, not point, Then it is only x sides per shape instead of thousands. That makes a lot of sense writing it out

class Shape{
  int xPos, yPos, type, rotation;
  
  public Shape(int xPos, int yPos, int type, int rotation){
    this.xPos = xPos;
    this.yPos = yPos;
    this.type = type;
    this.rotation = rotation;
    System.out.println("New Shape located at "+xPos+", "+yPos+" of type "+type+" and rotation "+ rotation);
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
       }else{
         rect(xPos,yPos,50,400);
       }
    }else if(type==1){//this will be 'L' shape 200x200
      if(rotation==0){
        rect(xPos,yPos+150,200,50);
        rect(xPos,yPos,50,200);
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
