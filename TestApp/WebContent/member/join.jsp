<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%

%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	회원가입
	<form action="join_process.jsp" method="POST">
		<table border="1">
			<tr>
				<th>아이디</th>
				<td><input type="text" id="WEB_ID" name="WEB_ID"/></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" id="WEB_PW" name="WEB_PW"/></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" id="NAME" name="NAME"/></td>
			</tr>
			<tr>
				<th>핸드폰번호</th>
				<td><input type="text" id="PHONE" name="PHONE"/></td>
			</tr>
			<tr>
				<th>성별</th>
				<td><input type="radio" value="M" name="SEX">남성<input type="radio" value="F" name="SEX">여성</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" id="EMAIL" name="EMAIL"/></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="date" id="BIRTH" name="BIRTH" min="1900-01-01"/></td>
			</tr>
		</table>
		<br/>
		<input type="submit" value="회원가입"/>
	</form>
	
</body>
</html>