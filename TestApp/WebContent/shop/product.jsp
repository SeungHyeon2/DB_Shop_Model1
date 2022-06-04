<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
request.setCharacterEncoding("UTF-8");
String driverName="oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:orcl";
String id = "system";
String pwd ="1220";

String NAME = request.getParameter("NAME");
String WEB_ID = (String)session.getAttribute("WEB_ID");
String USER_NAME = (String)session.getAttribute("NAME");
String NAME2 = "";
%>




<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="index.jsp">상품 목록</a> <a href="basket.jsp">장바구니</a> <a href="buy_list.jsp">구매목록</a> <a href="../member/modify.jsp">회원 수정</a> <a href="../index.jsp">로그아웃</a>
	<br/>
	<br/>
	----상품 정보---
	<form action="add_product_process.jsp" method="POST" enctype="multipart/form-data">
		<table border="1">
		<%
		Statement stm2 = null;
		ResultSet rs2 = null;
		Class.forName(driverName);
		Connection conn2 = DriverManager.getConnection(url, id, pwd);
		try {
			stm2 = conn2.createStatement();
			if (stm2.execute(String.format("SELECT A.NAME AS NAME,B.VALUE AS SEX,A.CONTENTS AS CONTENTS,A.PRICE AS PRICE,A.IMAGE_URL AS IMAGE_URL  FROM PRODUCT A LEFT JOIN DIVISION_01 B ON A.SEX_CODE = B.CODE WHERE A.NAME = '%s'",NAME))) {
				rs2 = stm2.getResultSet();
			}
			while (rs2.next()) {
				String IMAGE_URL = rs2.getString("IMAGE_URL");
				NAME2 = rs2.getString("NAME");
				String SEX = rs2.getString("SEX");
				String CONTENTS = rs2.getString("CONTENTS");
				int PRICE = rs2.getInt("PRICE");
				out.print("<tr>");
				String fullpath = "/upload/"+IMAGE_URL;
				out.print("<td>상품명 : " + NAME + "</td>");
				out.print("<td><img src='" + fullpath + "' style='width:200px;'></td>"); 
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td colspan='2'> 가격 : " + PRICE + "</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td colspan='2'> 설명 <br/>" + CONTENTS + "</td>");
				out.print("</tr>");

			}

			rs2.close();
			stm2.close();
		} catch (Exception e) {
			out.println("rs.next() ERROR"); 
		}
		conn2.close();
		
		%>
		
		</table>
		<br/>
		<input type="button" value="구매" onclick="location.href='buy_product_process.jsp?WEB_ID=<%=WEB_ID%>&NAME=<%=NAME2%>'"/>
		<input type="button" value="장바구니 추가" onclick="location.href='add_basket_process.jsp?WEB_ID=<%=WEB_ID%>&NAME=<%=NAME2%>'"/>
	</form>
	
</body>
</html>