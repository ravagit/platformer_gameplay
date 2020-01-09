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
  
  public PVector gravity()
  {
    return new PVector(0,g*mass.y);
  }
  
  
  public PVector normal_force(Platform pf)
  {
    PVector sumF = this.sumF();
    float projection = sumF.dot(pf.normal);
    PVector normal_force = pf.normal.copy();
    normal_force.mult(-projection);
    println("normal : "+projection);
    return normal_force;
  }
  
  public void clear_physics()
  {
    while(forces.size()>0)
      forces.remove(0);
  }
  
  public void update_physics(Geometry geo, float dt)
  {
    acceleration = this.sumF();
    acceleration.x *= 1/mass.x;
    acceleration.y *= 1/mass.y;
    
    velocity.x += acceleration.x*dt;
    velocity.y += acceleration.y*dt;
    
    geo.position.x += velocity.x*dt;
    geo.position.y += velocity.y*dt;
  }
  
  public PVector sumF()
  {
    PVector sumF = new PVector(0,0);
    for (PVector tmp : forces)
       sumF.add(tmp);
    return sumF;
  }
  
  void cancel_colinear_velocity(Platform pf)
  {
  float b = velocity.dot(pf.normal);
  velocity.x -= b*pf.normal.x;
  velocity.y -= b*pf.normal.y;
  }
  
}
