import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
PImage img;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    String url = "https://t3.ftcdn.net/jpg/03/12/54/80/360_F_312548010_JsXZ9vxIXTbgZlDr1IwlMTogrN84BN1L.jpg";
    img = loadImage(url, "png");
    // make the manager
    Interactive.make( this );
 buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int j = 0; j < NUM_ROWS;j++){
     for (int i = 0; i < NUM_COLS;i++){
      buttons[j][i]=new MSButton(j,i); 
     }
    }
setMines();
   
}
public void setMines()
{
  for (int i = 0; i <50; i++){
  int row = (int)(Math.random()*NUM_ROWS);
  int col = (int)(Math.random()*NUM_COLS);
  if (mines.contains(buttons[row][col])==false)
  mines.add(buttons[row][col]);
}
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
    if(isLost() == true)
        displayLosingMessage();
        image(img, 0, 0);
}
public boolean isWon()
{
    int count  = 0;
    for(int i = 0; i < NUM_ROWS; i++)
      for(int j = 0; j < NUM_COLS; j++)
        if(buttons[i][j].clicked == true && buttons[i][j].flagged == false)
          count++;
    if(count == NUM_ROWS*NUM_COLS-mines.size())
      return true;
    return false;
}
public boolean isLost()
{
    for(int i = 0; i < NUM_ROWS; i++)
      for(int j = 0; j < NUM_COLS; j++)
        if(buttons[i][j].clicked == true && mines.contains(buttons[i][j]) == true)
          return true;
    return false;
}
public void displayLosingMessage()
{

    for(int i = 0; i < NUM_ROWS; i++){
      for(int j = 0; j < NUM_COLS; j++){
        buttons[i][j].setLabel("");
        if(mines.contains(buttons[i][j]) && buttons[i][j].clicked == false)
          buttons[i][j].mousePressed();

        
        }
         
          
    }
    noLoop();
}
public void displayWinningMessage()
{
  image(img, 0, 0,400,400);
    for(int i = 0; i < NUM_ROWS; i++)
      for(int j = 0; j < NUM_COLS; j++)
        buttons[i][j].setLabel("GG");

}
public boolean isValid(int r, int c)
{
   if (r>=0&&r<NUM_ROWS){
    if (c>=0&&c<NUM_COLS)
    return true;
  }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for (int j = row-1; j <= row+1; j++){
    for (int i = col-1; i <= col+1; i++){
      if (isValid(i,j) ==true){
      if (mines.contains(buttons[j][i]))
      numMines++;
      
    }
  }
  }
  
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged, shown;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
                if(mouseButton == CENTER)
          return; 
      if(mouseButton == LEFT){
          clicked = true;
          shown = true;
        }
       if(mouseButton == RIGHT && shown == false){
          flagged = !flagged;
          if(flagged == false)
            clicked = false;
        }
        else if(flagged == true);
        else if(mines.contains( this ));
          //displayLosingMessage();
        else if(countMines(myRow, myCol) > 0 && flagged == false)
          setLabel(countMines(myRow, myCol));
        else{
          for(int i = myRow-1; i <= myRow+1; i++)
            for(int j = myCol-1; j <= myCol+1; j++)
              if(isValid(i, j))
                if(!(mines.contains(buttons[i][j])) && buttons[i][j].clicked == false && buttons[i][j].flagged == false)
                  buttons[i][j].mousePressed(); 
                }
    }
    
    public void draw () 
    {    
        if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( color(249,213,115) );
        else 
            fill( color(153,255,71) );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
