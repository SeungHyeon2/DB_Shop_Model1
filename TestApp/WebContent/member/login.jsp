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
int result = 0;
Class.forName(driverName);     
Connection conn = DriverManager.getConnection(url,id,pwd);

String NAME = "";

String WEB_ID = request.getParameter("WEB_ID");
String WEB_PW = request.getParameter("WEB_PW");


try {
	stm = conn.createStatement();
	
	if(stm.execute(String.format("select * from USER_MASTER where WEB_ID = '%s' and WEB_PW = '%s'",WEB_ID,WEB_PW))) {
    	rs = stm.getResultSet();
	}
	while(rs.next()) {
		NAME = rs.getString("NAME");
	}
    
	if(NAME.equals("")){
		response.sendRedirect("../index.jsp");
	}else{
		session.setAttribute("WEB_ID", null);
		session.setAttribute("NAME", null);
		session.setAttribute("WEB_ID", WEB_ID);
		session.setAttribute("NAME", NAME);
		response.sendRedirect("../shop/index.jsp");
	}
    rs.close();
    stm.close();
}catch(Exception e){
	out.println("rs.next() ERROR");
}
 
//[3]데이타베이스 연결 해제
conn.close();

%>