package gradstudent;

import java.io.*;
import java.util.*;

public class Address {
// best to keep as strings and convert to int when necessary.
  private String street;
  private String city;
  private String stateCode;
  private String zipcode;
  private String countryCode;
  private String areaCode;
  private String phoneNumber;

 public Address(String street,
   String city,
   String stateCode,
   String zipcode,
   String countryCode,
   String areaCode,
   String phoneNumber) {
   this.street = street;
   this.city = city;
   this.stateCode = stateCode;
   this.zipcode = zipcode;
   this.countryCode = countryCode;
   this.areaCode = areaCode;
   this.phoneNumber = phoneNumber;
 }

public void setStreet(String street) {
  this.street = street;
}

public String getStreet() { 
  return this.street; 
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

public void setCountryCode(String countryCode) {
  this.countryCode = countryCode;
}

public String getCountryCode() { 
  return this.countryCode; 
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
