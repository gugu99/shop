<%@page import="java.io.File"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null || !((String)session.getAttribute("user")).equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라미터
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String filename = request.getParameter("filename");
	
	String dir = request.getServletContext().getRealPath("/upload"); // 이미지 폴더 경로
	
	GoodsService goodsService = new GoodsService();
	
	boolean remove = goodsService.removeGoods(goodsNo);
	
	if (!remove) {
		System.out.println("상품 삭제 실패!");
		response.sendRedirect(request.getContextPath()+"/admin/goodsAndImgOne.jsp?goodsNo="+goodsNo);
		return;
	}
	
	System.out.println("상품 삭제 성공!");
	File f = new File(dir + "/" + filename);
	if (f.exists()) {
		f.delete(); // 이미지 파일 삭제
	}
	response.sendRedirect(request.getContextPath()+"/admin/adminGoodsList.jsp");
%>