class Physics 
{
  float g = 1000;
  PVector lambda = new PVector(90,1);
  PVector mass = new PVector(2,1);
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
  
  public PVector platform_reaction(Platform pf)
  {
    PVector f = new PVector(0,0);
    PVector n = normal_force(pf);
    float projection = velocity.dot(pf.orthoV());
    float sign = -projection/abs(projection);
    if(abs(projection) < pf.stick_limit_speed){
      f = pf.orthoV().mult(n.mag()*pf.mu*sign);
      println("stick");
    } else {
     println("over stick");
    }
 
    
    
    return f.add(n);
  }
  
  public PVector gravity()
  {
    return new PVector(0,g*mass.y);
  }
  
  
  public PVector normal_force(Platform pf)
  {
    PVector sumF = this.sumF();
    PVector normal = pf.normalV();
    float projection = sumF.dot(normal);
    normal.mult(-projection);
    return normal;
  }
  
  public void clear_physics()
  {
    while(forces.size()>0)
      forces.remove(0);
  }
  
  public void update_physics(Geometry geo, float dt)
  {
    acceleration = this.sumF();
    
    if(abs(acceleration.x) < 0.5)
      acceleration.x = 0;
    if(abs(acceleration.y) < 0.5)
      acceleration.y = 0;
      
    println("bilan forces : fx = "+acceleration.x+" fy = "+ acceleration.y);
    acceleration.x *= 1/mass.x;
    acceleration.y *= 1/mass.y;
    
    velocity.x += acceleration.x*dt;
    velocity.y += acceleration.y*dt;
    
    println("bilan vitesses : vx = "+velocity.x+" vy = "+ velocity.y);
    if(abs(velocity.x) < 0.5)
      velocity.x = 0;
    if(abs(velocity.y) < 0.5)
      velocity.y = 0;
    
      
    
    geo.position.x += velocity.x*dt;
    geo.position.y += velocity.y*dt;
    println("bilan positions : x = "+geo.position.x+" vy = "+ geo.position.y);
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
  velocity.x -= b*pf.normalV().x;
  velocity.y -= b*pf.normalV().y;
  }
  
}
