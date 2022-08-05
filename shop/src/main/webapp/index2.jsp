<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null) { // 로그인 상태가 아닐 경우 loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INDEX</title>
</head>
<body>
	<%=session.getAttribute("user") %> <!-- customer / employee -->
	<br/>
	<%=session.getAttribute("id") %> <!-- 로그인아이디 -->
	<br/>
	<%=session.getAttribute("name") %> <!-- 로그인 이름 -->
	<br/>
	<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	<br/>
	<form action="<%=request.getContextPath()%>/removeMember.jsp">
		<input type="password" name="memberPass"/>
		<button type="submit">탈퇴</button>
	</form>
</body>
</html>