<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null || !session.getAttribute("user").equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라미터
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	
	System.out.println("customerId --- " + customerId); // 디버깅
	System.out.println("customerPass --- " + customerPass); // 디버깅
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	
	CustomerService customerService = new CustomerService();
	
	boolean modify = customerService.modifyPassByEmployee(customer);
	
	if (!modify) {
		System.out.println("비밀번호 수정 실패!");
		response.sendRedirect(request.getContextPath()+"/admin/modifyCustomerForm.jsp?customerId="+customerId);
	}
	
	System.out.println("비밀번호 수정 성공!");
	response.sendRedirect(request.getContextPath()+"/admin/customerList.jsp");
%>