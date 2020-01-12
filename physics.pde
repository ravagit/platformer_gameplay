class Physics 
{
  float g = 1000;
  PVector lambda = new PVector(100,10);
  PVector inertia = new PVector(0.5,1);
  PVector mass = new PVector(5,5);
  ArrayList<PVector> forces = new ArrayList<PVector>();
  PVector velocity = new PVector(0,0);
  PVector acceleration = new PVector(0,0);
  
  public Physics()
  { 
  }
  
  public PVector fluid_friction()
  {
    PVector f = new PVector(-lambda.x*velocity.x,
                     -lambda.y*velocity.y
    ); 
    println("fluid friction : fx = "+f.x+", fy = "+f.y); 
    return f;
  }
  
  public PVector gravity()
  {
    PVector f = new PVector(0,g*mass.y);
    println("gravity : fx = "+f.x+", fy = "+f.y);
    return f;
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
  //println("normal velocity :"+b);
  if(b < 0){
    velocity.x -= b*pf.normalV().x;
    velocity.y -= b*pf.normalV().y;
    }
  }
  
  void apply_inertia()
  {
    velocity.x *= inertia.x;
    velocity.y *= inertia.y;
  }
  
}


void physics_process(Physics ph, Geometry geo, float dt, ArrayList<Collision> all_collisions)
  {
    

    
    ph.forces.add(ph.gravity());
    ph.forces.add(ph.fluid_friction());
    
    for (Collision collision : all_collisions){
       collision_effect_dynamic(collision);
    }
    
    ph.acceleration = ph.sumF();
       
    ph.acceleration.x *= 1/ph.mass.x;
    ph.acceleration.y *= 1/ph.mass.y;
    //ph.acceleration = quantize2D(ph.acceleration,16);
   
    
    ph.velocity.x += ph.acceleration.x*dt;
    ph.velocity.y += ph.acceleration.y*dt;
    
    geo.position.x += ph.velocity.x*dt+0.5*ph.acceleration.x*dt*dt;
    geo.position.y += ph.velocity.y*dt+0.5*ph.acceleration.y*dt*dt;
    //geo.position.x += ph.velocity.x*dt;
    //geo.position.y += ph.velocity.y*dt;
    
    
    ph.apply_inertia();
    
    //ph.velocity = quantize2D(ph.velocity,16);
    
    
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
