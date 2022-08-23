<%@page import="service.ReviewService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	System.out.println("\n--------------------modifyReviewAction.jsp");

	if (session.getAttribute("user") == null && session.getAttribute("user").equals("customer")) { // 로그인 상태가 아닐 경우 loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}	
	
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String reviewContent = request.getParameter("reviewContent");
	
	
	// 디버깅
	System.out.println("orderNo --- " + orderNo);
	System.out.println("reviewContent --- " + reviewContent);
	
	Review review = new Review();
	review.setOrderNo(orderNo);
	review.setReviewContent(reviewContent);

	ReviewService reviewService = new ReviewService();
	
	boolean modify = reviewService.modifyReviewByCustomer(review);
	
	System.out.println("modify --- " + modify); // 디버깅
	
	if (!modify) {
		System.out.println("리뷰 수정 실패!");
		response.sendRedirect(request.getContextPath()+"/review/reviewList.jsp");
		return;
	}
	
	System.out.println("리뷰 수정 성공!");
	response.sendRedirect(request.getContextPath()+"/review/reviewList.jsp");
%>