//Inspired by The Coding Train video on the MandelBulb 3D fractal video: https://www.youtube.com/watch?v=NJCiUVGiNyA

//check for oscilating patterns 

import peasy.*;

//the dimensions of the 3d space the object will be drawn within
//150
int DIM_3D = 100;
int N = 8;
int MAX_ITERATIONS = 20;
ArrayList<PVector> mandlebulb = new ArrayList<PVector>();
PeasyCam cam;

//offset values
float xoff = 0;
float yoff = 0;
float zoff = 0;

//color changer
int color_val = 0;
float timer = 0;

//max = top range of hue was reached
boolean max = false;

void setup(){
 size(1000,1000,P3D);
 cam = new PeasyCam(this,900);
 colorMode(HSB);
 createObject();

 
}

void draw(){
  background(0);
  
  lights();
  ambientLight(255,100,250);
  
  cam.setRotations(timer,timer,0);
  timer += 0.01;
  
  
  for (int i = 0; i < mandlebulb.size();i++){
   
   
   float x_val = map(noise(xoff),0,1,100,130);
   float new_x = mandlebulb.get(i).x * x_val;
   
   float y_val = map(noise(yoff),0,1,100,125);
   float new_y = mandlebulb.get(i).y * y_val;
   
   float z_val = map(noise(zoff),0,1,100,115);
   float new_z = mandlebulb.get(i).z * z_val;
   
   xoff+= 0.000001;
   yoff+= 0.000001;
   zoff+= 0.000001;
    
   
   color_val = (int)x_val;
   stroke(color_val,255,255);
   point(new_x * 0.5,new_y * 0.5,new_z * 0.5);
   
   color_val = (int)y_val + 30;
   stroke(color_val,255,255);
   point(new_x,new_y,new_z);
   
   color_val = (int)z_val + 60;
   stroke(color_val,255,255);
   point(new_x*2,new_y*2,new_z*2);
  
   
  }
  
    
 
}

void createObject(){
 for (int i = 0; i < DIM_3D;i++){
   for (int j = 0; j < DIM_3D;j++){
     boolean edge = false;
     for (int k = 0; k < DIM_3D;k++){
       
       float x = map(i,0,DIM_3D,-1,1);
       float y = map(j,0,DIM_3D,-1,1);
       float z = map(k,0,DIM_3D,-1,1);
       
        
       int iteration = 0;
       PVector zeta = new PVector(0,0,0);
       
       while(true){
         
         PVector sphereCord = calculateSphereCord(zeta.x,zeta.y,zeta.z);
        
         //calculating new positions
         float newX = pow(sphereCord.x,N) * sin(sphereCord.y*N) * cos(sphereCord.z*N); 
         float newY = pow(sphereCord.x,N) * sin(sphereCord.y*N) * sin(sphereCord.z*N);
         float newZ = pow(sphereCord.x,N) * cos(sphereCord.y*N);
         
         //filling empty Vector
         zeta.x = newX + x;
         zeta.y = newY + y;
         zeta.z = newZ + z;
         iteration++;
         
         if(sphereCord.x > 16){
           if(edge){
             edge=false;
           }
           break;
         }
         
         if(iteration > MAX_ITERATIONS){
           if(!edge){
             edge= true;
             mandlebulb.add(new PVector(x,y,z));
           }
           break;
         }
           
       }   
     }
   }
 }
  
}

PVector calculateSphereCord(float x,float y, float z){
  //used to make the processing more efficient
   float x_2 = x*x;
   float y_2 = y*y;
   float z_2 = z*z;
  //calculate the Sphereical Coordinates
   float r = sqrt(x_2 + y_2 + z_2);
   float theta = atan2(sqrt(x_2 + y_2),z);
   float phi = atan2(y,x);
   
   return new PVector(r,theta,phi);
}
