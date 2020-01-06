class Physics 
{
  float g = 0.09;
  float lambda = 0.8;
  float mass = 80;
  PVector forces = new PVector(0,0);
  PVector velocity = new PVector(0,0);
  public Physics()
  { 
  }
}

void apply_friction(Physics phi)
{
  phi.forces.x += -phi.lambda*phi.velocity.x;
  phi.forces.y += -phi.lambda*phi.velocity.y;
}

void apply_gravity(Physics ph)
{
  ph.forces.y += ph.g*ph.mass;
}

void resolve_forces(Physics phi, float dt)
{
  phi.velocity.x += phi.forces.x*dt/phi.mass;
  phi.velocity.y += phi.forces.y*dt/phi.mass;
  phi.forces.mult(0);
  if(phi.velocity.mag()<0.2)
     phi.velocity.mult(0);
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




void stand_on_platform(Geometry geo, Physics ph, Platform pf){
  float b = ph.velocity.dot(pf.normal);
  ph.velocity.x -= b*pf.normal.x;
  ph.velocity.y -= b*pf.normal.y;
  
  geo.position.y = pf.get_y(geo.position.x)-6;
  
}
