<%@page import="service.GoodsService"%>
<%@page import="vo.Goods"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------modifyGoodsSoldOutAction.jsp");	

	if (session.getAttribute("user") == null || !session.getAttribute("user").equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 파라미터
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String soldOut = request.getParameter("soldOut");
	
	System.out.println("goodsNo --- " + goodsNo);
	System.out.println("soldOut --- " + soldOut);
	
	// setter
	Goods goods = new Goods();
	goods.setGoodsNo(goodsNo);
	goods.setSoldOut(soldOut);
	
	GoodsService goodsService = new GoodsService();
	
	boolean modify = goodsService.modifyGoodsSoldOut(goods);
	
	if (!modify) {
		System.out.println("품절 여부 수정 실패!");
		response.sendRedirect(request.getContextPath()+"/admin/adminGoodsList.jsp");
		return;
	}
	System.out.println("품절 여부 수정 성공!");
	response.sendRedirect(request.getContextPath()+"/admin/adminGoodsList.jsp");
%>