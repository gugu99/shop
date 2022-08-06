<%@page import="service.EmployeeService"%>
<%@page import="repository.EmployeeDao"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------employeeLoginAction.jsp");
	
	if (session.getAttribute("user") != null) { // 로그인 상태면 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}

	// 	파라미터
	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employeePass");
	
	// 디버깅
	System.out.println("employeeId --- " + employeeId);
	System.out.println("employeePass --- " + employeePass);
	
	Employee employee = new Employee();
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePass);
	
	System.out.println("employee --- " + employee); // 디버깅
	
	EmployeeService employeeService = new EmployeeService();
	
	Employee loginEmployee = employeeService.getEmployeeByIdAndPw(employee);
	
	System.out.println("loginEmployee --- " + loginEmployee); // 디버깅
	
	if (loginEmployee != null && loginEmployee.getActive().equals("Y")) {
		session.setAttribute("user", "employee");
		session.setAttribute("id", loginEmployee.getEmployeeId());
		session.setAttribute("name", loginEmployee.getEmployeeName());
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?errorMsg=Invalid ID or PW");
	}
%>