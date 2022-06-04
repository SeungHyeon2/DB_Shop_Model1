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


Statement stm = null;
ResultSet rs = null;
Connection conn = null;

Class.forName(driverName);     

String WEB_ID = (String)session.getAttribute("WEB_ID");
String NAME = "";
String PHONE = "";
String SEX = "";
String EMAIL = "";
String BIRTH = "";


%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="../shop/index.jsp">상품 목록</a> <a href="../shop/basket.jsp">장바구니</a> <a href="../shop/buy_list.jsp">구매목록</a> <a href="modify.jsp">회원 수정</a> <a href="../index.jsp">로그아웃</a>
	<br/>
	<br/>
	회원수정
	<form action="modify_process.jsp" method="POST">
		<table border="1">
		
		<%
			Statement stm2 = null;
			ResultSet rs2 = null;
			Class.forName(driverName);
			Connection conn2 = DriverManager.getConnection(url, id, pwd);
			try {
				stm2 = conn2.createStatement();
				if (stm2.execute(String.format("select WEB_ID,WEB_PW,NAME,PHONE,SEX,EMAIL,TO_CHAR(BIRTH,'YYYY-mm-dd') AS BIRTH from USER_MASTER WHERE WEB_ID = '%s'",WEB_ID))) {
					rs2 = stm2.getResultSet();
				}
				while (rs2.next()) {
					NAME = rs2.getString("NAME");
					PHONE = rs2.getString("PHONE");
					SEX = rs2.getString("SEX");
					EMAIL = rs2.getString("EMAIL");
					BIRTH = rs2.getString("BIRTH");
				}

				rs2.close();
				stm2.close();
			} catch (Exception e) {
				out.println("rs.next() ERROR");
			}
			conn2.close();
		%>
			<tr>
				<th>아이디</th>
				<td><input type="text" id="WEB_ID" name="WEB_ID" value="<%=WEB_ID%>" disabled="disabled"/></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" id="WEB_PW" name="WEB_PW"/></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" id="NAME" name="NAME" value="<%=NAME%>"/></td>
			</tr>
			<tr>
				<th>핸드폰번호</th>
				<td><input type="text" id="PHONE" name="PHONE" value="<%=PHONE%>"/></td>
			</tr>
			<tr>
				<th>성별</th>
				<td><input type="radio" value="M" name="SEX" 
				<%
				if(SEX.equals("M")){
				%>
				checked="checked"	
				<%
				}
				%>
				>남성<input type="radio" value="F" name="SEX"
				<%
				if(SEX.equals("F")){
				%>
				checked="checked"	
				<%
				}
				%>
				>여성</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" id="EMAIL" name="EMAIL" value="<%=EMAIL%>"/></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="date" id="BIRTH" name="BIRTH" min="1900-01-01" value="<%=BIRTH%>"/></td>
			</tr>
		</table>
		<br/>
		<input type="submit" value="회원수정"/>
	</form>
	
</body>
</html>