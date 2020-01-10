class Platform {
  //geometry
  PVector point1,point2,n,k;
  float stick_limit_speed= 10;
  float mu = 5;
  int phase = 0;
  
  public Platform(float x1,float y1,float x2,float y2){
    point1 = new PVector(x1,y1);
    point2 = new PVector(x2,y2);
    n = new PVector(y2-y1,x1-x2);
    n.normalize();
  };
   
  public PVector normalV()
  {
    n = new PVector(point2.y-point1.y, point1.x-point2.x);
    return n.normalize();
  }
  
  public PVector orthoV()
  {
    k = new PVector(point1.x-point2.x, point1.y-point2.y);
    return k.normalize();
  }
  
  public PVector center()
  {
    return new PVector(0.5*(point2.x+point1.x), 0.5*(point1.y+point2.y));
  }
  
  public int get_y(float x)
  {
    float c = (point2.y - point1.y)/(point2.x - point1.x);
    return int(c*(x-point1.x) + point1.y);
  }
  
  public PVector normal_force(PVector sumF)
  {
    PVector normal = normalV();
    float projection = sumF.dot(normal);
    normal.mult(-projection);
    return normal;
  }
}



void draw_platform(Platform p){
  float d = 20;//scale for normals display
  stroke(190,90,250);
  line( p.point1.x,p.point1.y,p.point2.x,p.point2.y);
  stroke(250,250,250);
  line( p.center().x,
        p.center().y, 
        p.center().x + p.normalV().x*d, 
        p.center().y + p.normalV().y*d
       );
   line( p.center().x,
        p.center().y, 
        p.center().x + p.orthoV().x*d, 
        p.center().y + p.orthoV().y*d
       );
   
  noStroke();
}


void move_platform(Platform pf)
{
  pf.phase = (pf.phase+1)%100;  
  pf.point1.y = 100*cos(6.20*pf.phase*0.01)+300;
  pf.point2.y = 100*cos(6.20*pf.phase*0.01)+300;
}
