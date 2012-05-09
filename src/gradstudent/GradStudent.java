package gradstudent;

import java.io.*;
import java.util.*;

public class GradStudent {
  private String firstName;
  private String middleInitial;
  private String lastName;
  private int citizenship;
  private int residence;
  private Address address;
  private boolean foreign;
  private Vector<Degree> degrees;
  private int currentDegree;
  private int specialization;
  private int studId;


  /* student constructor with parameters */
  public GradStudent(String firstName, String middleInitial, String lastName) {
    this.firstName = firstName;
    this.middleInitial = middleInitial;
    this.lastName = lastName;
    degrees = new Vector<Degree>();
    currentDegree = 0;
    citizenship = 0;
    residence = 0;
    specialization = 0;
    studId = -1;
  }

  public String getFirstName() {
    return firstName;
  }

  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  public String getMiddleInitial() {
    return middleInitial;
  }

  public void setMiddleInitial(String middleInitial) {
    this.middleInitial = middleInitial;
  }

  public String getLastName() {
    return lastName;
  }

  public void setLastName(String lastName) {
    this.lastName = lastName;
  }

  public void setCitizenship(int citizenship) {
    this.citizenship = citizenship;
  }

  public int getCitizenship() {
    return this.citizenship;
  }

  public void setResidence(int residence) {
    this.residence = residence;
  }

  public int getResidence() {
    return this.residence;
  }

  public void setAddress(Address address) {
    this.address = address;
  }

  public Address getAddress() {
    return this.address;
  }

  public void setForeign(boolean bool) {
    this.foreign=bool;
  }

  public boolean getForeign() {
    return this.foreign;
  }

  public void newDegree(Degree newDeg) {
    degrees.add(newDeg);
  }

  public Vector<Degree> getDegrees() {
    return this.degrees;
  }

  public Degree getLastDegree() {
    return this.degrees.lastElement();
  }

  public void setSpecialization(int specialization) {
    this.specialization = specialization;
  }

  public int getSpecialization() {
    return this.specialization;
  }

  public int getStudId() {
    return this.studId;
  }

  public void setStudId(int studId) {
    this.studId = studId;
  }

}
