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
String IDX = request.getParameter("IDX");

out.println(IDX);
out.println("<br/>");
out.println(WEB_ID);

    
try {
	conn = DriverManager.getConnection(url,id,pwd);
	stm = conn.createStatement();
	stm.execute(String.format("DELETE BASKET WHERE IDX IN (%s) AND WEB_ID = '%s'",IDX,WEB_ID)); 

	stm.close();
        
}catch(Exception e){ 
	e.printStackTrace();
}
    

conn.close();


response.sendRedirect("index.jsp");
 
 


%>