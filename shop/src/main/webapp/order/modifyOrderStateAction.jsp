<%@page import="service.OrdersService"%>
<%@page import="vo.Orders"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------modifyOrdersStateAction.jsp");	
	
	if (session.getAttribute("user") == null || !session.getAttribute("user").equals("customer")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String preOrderState = request.getParameter("preOrderState");
	String orderState = request.getParameter("orderState");
	
	// 디버깅
	System.out.println("orderNo --- " + orderNo);
	System.out.println("preOrderState --- " + preOrderState);
	System.out.println("orderState --- " + orderState);
	
	Orders orders = new Orders();
	// setter
	orders.setOrderNo(orderNo);
	orders.setOrderState(orderState);
	
	OrdersService ordersService = new OrdersService();
	boolean modify = ordersService.modifyOrdersState(orders);
	
	System.out.println("modify --- " + modify);
	
	if (!modify) {
		System.out.println("주문 취소 실패!");
		response.sendRedirect(request.getContextPath()+"/order/customerOrdersList.jsp");
		return;
	}
	
	System.out.println("주문 취소 성공!");
	response.sendRedirect(request.getContextPath()+"/order/customerOrdersList.jsp");
%>