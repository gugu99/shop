<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------employeeLoginAction.jsp");	

	if (session.getAttribute("user") != null) { // 로그인 상태면 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}	

	// 파라미터
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	
	// 디버깅
	System.out.println("customerId --- " + customerId);
	System.out.println("customerPass --- " + customerPass);
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	
	CustomerService customerService = new CustomerService();
	
	Customer loginCustomer = customerService.getCustomerByIdAndPw(customer);
	
	if (loginCustomer != null) {
		session.setAttribute("user", "customer");
		session.setAttribute("id", loginCustomer.getCustomerId());
		session.setAttribute("name", loginCustomer.getCustomerName());
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?cErrorMsg=Invalid ID or PW");
	}
%>