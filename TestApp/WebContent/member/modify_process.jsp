<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
request.setCharacterEncoding("UTF-8");
String driverName="oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:orcl";
String id = "system";
String pwd ="1220";


Statement stm = null;
ResultSet rs = null;
Connection conn = null;

Class.forName(driverName);     




	
String WEB_ID = (String)session.getAttribute("WEB_ID");
String WEB_PW = request.getParameter("WEB_PW");
String NAME = request.getParameter("NAME");
String PHONE = request.getParameter("PHONE");
String SEX = request.getParameter("SEX");
String EMAIL = request.getParameter("EMAIL");
String BIRTH = request.getParameter("BIRTH");

/* out.print(WEB_ID);
out.print("<br/>");
out.print(WEB_PW);
out.print("<br/>");
out.print(NAME);
out.print("<br/>");
out.print(PHONE);
out.print("<br/>");
out.print(SEX);
out.print("<br/>");
out.print(EMAIL);
out.print("<br/>");
out.print(BIRTH);
out.print("<br/>"); */
    
try {
	conn = DriverManager.getConnection(url,id,pwd);
	stm = conn.createStatement();
	stm.executeUpdate(String.format("UPDATE USER_MASTER SET NAME = '%s',WEB_PW = '%s', PHONE = '%s', SEX = '%s', EMAIL = '%s', BIRTH = TO_DATE('%s','YYYY-MM-DD')" 
			+ "WHERE WEB_ID = '%s'",NAME,WEB_PW,PHONE,SEX,EMAIL,BIRTH,WEB_ID)); 

	stm.close();
        
}catch(Exception e){ 
	e.printStackTrace();
}
    

conn.close();


response.sendRedirect("modify.jsp");
 
 


%>