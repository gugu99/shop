<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	System.out.println("\n--------------------addEmployeeAction.jsp");

	// 인코딩
	request.setCharacterEncoding("UTF-8");

	boolean add = false;

	// 파라미터
	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employeePass");
	String employeeName = request.getParameter("employeeName");
	
	// 디버깅
	System.out.println("emplyeeId --- " + employeeId);
	System.out.println("employeePass --- " + employeePass);
	System.out.println("employeeName --- " + employeeName);
	
	Employee employee = new Employee();
	
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePass);
	employee.setEmployeeName(employeeName);
	
	EmployeeService employeeService = new EmployeeService();
	add = employeeService.addEmployee(employee);
	
	System.out.println("add --- " + add); // 디버깅
	
	if (!add) { 
		System.out.println("회원가입 실패!");
		response.sendRedirect(request.getContextPath()+"/addMember.jsp");
		return;
	}
	
	System.out.println("회원가입 성공!");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>