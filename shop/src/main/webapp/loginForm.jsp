<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") != null) { // 로그인 상태면 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Login</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/favicon.ico" type="umage/x-icon" />
	<link rel="icon" href="images/favicon.ico" type="umage/x-icon" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head><!--/head-->

<body>
	
	<%@include file="/header.jsp" %><!-- header -->
	
	<section id="form"><!--form-->
		<div class="container">
		<div>
			<%
				if (request.getParameter("errorMsg") != null) { // 에러메세지가 있으면 에러메세지 출력
			%>
				<span class="error-msg"><%=request.getParameter("errorMsg") %></span>
			<%
				}
			%>
		</div>
			<div class="row">
				<div class="col-sm-4 col-sm-offset-1">
					<div class="login-form"><!--customerLogin form-->
						<h2>고객 로그인</h2>
						<form action="<%=request.getContextPath() %>/customerLoginAction.jsp" method="post" id="customerForm">
							<label for="customerId">ID</label>
							<input type="text" name="customerId" id="customerId" placeholder="Enter Id" />
							<label for="customerPass">PASSWORD</label>
							<input type="password" name="customerPass" id="customerPass" placeholder="Enter Password" />
							<span>
								<input type="checkbox" class="checkbox"> 
								Keep me signed in
							</span>
							<button type="button" id="customerBtn" class="btn btn-default pull-right">로그인</button>
						</form>
					</div><!--/customerLogin form-->
				</div>
				<div class="col-sm-1">
					<h2 class="or">OR</h2>
				</div>
				<div class="col-sm-4">
					<div class="login-form"><!--employeeLogin form-->
						<h2>직원 로그인</h2>
						<form action="<%=request.getContextPath() %>/employeeLoginAction.jsp" method="post" id="employeeForm">
							<label for="employeeId">ID</label>
							<input type="text" name="employeeId" id="employeeId" placeholder="Enter Id" />
							<label for="employeePass">PASSWORD</label>
							<input type="password" name="employeePass" id="employeePass" placeholder="Enter Password" />
							<span>
								<input type="checkbox" class="checkbox"> 
								Keep me signed in
							</span>
							<button type="button" id="employeeBtn" class="btn btn-default pull-right">로그인</button>
						</form>
					</div><!--/employeeLogin form-->
				</div>
			</div>
		</div>
	</section><!--/form-->
	
	<%@include file="/footer.jsp" %><!-- footer -->
	
	<script>
		$(function(){ 
			$('#customerBtn').click(function(){
				if($('#customerId').val() == '') {
					alert('고객아이디를 입력하세요!');
				} else if($('#customerPass').val() == '') {
					alert('고객패스워드를 입력하세요!');
				} else {
					customerForm.submit();
				}
			});
		});
		
		$(function(){ 
			$('#employeeBtn').click(function(){
				if($('#employeeId').val() == '') {
					alert('직원아이디를 입력하세요!');
				} else if($('#employeePass').val() == '') {
					alert('직원패스워드를 입력하세요!');
				} else {
					employeeForm.submit();
				}
			});
		});
	</script>
	
    <script src="js/jquery.js"></script>
	<script src="js/price-range.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
</body>
</html>