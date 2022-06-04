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

int result = 0;
Class.forName(driverName);     
Connection conn = DriverManager.getConnection(url,id,pwd);





String uploadPath=request.getRealPath("upload"); 
//String uploadPath = request.getSession().getServletContext().getRealPath("/upload");


int size = 10*1024*1024;
String name="";
String subject="";
String filename1="";
	
try{
    MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
	
    Enumeration files = multi.getFileNames();
    String file1 = (String)files.nextElement();
    filename1 = multi.getFilesystemName(file1);
    
    String NAME = multi.getParameter("NAME");
    String IMAGE_URL = filename1;
    String PRICE = multi.getParameter("PRICE");
    String SEX_CODE = multi.getParameter("SEX_CODE");
    String CONTENTS = multi.getParameter("CONTENTS");

    
   try {
    	stm = conn.createStatement();

    	stm.executeUpdate(String.format("insert into PRODUCT(NAME,IMAGE_URL,PRICE,SEX_CODE,CONTENTS) values('%s','%s','%d','%s','%s')",NAME,IMAGE_URL,Integer.parseInt(PRICE),SEX_CODE,CONTENTS));

        stm.close();
        conn.close();
    }catch(SQLException e){
    	e.printStackTrace();
    }catch(Exception e){ 
    	e.printStackTrace();
    }
}catch(Exception e){
    e.printStackTrace();
}

response.sendRedirect("main.jsp");
 
 


%>