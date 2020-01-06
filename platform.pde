class Platform {
  //geometry
  PVector point1,point2,normal;
  
  public Platform(float x1,float y1,float x2,float y2){
    point1 = new PVector(x1,y1);
    point2 = new PVector(x2,y2);
    normal = new PVector(y2-y1,x1-x2);
    normal.normalize();
  };
   
  public float get_y(float x)
  {
    float c = (point2.y - point1.y)/(point2.x - point1.x);
    return c*(x-point1.x) + point1.y;
  }
}



void draw_platform(Platform p){
  float d = 1.3;
  for(int i=0; i<5; i++){
    stroke(250-i*40,210-i*30,250-i*40);
    line( p.point1.x - p.normal.x*d*i , 
          p.point1.y - p.normal.y*d*i ,
          p.point2.x - p.normal.x*d*i ,
          p.point2.y - p.normal.y*d*i 
     );
  }
  noStroke();
}
