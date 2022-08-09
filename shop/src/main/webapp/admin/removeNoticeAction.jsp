<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null || !((String)session.getAttribute("user")).equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라미터
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	System.out.println("noticeNo --- " + noticeNo); // 디버깅
	
	NoticeService noticeService = new NoticeService();
	
	boolean remove = noticeService.removeNotice(noticeNo);
	
	if (!remove) {
		System.out.println("공지 삭제 실패!");
		response.sendRedirect(request.getContextPath()+"/admin/adminNoticeOne.jsp?noticeNo="+noticeNo);
	}
	
	System.out.println("공지 삭제 성공!");
	response.sendRedirect(request.getContextPath()+"/admin/adminNoticeList.jsp");
%>