// ---------------------------------------------------------
// The MapModel class holds all the information necessary
// for working with an elevation map.  This class is application
// independent and should be separate from graphics and interaction
// logic.
// ---------------------------------------------------------

// Model class for holding information
public class MapModel {
  private ElevationMap map;
  private Path path;
  // Pass in a filepath to an image.  It will use the red channel for determining the elevation.
  public MapModel(String filePath, String colorFilePath) {
    PImage heightMap = loadImage(filePath);
    PImage colorImage = loadImage(colorFilePath);
    map = new ElevationMap(heightMap, colorImage, 0.0, 1.0);
    path = new Path();
  }
  
  // Get's the elevation map
  public ElevationMap getMap() {
    return map;
  }
  
  public Path getPath() {
    return path;
  }
};


// Defines an elevation map for working with terrain
public class ElevationMap {
  private PImage heightMap;
  private PImage colorImage;
  private float low;
  private float high;
  
  // The heightmap image defines the width and height and the low and high allows the user to specify the elevation range.
  // The elevation map also holds a color image that can be edited with getColor(x,y) and setColor(x,y,c)
  public ElevationMap(PImage heightMap, PImage colorImage, float low, float high) {
    this.heightMap = heightMap;
    this.colorImage = colorImage;
    this.low = low;
    this.high = high;
    heightMap.loadPixels();
    colorImage.loadPixels();
  }
  
  // Get the map width
  public int getWidth() {
    return heightMap.width;
  }
  
  // Get the map height
  public int getHeight() {
    return heightMap.height;
  }
  
  // Get the elevation at a point in the map
  public float getElevation(int x, int y) {
    float normalizedElevation = 1.0*red(heightMap.pixels[x + y*heightMap.width])/255.0;
    return lerp(low, high, normalizedElevation);
  }
  
  public float getNormElevation(float posX, float posY) {
    int index = (int)(posX*heightMap.width + posY*heightMap.height*heightMap.width);
    return 1.0*red(heightMap.pixels[index])/255.0;
  }
  
  // Get the color image for drawing and editing purposes
  public PImage getColorImage() {
    return colorImage;
  }
  
  // Get the color at a point in the map
  public color getColor(int x, int y) {
    return colorImage.pixels[x + y*heightMap.width];
  }
  
  // Sets the color at a point in the map
  public void setColor(int x, int y, color c) {
    colorImage.pixels[x + y*heightMap.width] = c;
  }
}
