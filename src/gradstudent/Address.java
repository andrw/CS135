package gradstudent;

import java.io.*;
import java.util.*;

public class Address {
// best to keep as strings and convert to int when necessary.
  private String streetNumber;
  private String streetName;
  private String city;
  private String stateCode;
  private String zipcode;
  private String areaCode;
  private String phoneNumber;

  public Address() {
   streetNumber="";
   streetName="";
   city="";
   stateCode="";
   zipcode="";
   areaCode="";
   phoneNumber="";
 }

// constructor for residents in foreign countries
 public Address(String streetNumber,
   String streetName,
   String city,
   String stateCode,
   String zipcode,
   String areaCode,
   String phoneNumber) {
   this.streetNumber= streetNumber;
   this.streetName = streetName;
   this.city = city;
   this.stateCode = stateCode;
   this.zipcode=zipcode;
   this.areaCode = areaCode;
   this.phoneNumber = phoneNumber;
 }

 public void setStreetNumber(String streetNumber) {
  this.streetNumber = streetNumber;
}

public String getStreetNumber() { 
  return this.streetNumber; 
}


public void setStreetName(String streetName) {
  this.streetName = streetName;
}

public String getStreetName() { 
  return this.streetName; 
}


public void setCity(String city) {
  this.city = city;
}

public String getCity() { 
  return this.city; 
}

public void setStateCode(String state) {
  this.stateCode =  stateCode;
}

public String getStateCode() {
  return this.stateCode;
}

public void setZipcode(String zipcode) {
  this.zipcode = zipcode;
}

public String getZipcode() { 
  return this.zipcode; 
}


public void setAreaCode(String areaCode) {
  this.areaCode = areaCode;
}

public String getAreaCode() { 
  return this.areaCode; 
}


public void setPhoneNumber(String phoneNumber) {
  this.phoneNumber = phoneNumber;
}

public String getPhoneNumber() { 
  return this.phoneNumber; 
}

}