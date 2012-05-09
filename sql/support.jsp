<%@page import="support.*, java.util.*,java.io.*" %>

<HTML>
 <HEAD> <TITLE> Support Example</TITLE> </HEAD>
 <BODY>
  <% 
   	support s = new support();   	
   	
   	String path1 = config.getServletContext().getRealPath("countries.txt");
   	String path2 = config.getServletContext().getRealPath("universities.txt");
    String path3 = config.getServletContext().getRealPath("majors.txt");
    String path4 = config.getServletContext().getRealPath("specializations.txt");
    
    Writer writer1 = new BufferedWriter(new OutputStreamWriter(
    	    new FileOutputStream("d:/insert_countries.sql"), "UTF-8"));
    
    Writer writer2 = new BufferedWriter(new OutputStreamWriter(
    	    new FileOutputStream("d:/insert_universities.sql"), "UTF-8"));
    
    Writer writer3 = new BufferedWriter(new OutputStreamWriter(
    	    new FileOutputStream("d:/insert_majors.sql"), "UTF-8"));
    
    Writer writer4 = new BufferedWriter(new OutputStreamWriter(
    	    new FileOutputStream("d:/insert_specializations.sql"), "UTF-8"));
	
    //getCountries returns a vector of the countries to be used for choosing citizenship
    Vector countries = s.getCountries(path1);    
    //getUniversities returns a vector of vectors where each vector is a tuple of <string, vector>
    //with the string being the name of the country/state and the vector being the list of universities there
    Vector universities = s.getUniversities(path2);
    //getMajors and getSpecializations return vectors
    Vector majors = s.getMajors(path3);
    Vector specializations = s.getSpecializations(path4);

    //print all the countries
    for(int i=0; i<countries.size(); i++){
    	String country = (String) countries.get(i);
    	country = country.replaceAll("'", "''");
      writer1.write("INSERT INTO countries (country) values ('" + country +"');\n");
    }
    
    out.println("Writer \"insert_countries.sql\" Successfully!<br>");
    
    //print all the majors
    for(int i=0; i<majors.size(); i++){
    	String major = (String)majors.get(i);
    	major = major.replaceAll("'", "''");
      writer3.write("INSERT INTO majors (major) values ('" + major +"');\n");
    }
    out.println("Writer \"insert_majors.sql\" Successfully!<br>");
    

    //print all the specializations
    for(int i=0; i<specializations.size(); i++){
    	String specialization = (String)specializations.get(i);
    	specialization = specialization.replaceAll("'", "''");
          writer4.write("INSERT INTO specializations (specialization) values ('" +specialization+"');\n");
      }
      out.println("Writer \"insert_specializations.sql\" Successfully!<br>");

    //print all the universities by state/country
    %><br>Number of states/countries with universities: <%=universities.size()%><br>
    <%
    for (int i=0; i<universities.size(); i++){
      //each entry in the universities vector is a tuple with the first entry being the country/state
      //and the second entry being a vector of the universities as String's
      Vector tuple = (Vector)universities.get(i);      
      String state = (String)tuple.get(0);  
      state = state.replaceAll("'", "''");
      Vector u = (Vector)tuple.get(1);
      for(int j=0; j<u.size(); j++){
      	String university = (String)u.get(j);
      	university = university.replaceAll("'", "''");
      	writer2.write("INSERT INTO universities (country_state, university) values ('" +state+"','"+ university +"');\n");            	
      }
    } 
    out.println("Writer \"insert_universities.sql\" Successfully!<br>");
    writer1.close();
    writer2.close();
    writer3.close();
    writer4.close();
    
  %>
 </BODY>
</HTML>

