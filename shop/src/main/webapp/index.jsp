<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null) { // 로그인 상태가 아닐 경우 loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
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
    <title>Index</title>
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
			user : <%=session.getAttribute("user") %> <!-- customer / employee -->
			<br/>
			id : <%=session.getAttribute("id") %> <!-- 로그인아이디 -->
			<br/>
			name : <%=session.getAttribute("name") %> <!-- 로그인 이름 -->
			<br/>
			<form action="<%=request.getContextPath()%>/removeMember.jsp">
				<input type="password" name="memberPass"/>
				<button type="submit">탈퇴</button>
			</form>
		</div>
		<a href="./adminIndex.jsp">관리자페이지 - 사원관리(리스트), 상품관리(리스트-삭제없음->품절로변경), 고객관리(리스트), 주문관리(리스트-배송상태), 공지관리(리스트)</a>
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
					alert('스탭아이디를 입력하세요!');
				} else if($('#employeePass').val() == '') {
					alert('스탭패스워드를 입력하세요!');
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