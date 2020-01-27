class Bar 
{
  PVector position;
  float len,angle;
  int phase = 0;
  
  public Bar(float x, float y, float l, float a)
  {
    position = new PVector(x,y);
    len = l;
    angle = a;
  }
  
  public PVector get_tip()
  {  
      return new PVector( position.x - cos(angle)*len, 
                          position.y + sin(angle)*len
                         );
  }
  
  
}

class Bar_Collision extends Collision
{
  Player player;
  Bar bar;
  public Bar_Collision(Player p, Bar b)
  {
    player = p;
    bar = b;
  }  
  public void resolve_dynamic()
  {
   
  }
  public void resolve_static()
  {
     player.physics.acceleration = new PVector(0,0);
    player.physics.velocity = new PVector(0,0);
    player.geometry.position = bar.get_tip();
  } 
}

void move_bar(Bar b)
{
  int speed = 200;
  float offset = 1.5;
  b.phase = (b.phase+1)%speed;  
  b.angle = 3.14*(0.3*cos(6.20*b.phase/speed+offset)+0.5);
  //b.angle = 0;
  
}

void draw_bar(Bar b)
{
  stroke(90,190,50);
  line( b.position.x,
        b.position.y,
        b.get_tip().x,
        b.get_tip().y
        );
  noStroke();
}
