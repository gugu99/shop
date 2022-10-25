<%@page import="vo.Cart"%>
<%@page import="service.CartService"%>
<%@page import="service.OrdersService"%>
<%@page import="vo.Orders"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------addOrderAction.jsp");	
	
	if (session.getAttribute("user") == null || !session.getAttribute("user").equals("customer")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
	String customerId = (String)session.getAttribute("id");
	String isCart = request.getParameter("cart");
	String addr = request.getParameter("addr");
	String detailAddress = request.getParameter("detailAddress");
	String orderAddr = addr + " " + detailAddress;
	
	// 디버깅
	System.out.println("goodsNo --- " + goodsNo);
	System.out.println("orderPrice --- " + orderPrice);
	System.out.println("orderQuantity --- " + orderQuantity);
	System.out.println("customerId --- " + customerId);
	System.out.println("orderAddr --- " + customerId);
	
	Orders orders = new Orders();
	Cart cart = new Cart();
	// setter
	orders.setGoodsNo(goodsNo);
	orders.setOrderPrice(orderPrice);
	orders.setOrderQuantity(orderQuantity);
	orders.setCustomerId(customerId);
	orders.setOrderAddr(orderAddr);
	
	cart.setGoodsNo(goodsNo);
	cart.setCustomerId(customerId);
	
	OrdersService ordersService = new OrdersService();
	boolean add = ordersService.addOrder(orders);
	
	System.out.println("add --- " + add);
	
	if (!add) {
		System.out.println("주문 실패!");
		response.sendRedirect(request.getContextPath()+"/goods/customerGoodsAndImgOne.jsp?goodsNo=" + goodsNo);
		return;
	}
	
	if (isCart.equals("cart")) {
		CartService cartService = new CartService();
		boolean remove = cartService.removeCart(cart);
		System.out.println("remove --- " + remove);
	}
	System.out.println("주문 성공!");
	response.sendRedirect(request.getContextPath()+"/order/customerOrdersList.jsp");
%>