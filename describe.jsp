<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="CSS/main.css">
	<title>테이블 구조보기</title>
</head>
<body>
<%
	String table_name = request.getParameter("name"); //테이블명 파라미터
	
	//데이터베이스 연결 변수
	String url = "jdbc:mysql://localhost:3306/";
	String db = "WebDataBase";
	String id = "root";
	String pw = "apmsetup";
%>
	<div id="wrap">
		<h2 class="head-line"><a href="index.jsp"><%= db %></a></h2>
		<h3 class="head-line"><%= table_name %></h3>
		<table class="db_show">
			<tr>
				<th>필드명</th>
				<th>타입</th>
				<th>null 허용</th>
				<th>key</th>
				<th>기본값</th>
				<th>Extra</th>
			</tr>
<%
	Connection con = null;
	
	//데이터베이스 연결
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url+db, id, pw);
		String query = "DESC "+table_name;
		PreparedStatement pstmt = con.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		int i = 0; //컬럼 수 변수
		while(rs.next()){
			++i; //컬럼 수 증가
%>
			<tr>
				<td><%= rs.getString("Field") %></td>
				<td><%= rs.getString("Type") %></td>
				<td><%= rs.getString("Null") %></td>
				<td><%= rs.getString("Key") %></td>
				<td><%= rs.getString("Default") %></td>
				<td><%= rs.getString("Extra") %></td>
			</tr>
<%
		}
%>
			<tr>
				<td colspan="6">필드 총 <%= i %>개</td>
			</tr>
<%
		rs.close();
		pstmt.close();
		con.close();
	} catch(Exception e){
		e.printStackTrace();
%>
	<script type="text/javascript">
	alert("오류가 발생했습니다.");
	location.href="index.jsp";
	</script>
<%
	}
%>
		</table>
	</div>
</body>
</html>