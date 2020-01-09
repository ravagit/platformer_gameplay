class collision 
{
  float distance, x, y;
  Platform platform;
  Player player;
  public collision(Player p, Platform pf, float x, float y, float distance)
  {
    this.player = p;
    this.platform = pf;
    this.x = x;
    this.y = y;
    this.distance = distance;
  } 
}

float collision_distance(Player p, Platform pf)
{
  float x0 = p.geometry.position.x;
  float y0 = p.geometry.position.y;
  float x1 =  pf.point1.x;
  float y1 =  pf.point1.y;
  float x2 =  pf.point2.x;
  float y2 =  pf.point2.y;
  
  float radius = p.geometry.size.x;//radius of circle 
  //(x0,y0) circle center, (x1,y1) (x2,y2) define the line direction
  float dy = y2-y1;
  float dx = x2-x1;
  return (dy*x0 - dx*y0 + x2*y1 - x1*y2)/mag(dy,dx) - radius;
}

boolean check_line_collision(Player p, Platform pf)
{
  float radius = p.geometry.size.x;//radius of circle
  float distance = collision_distance(p, pf) + radius;
  boolean xbounds = (p.geometry.position.x>pf.point1.x && 
                     p.geometry.position.x<pf.point2.x);
  return abs(distance)<radius && xbounds;
}

void detect_platform_collisions(scene s)
{
  
  for(int i=0;i<s.pf.length;i++)
  {
    if(check_line_collision(s.p, s.pf[i]))
      s.collision_list.add(new collision(
                                         s.p,
                                         s.pf[i],
                                         s.p.geometry.position.x,
                                         s.p.geometry.position.y,
                                         -collision_distance(s.p,s.pf[i])
                                         )
                           );
  }
 
}

void resolve_collisions(scene s)
{
  collision tmp;
  Physics phi;
  Geometry geo;
  while(s.collision_list.size()>0)
  {
    tmp = s.collision_list.get(0);
    s.collision_list.remove(0);
    
    println("collision penetration : "+tmp.distance);
    phi = tmp.player.physics;
    phi.forces.add(s.p.physics.normal_force(tmp.platform));
    phi.cancel_colinear_velocity(tmp.platform);
    
    geo = tmp.player.geometry;
    geo.position.y = tmp.platform.get_y(geo.position.x)-geo.size.y-1;
    
  }
}




void display_collision_box(PVector corner1,PVector corner2){
  stroke(0,255,0);
  noFill();
  rectMode(CORNERS);
  rect(corner1.x,corner1.y,corner2.x,corner2.y);
  point(corner1.x,corner1.y);
  point(corner2.x,corner2.y);
  noStroke();
  
}

void display_collision_circle(PVector center, float radius){
  stroke(0,255,0);
  noFill();
  circle(center.x,center.y,radius*2);
  noStroke();
}
