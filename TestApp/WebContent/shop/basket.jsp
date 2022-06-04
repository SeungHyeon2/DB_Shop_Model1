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

String WEB_ID = (String)session.getAttribute("WEB_ID");
%>

<script>
function fn_del(){
	var IDX = document.getElementsByName('IDX');
	var STR_IDX = '';
	var cnt = 0;
	for(var i=0 ; i<IDX.length ; i++) { 
		if(IDX[i].checked) { 
			if(cnt == 0){
				STR_IDX = IDX[i].value;
			}else{
				STR_IDX = STR_IDX + ',' + IDX[i].value;
			}
			cnt++;
		}
	}
	location.href='del_basket_process.jsp?IDX='+STR_IDX+'&WEB_ID=<%=WEB_ID%>';

}
function fn_buy(){
	var IDX = document.getElementsByName('IDX');
	var STR_IDX = '';
	var cnt = 0;
	for(var i=0 ; i<IDX.length ; i++) { 
		if(IDX[i].checked) { 
			if(cnt == 0){
				STR_IDX = IDX[i].id;
			}else{
				STR_IDX = STR_IDX + ',' + IDX[i].id;
			}
			cnt++;
		}
	}
	location.href='buy_products_process.jsp?IDX='+STR_IDX+'&WEB_ID=<%=WEB_ID%>';
	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="index.jsp">상품 목록</a> <a href="basket.jsp">장바구니</a> <a href="buy_list.jsp">구매목록</a> <a href="../member/modify.jsp">회원 수정</a> <a href="../index.jsp">로그아웃</a>
	<br/>
	<br/>
	장바구니 목록

	<%-- <input type="button" value="나의 수강정보" onclick="location.href='myclass.jsp?flag=list&rs=true&WEB_ID=<%=WEB_ID%>'" />
	<input type="button" value="수강 정정" onclick="location.href='myclass.jsp?flag=modify&rs=true&WEB_ID=<%=WEB_ID%>'" /> --%>
	<table border="1">
		<tr>
			<th>구분</th>
			<th>이미지</th>
			<th>이름</th>
			<th>성별구분</th>
			<th>가격</th>
			<th>등록일</th>
		</tr>
		<%
			Statement stm2 = null;
			ResultSet rs2 = null;
			Class.forName(driverName);
			Connection conn2 = DriverManager.getConnection(url, id, pwd);
			try {
				stm2 = conn2.createStatement();
				if (stm2.execute(String.format("SELECT A.IDX ,C.NAME, C.IMAGE_URL, B.VALUE AS SEX, C.PRICE, TO_CHAR(A.REGDATE,'YYYY/mm/dd HH24:mi:ss') AS REGDATE  "
						+"FROM BASKET A "
						+"LEFT JOIN PRODUCT C ON A.NAME = C.NAME "
						+"LEFT JOIN DIVISION_01 B ON C.SEX_CODE = B.CODE "
						+"WHERE A.WEB_ID = '%s' ORDER BY A.REGDATE DESC",WEB_ID))) {
					rs2 = stm2.getResultSet();
				}
				while (rs2.next()) {
					String IMAGE_URL = rs2.getString("IMAGE_URL");
					String NAME = rs2.getString("NAME");
					String SEX = rs2.getString("SEX");
					String REGDATE = rs2.getString("REGDATE");
					int PRICE = rs2.getInt("PRICE");
					int IDX = rs2.getInt("IDX");
					out.print("<tr>");
					String fullpath = /* request.getRealPath("upload") */"/upload/"+IMAGE_URL;
					out.print("<td><input type='checkbox' name = 'IDX' value='"+IDX + "' id='"+NAME+"'></td>");
					out.print("<td><img src='" + fullpath + "' style='width:200px;'></td>"); 
					out.print("<td>" + NAME + "</td>");
					out.print("<td>" + SEX + "</td>");
					out.print("<td>" + PRICE + "</td>");
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
	<input type="button" value="구매" onclick="fn_buy();"/>
	<input type="button" value="삭제" onclick="fn_del();"/>
</body>
</html>