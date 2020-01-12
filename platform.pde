class Platform {
  //geometry
  PVector point1,point2,n,k;
  boolean is_sticky = true;
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
    if(projection < 0)
      normal.mult(-projection);
    else
      normal.mult(0);
    println("normal force : fx = "+normal.x+", fy = "+normal.y);
    return normal;
  }
  
  public PVector dry_friction(Physics ph)
  { 
    float limit_force = 8000;
      if(ph.velocity.mag() > 100)
        limit_force *= 0.5;
    PVector f = new PVector(0,0);
    PVector ortho = orthoV();
    float projection = ph.sumF().dot(ortho);
      if(abs(projection) < limit_force)
        f = ortho.mult(-projection);
    println("dry friction : fx = "+f.x+", fy = "+f.y);
    return f;
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


void collision_effect_static(Collision col)
{
  
  Geometry geo = col.player.geometry;
  col.player.physics.cancel_normal_velocity(col.platform);
  geo.position.y = col.platform.get_y(geo.position.x)-geo.size.x+1; 
  col.player.on_ground = true;
}

void collision_effect_dynamic(Collision col)
{
  Physics ph= col.player.physics;
  ph.forces.add(col.platform.normal_force(ph.sumF()));
  ph.forces.add(col.platform.dry_friction(ph));
}


void move_platform(Platform pf)
{
  pf.phase = (pf.phase+1)%100;  
  pf.point1.y = 100*cos(6.20*pf.phase*0.01)+300;
  pf.point2.y = 100*cos(6.20*pf.phase*0.01)+300;
}
