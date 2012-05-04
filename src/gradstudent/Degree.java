package gradstudent;

public class Degree {
// best to keep as strings and convert to int when necessary.
  private String loc;
  private String uni;
  private String discipline;
  private String month;
  private String year;
  private String gpa;

  public Degree() {
    loc ="";
    uni="";
    discipline="";
    month="";
    year="";
    gpa="";
  }

// constructor for residents in foreign countries
  public Degree(String loc,
   String uni,
   String discipline,
   String month,
   String year,
   String gpa) {
    this.loc=loc;
    this.uni=uni;
    this.discipline=discipline;
    this.month=month;
    this.year=year;
    this.gpa=gpa;
  }

  public String getLoc() { 
    return this.loc; 
  }

  public String getUni() { 
    return this.uni; 
  }

  public String getDiscipline() { 
    return this.discipline; 
  }

  public String getMonth() {
    return this.month;
  }

  public String getYear() { 
    return this.year; 
  }

  public String getGPA() { 
    return this.gpa; 
  }

}