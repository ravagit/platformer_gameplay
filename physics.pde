class Physics 
{
  float g = 10000;
  PVector lambda = new PVector(90,1);
  PVector mass = new PVector(2,3);
  ArrayList<PVector> forces = new ArrayList<PVector>();
  PVector velocity = new PVector(0,0);
  PVector acceleration = new PVector(0,0);
  
  public Physics()
  { 
  }
  
  public PVector fluid_friction()
  {
    return new PVector(-lambda.x*velocity.x,
                     -lambda.y*velocity.y
    );  
  }
  
  
  public PVector gravity()
  {
    return new PVector(0,g*mass.y);
  }
  
  
  public void clear_physics()
  {
    while(forces.size()>0)
      forces.remove(0);
  }
  
  public PVector sumF()
  {
    PVector sumF = new PVector(0,0);
    for (PVector tmp : forces)
       sumF.add(tmp);
    return sumF;
  }
  
  void cancel_normal_velocity(Platform pf)
  {
  float b = velocity.dot(pf.normalV());
  if(b < 0){
    velocity.x -= b*pf.normalV().x;
    velocity.y -= b*pf.normalV().y;
    }
  }
  
}


void physics_process(Physics ph, Geometry geo, float dt, ArrayList<Collision> all_collisions)
  {
    ph.forces.add(ph.gravity());
    ph.forces.add(ph.fluid_friction());
    
    //for (Collision collision : all_collisions)
      //on_platform_collision(ph,collision.platform);
    
    ph.acceleration = ph.sumF();
       
    ph.acceleration.x *= 1/ph.mass.x;
    ph.acceleration.y *= 1/ph.mass.y;
    //ph.acceleration = quantize2D(ph.acceleration,16);
    
    ph.velocity.x += ph.acceleration.x*dt;
    ph.velocity.y += ph.acceleration.y*dt;
    //ph.velocity = quantize2D(ph.velocity,16);
    
    geo.position.x += ph.velocity.x*dt;
    geo.position.y += ph.velocity.y*dt;
    //geo.position = quantize2D(geo.position,16);
  }


void log_bilan_force()
{
  Physics ph = s.p.physics;
  Geometry geo = s.p.geometry;
  println("bilan forces : fx = "+ph.acceleration.x+" fy = "+ ph.acceleration.y);
  println("bilan vitesses : vx = "+ph.velocity.x+" vy = "+ ph.velocity.y);
  println("bilan positions : x = "+geo.position.x+" vy = "+ geo.position.y);
}


PVector quantize2D(PVector v, int resolution)
{
  PVector q = new PVector(0,0);
  q.x = int(int(v.x*resolution)/resolution);
  q.y = int(int(v.y*resolution)/resolution);
  return q;
}
