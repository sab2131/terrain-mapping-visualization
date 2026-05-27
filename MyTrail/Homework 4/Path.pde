class Path {
      ArrayList<PVector> points;
      ArrayList<PVector> waypoints = new ArrayList<PVector>();
      PVector hoverPoint = null;

      Path() {
        points = new ArrayList<PVector>();
      }
      public void addPoint(float x, float y) {
        points.add(new PVector(x,y));
      }
      public void clearPoints() {
        points.clear();
      }
      public ArrayList<PVector> getPoints() {
         return points;
      }

      public void addWaypoint(float x, float y) {
        waypoints.add(new PVector(x,y));
      }
      public ArrayList<PVector> getWaypoints() {
        return waypoints;
      }
      public void setHoverPoint(float x, float y){
        hoverPoint = new PVector(x,y);
      }
      public PVector getHoverPoint() {
        return hoverPoint;
      }
}
