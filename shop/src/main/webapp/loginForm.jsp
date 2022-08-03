<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") != null) { // 로그인 상태일 경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginForm</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div>
		<%
			if (request.getParameter("errorMsg") != null) {
		%>
			<span><%=request.getParameter("errorMsg") %></span>
		<%
			}
		%>
	</div>
	<div>
		<form action="<%=request.getContextPath() %>/customerLoginAction.jsp" method="post" id="customerForm">
			<fieldset>
				<legend>쇼핑몰 고객 로그인</legend>
				<div>
					<label for="customerId">ID</label>
					<input type="text" name="customerId" id="customerId"/>
				</div>
				<div>
					<label for="customerPass">PASSWORD</label>
					<input type="password" name="customerPass" id="customerPass"/>
				</div>
				<div>
					<button type="button" id="customerBtn">고객 로그인</button>
				</div>
			</fieldset>
		</form>
	</div>
	
	<div>
		<form action="<%=request.getContextPath() %>/employeeLoginAction.jsp" method="post" id="employeeForm">
			<fieldset>
				<legend>쇼핑몰 스탭 로그인</legend>
				<div>
					<label for="employeeId">ID</label>
					<input type="text" name="employeeId" id="employeeId"/>
				</div>
				<div>
					<label for="employeePass">PASSWORD</label>
					<input type="password" name="employeePass" id="employeePass"/>
				</div>
				<div>
					<button type="button" id="employeeBtn">스탭 로그인</button>
				</div>
			</fieldset>
		</form>
	</div>
</body>
<script>
	$('#customerBtn').click(function(){
		if($('#customerId').val() == '') {
			alert('고객아이디를 입력하세요!');
		} else if($('#customerPass').val() == '') {
			alert('고객패스워드를 입력하세요!');
		} else {
			customerForm.submit();
		}
	});
	
	$('#employeeBtn').click(function(){
		if($('#employeeId').val() == '') {
			alert('스탭아이디를 입력하세요!');
		} else if($('#employeePass').val() == '') {
			alert('스탭패스워드를 입력하세요!');
		} else {
			employeeForm.submit();
		}
	});
</script>
</html>