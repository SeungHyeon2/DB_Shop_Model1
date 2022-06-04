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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	----상품 등록---
	<form action="add_product_process.jsp" method="POST" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<th>상품명</th>
				<td><input type="text" id="NAME" name="NAME"/></td>
			</tr>
			<tr>
				<th>이미지</th>
				<td><input type="file" id="IMAGE_URL" name = "IMAGE_URL"/> </td>
			</tr>
			<tr>
				<th>가격</th>
				<td><input type="text" id="PRICE" name="PRICE"/></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
				<select id="SEX_CODE" name="SEX_CODE">
					<%
					Statement stm2 = null;
					ResultSet rs2 = null;
					Class.forName(driverName);
					Connection conn2 = DriverManager.getConnection(url, id, pwd);
					try {
						stm2 = conn2.createStatement();
						if (stm2.execute(String.format("SELECT * FROM DIVISION_01"))) {
							rs2 = stm2.getResultSet();
						}
						while (rs2.next()) {
							String CODE = rs2.getString("CODE");
							String VALUE = rs2.getString("VALUE");
							out.print("<option value='"+CODE+"'>"+VALUE+"</option>");
						}
						rs2.close();
						stm2.close();
					} catch (Exception e) {
						out.println("rs.next() ERROR");
					}
					conn2.close();
					%>
					
				</select>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="5" cols="20" id="CONTENTS" name="CONTENTS"></textarea></td>
			</tr>
		</table>
		<br/>
		<input type="submit" value="저장"/>
	</form>
	
</body>
</html>