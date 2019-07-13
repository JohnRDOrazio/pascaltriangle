import java.math.BigInteger; 

BigInteger BIG2 = new BigInteger("2");
BigInteger BIG3 = new BigInteger("3");
BigInteger BIG4 = new BigInteger("4");
  
void setup(){
  //size(1600,800);
  fullScreen();
  background(128);
  noLoop();
}

void draw(){
  int iterations = 320+32;
  float radius = 2; //MINIMUM 2!
  boolean PrintText = false;
  boolean HighlightEvens = false;
  boolean HighlightThirds = false;
  boolean HighlightFourths = true;
  boolean HighlightPrimes = false;
  
  color RED = color(255,0,0);
  color GREEN = color(0,255,0);
  color BLUE = color(0,0,255);
  color YELLOW = color(255,255,0);
  color ORANGE = color(255,127,0);
  color WHITE = color(255,255,255);
  color DARKRED = color(127,0,0);
  color DARKGREEN = color(0,127,0);
  color DARKBLUE = color(0,0,127);
  color PURPLE = color(127,0,127);
  
  float centerx = width/2;
  float centery = radius*2;
  ArrayList<BigInteger> nnOdd = new ArrayList<BigInteger>(1); 
  ArrayList<BigInteger> nnEven = new ArrayList<BigInteger>(1); 
  nnOdd.add(0,BigInteger.ONE);
  nnEven.add(0,BigInteger.ONE);
  textSize(radius / 4);
  textAlign(CENTER, CENTER);
  
  float angle = TWO_PI / 6;
  //float sx0 = centerx + cos(angle) * radius;
  //float sy0 = centery + sin(angle) * radius;
  //float sx1 = centerx + cos(angle+angle/2) * radius;
  //float sy1 = centery + sin(angle+angle/2) * radius;
  float sx2 = centerx + cos(angle-angle/2) * radius;
  //float sy2 = centery + sin(angle-angle/2) * radius;
  //float sx3 = centerx + cos(angle*2+angle/2) * radius;
  //float sy3 = centery + sin(angle*2+angle/2) * radius;
  float transX = sx2-centerx;
  /*
  stroke(0,255,0);
  line(centerx,centery,sx0,sy0);
  stroke(0,0,255);
  line(centerx,centery,sx1,sy1);
  stroke(255,0,0);
  line(centerx,centery,sx2,sy2);
  line(centerx,centery,sx3,sy3);
  line(sx3,sy3,sx2,sy2);
  */
  if(radius>2){
    stroke(DARKBLUE);
  }
  else{
    noStroke();
  }
  //LOOP THROUGH EACH ROW
  for(int i=0;i<iterations;i++){
    //println("now doing row "+i);
    //FILL THE VALUES OF OUR ARRAYS
    //FOR EVEN ROWS
    if((i+1) % 2 == 0){
      //determine the size of the array for this row cycle
      //int arrSize = (i+1)/2;
      //nnEven.ensureCapacity(arrSize);
      if(i > 1){
        nnEven.add(nnEven.size(),BigInteger.ONE);
      }
    }
    //FOR ODD ROWS
    else{
      if(i < 1){
      }
      else{ 
        //determine the size of the array for this row cycle
        //int arrSize = (i+2)/2;
        //nnOdd.ensureCapacity(arrSize);
        nnOdd.add(nnOdd.size(),BigInteger.ONE);
      }
    }
    
    //DRAW THE HEXAGONS FOR THIS ROW
    for(int x=0;x<(i+1);x++){
      
      //ODD ROWS (STARTING FROM ROW ONE)
      if((i+1) % 2 == 1){
        
        if(x==0){
          if(HighlightPrimes && isPrime(nnOdd.get(x))){
            fill(BLUE);
          }
          else if(HighlightEvens && nnOdd.get(x).mod(BIG2) == BigInteger.ZERO){
            fill(ORANGE);
          }
          else if(HighlightThirds && nnOdd.get(x).mod(BIG3) == BigInteger.ZERO){
            fill(PURPLE);
          }
          else if(HighlightFourths && nnOdd.get(x).mod(BIG4) == BigInteger.ZERO){
            fill(GREEN);
          }
          else{
            fill(WHITE);
          }
          polygon(centerx,centery+((1.5*radius)*i),radius,6);

          //IF WE ARE DEALING WITH ROW ONE, WE HAVE NO PRECEDING EVEN ROWS
          if(i==0){
            if(PrintText){
              fill(DARKRED);
              text("1",centerx,centery+((1.5*radius)*i));
            }
          }
          else{
            nnOdd.set(x,nnEven.get(x).multiply(BIG2));
            if(PrintText){
              fill(DARKRED);
              text(nnOdd.get(x).toString(),centerx,centery+((1.5*radius)*i));
            }
          }
        }
        //IF x IS GREATER THAN 0, THEN WE ARE NOT DEALING WITH ROW 1
        else if(x < (i/2)+1){
          //println("we are at row "+i+" cell "+x);
          if(x < nnEven.size()){
            nnOdd.set(x,nnEven.get(x).add(nnEven.get(x-1)));
          }
          else{
            nnOdd.set(x,nnEven.get(x-1));
          }

          if(HighlightPrimes && isPrime(nnOdd.get(x))){
            fill(BLUE);
          }
          else if(HighlightEvens && nnOdd.get(x).mod(BIG2) == BigInteger.ZERO){
            fill(ORANGE);
          }
          else if(HighlightThirds && nnOdd.get(x).mod(BIG3) == BigInteger.ZERO){
            fill(PURPLE);
          }
          else if(HighlightFourths && nnOdd.get(x).mod(BIG4) == BigInteger.ZERO){
            fill(GREEN);
          }
          else{
            fill(WHITE);
          }
          polygon(centerx-(transX*(2*x)),centery+((1.5*radius)*i),radius,6);

          if(PrintText){
            fill(DARKRED);
            text(nnOdd.get(x).toString(),centerx-(transX*(2*x)),centery+((1.5*radius)*i));
          }
        }
        else if(x > (i/2)){
          if(HighlightPrimes && isPrime(nnOdd.get(i-x+1))){
            fill(BLUE);
          }
          else if(HighlightEvens && nnOdd.get(i-x+1).mod(BIG2) == BigInteger.ZERO){
            fill(ORANGE);
          }
          else if(HighlightThirds && nnOdd.get(i-x+1).mod(BIG3) == BigInteger.ZERO){
            fill(PURPLE);
          }
          else if(HighlightFourths && nnOdd.get(i-x+1).mod(BIG4) == BigInteger.ZERO){
            fill(GREEN);
          }
          else{
            fill(WHITE);
          }
          polygon(centerx+(transX*(2*(i-x+1))),centery+((1.5*radius)*i),radius,6);        
          if(PrintText){
            fill(DARKRED);
            text(nnOdd.get(i-x+1).toString(),centerx+(transX*(2*(i-x+1))),centery+((1.5*radius)*i));
          }
        }
      }
      
      //EVEN ROWS (STARTING FROM ROW TWO) 
      else{
                
        if(x< ((i+1)/2)){
          if(x < nnOdd.size()-1){
            nnEven.set(x,nnOdd.get(x).add(nnOdd.get(x+1)));
          }
          else{
            //println("nnOdd.size = "+nnOdd.size());
            nnEven.set(x,nnOdd.get(x));
          }
          if(HighlightPrimes && isPrime(nnEven.get(x))){
            fill(BLUE);
          }
          else if(HighlightEvens && nnEven.get(x).mod(BIG2) == BigInteger.ZERO){
            fill(ORANGE);
          }
          else if(HighlightThirds && nnEven.get(x).mod(BIG3) == BigInteger.ZERO){
            fill(PURPLE);
          }
          else if(HighlightFourths && nnEven.get(x).mod(BIG4) == BigInteger.ZERO){
            fill(GREEN);
          }
          else{
            fill(WHITE);
          }
          polygon(centerx-(transX*((2*x)+1)),centery+((1.5*radius)*i),radius,6);        
          if(PrintText){
            fill(DARKRED);
            text(nnEven.get(x).toString(),centerx-(transX*((2*x)+1)),centery+((1.5*radius)*i));
          }
        }
        else if(x >= ((i+1)/2)){
          if(HighlightPrimes && isPrime(nnEven.get(i-x))){
            fill(BLUE);
          }
          else if(HighlightEvens && nnEven.get(i-x).mod(BIG2) == BigInteger.ZERO){
            fill(ORANGE);
          }
          else if(HighlightThirds && nnEven.get(i-x).mod(BIG3) == BigInteger.ZERO){
            fill(PURPLE);
          }
          else if(HighlightFourths && nnEven.get(i-x).mod(BIG4) == BigInteger.ZERO){
            fill(GREEN);
          }
          else{
            fill(WHITE);
          }
          polygon(centerx+(transX*(2*(i-x)+1)),centery+((1.5*radius)*i),radius,6);        
          if(PrintText){
            fill(DARKRED);
            text(nnEven.get(i-x).toString(),centerx+(transX*(2*(i-x)+1)),centery+((1.5*radius)*i));
          }
        }
      }
    }
  }

}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = (angle/2); a < TWO_PI + (angle/2); a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

//checks whether an int is prime or not.
boolean isPrime(BigInteger n) {
    //check if n is a multiple of 2
    if (n == BigInteger.ONE || n.mod(BIG2)==BigInteger.ZERO) return false;
    //if not, then just check the odds
    for(BigInteger i = BIG3;i.multiply(i).compareTo(n) <= 0;i = i.add(BIG2)) {
        if(n.mod(i)==BigInteger.ZERO)
            return false;
    }
    return true;
}
