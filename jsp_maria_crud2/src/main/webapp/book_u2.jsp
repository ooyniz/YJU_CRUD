<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서적관리시스템 - 자료수정</title>
</head>
<body>
<h1>서적관리시스템 - 자료수정(U2)</h1>
<hr>
<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/book_db";
	String user = "root";
	String passwd = "001016";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	Statement stmt = con.createStatement(); // sql 문장 처리
	request.setCharacterEncoding("utf-8"); // 한글로 읽음
	
	int book_id = Integer.parseInt(request.getParameter("book_id"));
	String sql = "SELECT * FROM books WHERE book_id = '" + book_id + "'";
	ResultSet rs = stmt.executeQuery(sql);
	
	String title;
	String publisher;
	String year;
	int price;
	
	while(rs.next()) {
	title = rs.getString("title");
	publisher = rs.getString("publisher");
	year = rs.getString("year");
	price = rs.getInt("price");
	
%>


<form method = "post" action = "./book_dao.jsp">
	<br>서적번호(수정불가) : <input type = "text" name = "book_id" value = "<%=book_id%>" size = "30" readonly>
	<br>서적명 : <input type = "text" name = "title" value = "<%=title%>" size = "30">
	<br>출판사 : <input type = "text" name = "publisher" value = "<%=publisher%>" size = "30">
	<br>출판년도 : <input type = "text" name = "year" value = "<%=year%>" size = "30">
	<br>가격 : <input type = "text" name = "price" value = "<%=price%>" size = "30">
	<br><input type = "hidden" name = "actionType" value = "U">
	<br><input type = "submit" value = "수정">
</form>

<%
}
%>
<br><a href = "./index.jsp">홈으로 돌아가기</a>
</body>
</html>