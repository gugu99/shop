<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 세션 리셋
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>