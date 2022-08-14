<%@page import="service.NoticeService"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------modifyNoticeAction.jsp");	
	
	if (session.getAttribute("user") == null || !session.getAttribute("user").equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// 디버깅
	System.out.println("noticeNo --- " + noticeNo);
	System.out.println("noticeTitle --- " + noticeTitle);
	System.out.println("noticeContent --- " + noticeContent);
	
	// setter
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	NoticeService noticeService = new NoticeService();
	
	boolean modify = noticeService.modifyNotice(notice);
	
	if (!modify) {
		System.out.println("공지사항 수정 실패!");
		response.sendRedirect(request.getContextPath()+"/admin/modifyNoticeForm.jsp?noticeNo="+noticeNo);
		return;
	}
	
	System.out.println("공지사항 수정 성공!");
	response.sendRedirect(request.getContextPath()+"/admin/adminNoticeOne.jsp?noticeNo="+noticeNo);
%>