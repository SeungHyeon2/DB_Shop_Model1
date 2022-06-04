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

</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<a href="main.jsp">상품 목록</a> <a href="order.jsp">주문내역</a>
<br/>
<br/>
	주문내역

	<table border="1">
		<tr>
			<th>이미지</th>
			<th>상품명</th>
			<th>성별구분</th>
			<th>가격</th>
			<th>고객명</th>
			<th>고객번호</th>
			<th>등록일</th>
		</tr>
		<%
			Statement stm2 = null;
			ResultSet rs2 = null;
			Class.forName(driverName);
			Connection conn2 = DriverManager.getConnection(url, id, pwd);
			try {
				stm2 = conn2.createStatement();
				stm2.execute(String.format("select A.P_NAME, D.VALUE AS SEX, B.IMAGE_URL,B.PRICE,C.NAME,C.PHONE, TO_CHAR(A.REGDATE,'YYYY/mm/DD HH24:mi:ss') AS REGDATE "
						+"from ORDER_TABLE A "
						+"LEFT JOIN PRODUCT B on A.P_NAME = B.NAME "
						+"LEFT JOIN USER_MASTER C on A.WEB_ID = C.WEB_ID "
						+"LEFT JOIN DIVISION_01 D on B.SEX_CODE = D.CODE " 
						+"ORDER BY A.REGDATE DESC"));
				rs2 = stm2.getResultSet();
				
				while (rs2.next()) {
					String IMAGE_URL = rs2.getString("IMAGE_URL");
					String P_NAME = rs2.getString("P_NAME");
					String NAME = rs2.getString("NAME");
					String SEX = rs2.getString("SEX");
					String REGDATE = rs2.getString("REGDATE");
					String PHONE = rs2.getString("PHONE");
					int PRICE = rs2.getInt("PRICE");
					out.print("<tr>");
					String fullpath = /* request.getRealPath("upload") */"/upload/"+IMAGE_URL;
					out.print("<td><img src='" + fullpath + "' style='width:200px;'></td>"); 
					out.print("<td>" + P_NAME + "</td>");
					out.print("<td>" + SEX + "</td>");
					out.print("<td>" + PRICE + "</td>");
					out.print("<td>" + NAME + "</td>");
					out.print("<td>" + PHONE + "</td>");
					out.print("<td>" + REGDATE + "</td>");
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