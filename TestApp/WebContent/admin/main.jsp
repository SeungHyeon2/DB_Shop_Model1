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
%>

<script>
function fn_del(name){
	location.href="del_product_process.jsp?NAME="+encodeURI(name);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<a href="main.jsp">상품 목록</a> <a href="order.jsp">주문내역</a>
<br/>
<br/>
	상품 목록

	<%-- <input type="button" value="나의 수강정보" onclick="location.href='myclass.jsp?flag=list&rs=true&WEB_ID=<%=WEB_ID%>'" />
	<input type="button" value="수강 정정" onclick="location.href='myclass.jsp?flag=modify&rs=true&WEB_ID=<%=WEB_ID%>'" /> --%>
	<table border="1">
		<tr>
			<th>이미지</th>
			<th>이름</th>
			<th>성별구분</th>
			<th>가격</th>
			<th>삭제</th>
		</tr>
		<%
			Statement stm2 = null;
			ResultSet rs2 = null;
			Class.forName(driverName);
			Connection conn2 = DriverManager.getConnection(url, id, pwd);
			try {
				stm2 = conn2.createStatement();
				if (stm2.execute(String.format("SELECT A.NAME AS NAME,B.VALUE AS SEX,A.CONTENTS AS CONTENTS,A.PRICE AS PRICE,A.IMAGE_URL AS IMAGE_URL  FROM PRODUCT A LEFT JOIN DIVISION_01 B ON A.SEX_CODE = B.CODE"))) {
					rs2 = stm2.getResultSet();
				}
				while (rs2.next()) {
					String IMAGE_URL = rs2.getString("IMAGE_URL");
					String NAME = rs2.getString("NAME");
					String SEX = rs2.getString("SEX");
					String CONTENTS = rs2.getString("CONTENTS");
					int PRICE = rs2.getInt("PRICE");
					out.print("<tr>");
					String fullpath = /* request.getRealPath("upload") */"/upload/"+IMAGE_URL;
					out.print("<td><img src='" + fullpath + "' style='width:200px;'></td>"); 
					out.print("<td>" + NAME + "</td>");
					out.print("<td>" + SEX + "</td>");
					out.print("<td>" + PRICE + "</td>");
					out.print("<td>" + "<input type='button' value='삭제' onclick='javascript:fn_del(\"" + NAME+ "\")'/>" + "</td>");
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
	<br />
	<input type="button" value="상품 등록" onclick="location.href='add_product.jsp'" /> 
</body>
</html>