<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------removeCustomerAction.jsp");

	if (session.getAttribute("user") == null || !session.getAttribute("user").equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라미터
	String customerId = request.getParameter("customerId");
	
	System.out.println("customerId --- " + customerId); // 디버깅
	
	CustomerService customerService = new CustomerService();
	boolean remove = customerService.removeCustomerByEmployee(customerId);
	
	if (!remove) {
		System.out.println("강제 회원탈퇴 실패!");
		response.sendRedirect(request.getContextPath()+"/admin/modifyCustomerForm.jsp?customerId="+customerId);
		return;
	} 
	
	System.out.println("강제 회원탈퇴 성공!");
	response.sendRedirect(request.getContextPath()+"/admin/customerList.jsp");
%>