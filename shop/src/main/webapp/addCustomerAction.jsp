<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	System.out.println("\n--------------------addCustomerAction.jsp");
	
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	boolean add = false;
	
	// 파라미터
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	String customerName = request.getParameter("customerName");
	String customerAddress = request.getParameter("customerAddress");
	String customerTelephone = request.getParameter("customerTelephone");
	
	// 디버깅
	System.out.println("customerId --- " + customerId);
	System.out.println("customerPass --- " + customerPass);
	System.out.println("customerName --- " + customerName);
	System.out.println("customerAddress --- " + customerAddress);
	System.out.println("customerTelephone --- " + customerTelephone);
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	customer.setCustomerName(customerName);
	customer.setCustomerAddress(customerAddress);
	customer.setCustomerTelephone(customerTelephone);

	CustomerService customerService = new CustomerService();
	
	add = customerService.addCustomer(customer);
	
	System.out.println("add --- " + add); // 디버깅
	
	if (!add) {
		System.out.println("회원가입 실패!");
		response.sendRedirect(request.getContextPath()+"/addMember.jsp");
		return;
	}
	
	System.out.println("회원가입 성공!");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>