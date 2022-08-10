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
    <title>Sign Up</title>
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
	
	<section id="form">
		<div class="container">
			<div class="row">
			<div class="col-sm-4 col-sm-offset-4">
					<div class="login-form"><!--idCheck form-->
						<h2>아이디 중복검사</h2>
						<div>
							<%
								if (request.getParameter("errorMsg") != null) { // 에러메세지가 있으면 에러메세지 출력
							%>
								<span class="error-msg"><%=request.getParameter("errorMsg") %></span>
							<%
								}
							%>
						</div>
						<form>
							<label for="ckId">ID</label>
							<input type="text" name="ckId" id="ckId" placeholder="Enter Id" />
							<button type="button" id="ckIdBtn" class="btn btn-default pull-right">아이디 중복검사</button>
						</form>
					</div><!--/idCheck form-->
				</div>
			</div>
		</div>
	</section>
	
	<section id="form"><!--form-->
		<div class="container">
			<div class="row">
				<div class="col-sm-4 col-sm-offset-2">
					<div class="signup-form"><!--customerIdCheck form-->
						<h2>고객 회원가입</h2>
						<%
							String ckId = "";
							if (request.getParameter("ckId") != null) {
								ckId = request.getParameter("ckId");
							}
						%>
						<form action="<%=request.getContextPath() %>/addCustomerAction.jsp" method="post" id="customerSignupForm">
							<label for=customerId>ID</label>
							<input type="text" name="customerId" id="customerId" value="<%=ckId %>" placeholder="아이디 중복검사를 하세요!" readonly/>
							<label for="customerPass">PASSWORD</label>
							<input type="password" name="customerPass" id="customerPass" placeholder="Enter Password" />
							<label for="customerName">NAME</label>
							<input type="text" name="customerName" id="customerName" placeholder="Enter Name" />
							<label for="customerAddress">ADDRESS</label>
							<input type="text" name="customerAddress" id="customerAddress" placeholder="Enter Address" />
							<label for="customerTelephone">Phone</label>
							<input type="text" name="customerTelephone" id="customerTelephone" placeholder="Enter PhoneNumber( - 빼고 입력)" />
							<button type="button" id="customerSignupBtn" class="btn btn-default pull-right">회원가입</button>
						</form>
					</div>
				</div>
					<div class="col-sm-1">
						<h2 class="or">OR</h2>
					</div>
				<div class="col-sm-4">
				    <div class="signup-form"><!--employeeSignup form-->
						<h2>직원 회원가입</h2>
						<%-- <%
							String ckId = "";
							if (request.getParameter("ckId") != null) {
								ckId = request.getParameter("ckId");
							}
						%> --%>
						<form action="<%=request.getContextPath() %>/addEmployeeAction.jsp" method="post" id="employeeSignupForm">
							<label for=employeeId>ID</label>
							<input type="text" name="employeeId" id="employeeId" value="<%=ckId %>" placeholder="아이디 중복검사를 하세요!" readonly/>
							<label for="employeePass">PASSWORD</label>
							<input type="password" name="employeePass" id="employeePass" placeholder="Enter Password" />
							<label for="employeeName">NAME</label>
							<input type="text" name="employeeName" id="employeeName" placeholder="Enter Name" />
							<button type="button" id="employeeSignupBtn" class="btn btn-default pull-right">회원가입</button>
						</form>
					</div><!--/employeeSignup form-->
				</div>
			</div>
		</div>
	</section><!--/form-->
	
	<%@include file="/footer.jsp" %><!-- footer -->
	
	<script>
		$(function(){ 
			$('#ckIdBtn').click(function(){
				if($('#ckId').val() == '') {
					alert('아이디를 입력하세요!');
					$('#ckId').focus();
					return;
				}
				
				if ($('#ckId').val().length < 4) {
					alert('아이디를 4자이상 입력해주세요!');
					$('#ckId').focus();
					return;
				}
				
				$.ajax({
					url : '/shop/idckController',
					type : 'post',
					data : {ckId : $('#ckId').val()},
					success : function(json) {
						if (json == 'n') {
							alert('이미 사용중인 아이디입니다.');
							$('#customerId').val('');
							$('#employeeId').val('');
							$('#ckId').focus();
							return;
						}
						$('#customerId').val($('#ckId').val());
						$('#employeeId').val($('#ckId').val());
					}
				});
			});
		});
		
		$(function(){ 
			$('#customerSignupBtn').click(function(){
				if($('#customerId').val() == '') {
					alert('아이디 중복검사를 하세요!');
				} else if($('#customerPass').val() == '') {
					alert('고객 패스워드를 입력하세요!');
				} else if($('#customerName').val() == '') {
					alert('고객 이름을 입력하세요!');
				} else if($('#customerAddress').val() == '') {
					alert('고객 주소를 입력하세요!');
				} else if($('#customerTelephone').val() == '') {
					alert('고객 전화번호를 입력하세요!');
				} else {
					customerSignupForm.submit();
				}
			});
		});
		
		$(function(){ 
			$('#employeeSignupBtn').click(function(){
				if($('#employeeId').val() == '') {
					alert('아이디 중복검사를 하세요!');
				} else if($('#employeePass').val() == '') {
					alert('직원 패스워드를 입력하세요!');
				} else if($('#employeeName').val() == '') {
					alert('직원 이름을 입력하세요!');
				} else {
					employeeSignupForm.submit();
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