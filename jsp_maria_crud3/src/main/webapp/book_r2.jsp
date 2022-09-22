<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서적관리시스템 - 조회</title>
</head>
<body>
	<h1>서적관리시스템 - 조회(R2)</h1>
	<hr>
	<h2>전체보기(부분조회 미포함, 페이징기능 포함)</h2>

	<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/book_db";
	String user = "root";
	String passwd = "001016";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	Statement stmt = con.createStatement();
	request.setCharacterEncoding("utf-8");
	%>

	<%
	String sql2 = "SELECT count(*) FROM books ";
	ResultSet rs2 = stmt.executeQuery(sql2);

	int recordCnt = 0;
	int pageCnt;

	while (rs2.next()) {
		recordCnt = rs2.getInt(1);
	}

	pageCnt = recordCnt / 10;

	if (recordCnt % 10 != 0)
		pageCnt++;
	%>

	<%
	int book_id;
	String title;
	String publisher;
	String year;
	int price;

	int startRecord = 0;
	int limitCnt = 10;
	int currentPageNo;

	currentPageNo = Integer.parseInt(request.getParameter("currentPageNo"));
	startRecord = currentPageNo * 10;

	String sql = "SELECT * FROM books ORDER BY book_id limit ";
	sql += startRecord + "," + limitCnt;

	ResultSet rs = stmt.executeQuery(sql);
	%>

	<table border="1">
		<thead>
			<tr>
				<th>순번</th>
				<th>제목</th>
				<th>출판사</th>
				<th>출판년도</th>
				<th>가격</th>
			</tr>
		</thead>
		<tbody>

			<%
			while (rs.next()) {
				book_id = rs.getInt("book_id");
				title = rs.getString("title");
				publisher = rs.getString("publisher");
				year = rs.getString("year");
				price = rs.getInt("price");
			%>
			<tr>
				<td><%=book_id%></td>
				<td><%=title%></td>
				<td><%=publisher%></td>
				<td><%=year%></td>
				<td><%=price%></td>
			</tr>

			<%
			}
			%>
		</tbody>
	</table>
	<br>

	<a href="./book_r2.jsp?currentPageNo=0">[FIRST]</a>

	<%
	if (currentPageNo > 0) {
	%>
	<a href="./book_r2.jsp?currentPageNo=<%=(currentPageNo - 1)%>">[PRE]</a>
	<%
	} else {
	%>
	[PRE]
	<%
	}

	for (int i = 0; i < pageCnt; i++) {

	if (i == currentPageNo) {
	%>
	[<%=(i + 1)%>]
	<%
	} else {
	%>
	<a href="./book_r2.jsp?currentPageNo=<%=i%>">[<%=(i + 1)%>]
	</a>
	<%
	}
	}
	%>

	<%
	if (currentPageNo < pageCnt - 1) {
	%>
	<a href="./book_r2.jsp?currentPageNo=<%=(currentPageNo + 1)%>">[NXT]</a>
	<%
	} else {
	%>
	[NXT]
	<%
	}
	%>
	<a href="./book_r2.jsp?currentPageNo=<%=(pageCnt - 1)%>">[END]</a>

	<br>
	<br>
	<a href="./index.jsp">홈으로 돌아가기</a>
</body>
</html>