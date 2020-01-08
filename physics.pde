class Physics 
{
  float g = 1000;
  PVector lambda = new PVector(90,1);
  PVector mass = new PVector(2,1);
  PVector forces = new PVector(0,0);
  PVector velocity = new PVector(0,0);
  public Physics()
  { 
  }
}

void apply_friction(Physics phi)
{
  phi.forces.x += -phi.lambda.x*phi.velocity.x;
  phi.forces.y += -phi.lambda.y*phi.velocity.y;
  //phi.velocity.x *= phi.lambda.x; 
  //phi.velocity.y *= phi.lambda.y; 
}

void apply_gravity(Physics ph)
{
  ph.forces.y += ph.g*ph.mass.y;
}

void resolve_forces(Physics phi, float dt)
{
  phi.velocity.x += phi.forces.x*dt/phi.mass.x;
  phi.velocity.y += phi.forces.y*dt/phi.mass.y;
  phi.forces.mult(0);
}

void limit_velocity(Physics ph, Geometry geo, float dt)
{
    if(ph.velocity.x<0.01)
       ph.velocity.x=0;
    if(ph.velocity.y<0.01)
       ph.velocity.y=0;
    if(ph.velocity.x>0.5*geo.size.x/dt)
      ph.velocity.x = 0.5*geo.size.x/dt;
    if(ph.velocity.y>0.5*geo.size.y/dt)
      ph.velocity.y = 0.5*geo.size.y/dt;
     
}

void update_position(Geometry geo, Physics phi, float dt)
{
  geo.position.x += phi.velocity.x*dt;
  geo.position.y += phi.velocity.y*dt;
}


void apply_normal_force(Physics ph, Platform pf)
{
  float a = ph.forces.dot(pf.normal);
  ph.forces.x -= a*pf.normal.x;
  ph.forces.y -= a*pf.normal.y;
  
}

void apply_dry_friction(Physics ph, Platform pf)
{
}

void stand_on_platform(Geometry geo, Physics ph, Platform pf){
  float b = ph.velocity.dot(pf.normal);
  ph.velocity.x -= b*pf.normal.x;
  ph.velocity.y -= b*pf.normal.y;
  geo.position.y = pf.get_y(geo.position.x)-geo.size.x+1;
  //text("distance  ="+s.p.physics.velocity.x,10,480);
  
}
