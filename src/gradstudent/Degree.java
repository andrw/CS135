package gradstudent;

public class Degree {
// best to keep as strings and convert to int when necessary.
  private int loc;
  private int uni;
  private String customUni;
  private int major;
  private String customMajor;
  private String month;
  private String year;
  private String gpa;
  private String title;

  public Degree() {
    loc = -1;
    uni = -1;
    customUni = null;
    major = -1;
    customMajor = null;
    month = null;
    year = null;
    gpa = null;
    title = null;
  }

  public int getLoc() { 
    return this.loc; 
  }

  public void setLoc(int loc) { 
    this.loc = loc; 
  }

  public int getUni() { 
    return this.uni; 
  }

  public void setUni(int uni) { 
    this.uni = uni; 
  }

  public String getCustomUni() { 
    return this.customUni; 
  }

  public void setCustomUni(String customUni) { 
    this.customUni = customUni; 
  }

  public int getMajor() { 
    return this.major; 
  }

  public void setMajor(int major) { 
    this.major = major; 
  }

  public String getCustomMajor() { 
    return this.customMajor; 
  }

  public void setCustomMajor(String customMajor) { 
    this.customMajor = customMajor; 
  }

  public String getMonth() {
    return this.month;
  }

  public void setMonth(String month) { 
    this.month = month; 
  }

  public String getYear() { 
    return this.year; 
  }

  public void setYear(String year) { 
    this.year = year; 
  }

  public String getGPA() { 
    return this.gpa; 
  }

  public void setGPA(String gpa) { 
    this.gpa = gpa; 
  }

  public String getTitle() {
    return this.title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

}
