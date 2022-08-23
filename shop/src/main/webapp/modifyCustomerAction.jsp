<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	System.out.println("\n--------------------modifyCustomerAction.jsp");

	if (session.getAttribute("user") == null && session.getAttribute("user").equals("customer")) { // 로그인 상태가 아닐 경우 loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}	
	
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터
	String customerId = (String)session.getAttribute("id");
	String customerName = request.getParameter("customerName");
	String addr = request.getParameter("addr");
	String detailAddress = request.getParameter("detailAddress");
	String customerTelephone = request.getParameter("customerTelephone");
	
	String customerAddress = addr + " " + detailAddress;
	
	if (addr == null || addr.equals("")) { // 새로 입력받은 주소가 없으면
		customerAddress = request.getParameter("customerAddress"); // 기존 주소입력
	}
	
	// 디버깅
	System.out.println("customerId --- " + customerId);
	System.out.println("customerName --- " + customerName);
	System.out.println("addr --- " + addr);
	System.out.println("detailAddress --- " + detailAddress);
	System.out.println("customerAddress --- " + customerAddress);
	System.out.println("customerTelephone --- " + customerTelephone);
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerName(customerName);
	customer.setCustomerAddress(customerAddress);
	customer.setCustomerTelephone(customerTelephone);

	CustomerService customerService = new CustomerService();
	
	boolean modify = customerService.modifyCustomer(customer);
	
	System.out.println("modify --- " + modify); // 디버깅
	
	if (!modify) {
		System.out.println("회원정보 수정 실패!");
		response.sendRedirect(request.getContextPath()+"/modifyCustomerForm.jsp");
		return;
	}
	
	System.out.println("회원정보 수정 성공!");
	response.sendRedirect(request.getContextPath()+"/modifyCustomerForm.jsp");
%>