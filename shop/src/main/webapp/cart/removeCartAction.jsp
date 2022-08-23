<%@page import="service.CartService"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	System.out.println("\n--------------------removeCartAction.jsp");

	if (session.getAttribute("user") == null && session.getAttribute("user").equals("customer")) { // 로그인 상태가 아닐 경우 loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}	
	
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String customerId = (String)session.getAttribute("id");
	
	// 디버깅
	System.out.println("goodsNo --- " + goodsNo);
	System.out.println("customerId --- " + customerId);
	
	Cart cart = new Cart();
	cart.setGoodsNo(goodsNo);
	cart.setCustomerId(customerId);
	
	CartService cartService = new CartService();
	
	boolean remove = cartService.removeCart(cart);
	
	System.out.println("remove --- " + remove); // 디버깅
	
	if (!remove) {
		System.out.println("장바구니 삭제 실패!");
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}
	
	System.out.println("장바구니 삭제 성공!");
	response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
%>