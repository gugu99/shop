<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------modifyEmployeeActiveAction.jsp");
	// 파라미터
	String employeeId = request.getParameter("employeeId");
	String employeeActive = request.getParameter("employeeActive"); // 기존 권한
	String active = request.getParameter("active"); // 새로 부여할 권한
	
	System.out.println("employeeId --- " + employeeId); // 디버깅
	System.out.println("employeeActive --- " + employeeActive); // 디버깅
	System.out.println("active --- " + active); // 디버깅
	
	if (employeeActive.equals(active)) { // 부여할 권한이 변동사항 없으면 employeeList.jsp로 이동
		System.out.println("부여할 권한이 동일합니다.");
		response.sendRedirect(request.getContextPath()+"/employeeList.jsp");
		return;
	}
	
	Employee employee = new Employee();
	employee.setEmployeeId(employeeId);
	employee.setActive(active);
	
	EmployeeService employeeService = new EmployeeService();
	boolean modifyActive = employeeService.modifyEmployeeActive(employee);
	
	System.out.println("modifyActive --- " + modifyActive); // 디버깅
	
	if (!modifyActive) {
		System.out.println("권한 수정 실패!");
		response.sendRedirect(request.getContextPath()+"/employeeList.jsp");
	}
	
	System.out.println("권한 수정 성공!");
	response.sendRedirect(request.getContextPath()+"/employeeList.jsp");
%>