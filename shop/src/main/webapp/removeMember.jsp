<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------removeMember.jsp");

	if (session.getAttribute("user") == null) { // 로그인 상태가 아닐 경우 loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	boolean remove = false;
	String memberId = (String)session.getAttribute("id");
	String memberPass = request.getParameter("memberPass");
	
	System.out.println("memberId --- " + memberId); // 디버깅
	System.out.println("memberPass --- " + memberPass); // 디버깅
	
	if (session.getAttribute("user").equals("customer")) { // 로그인한 회원이 customer일떄
		Customer customer = new Customer();
		customer.setCustomerId(memberId);
		customer.setCustomerPass(memberPass);
		
		CustomerService customerService = new CustomerService();
		
		remove = customerService.removeCustomer(customer);
	} else { // 로그인한 회원이 employee일때
		Employee employee = new Employee();
		employee.setEmployeeId(memberId);
		employee.setEmployeePass(memberPass);
		
		EmployeeService employeeService = new EmployeeService();
		
		remove = employeeService.removeEmployee(employee);
	}
	
	
	System.out.println("remove --- " + remove); // 디버깅
	
	if (!remove) {
		System.out.println("탈퇴 실패!");
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	
	System.out.println("탈퇴 성공!");
	response.sendRedirect(request.getContextPath()+"/logout.jsp");
%>