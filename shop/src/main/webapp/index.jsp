<%@page import="service.CounterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null) { // 로그인 상태가 아닐 경우 loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}	

	// CounterService counterService = new CounterService();
	
	// 방문자 수 구하기
	// 총방문자
	int totalCount = new CounterService().getTotalCount();
	// 오늘방문자
	int todayCount = new CounterService().getTodayCount();
	// 현재 접속자 수
	int currentCount = (Integer)(application.getAttribute("currentCounter"));
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
			<h1 class="text-center">
		    	<%=session.getAttribute("id") %>(<%=session.getAttribute("user") %>) - <%=session.getAttribute("name") %> 님 반갑습니다. 
		    </h1>
		</div>
	</section><!--/form-->
	
	<section id="form"><!--form-->
		<div class="container">
			<h3 class="text-center">
		    	오늘 방문자 수 : <%=todayCount %> 
				<br/>
				현재 방문자 수 : <%=currentCount %> 
				<br/>
				전체 방문자 수 : <%=totalCount %> 
		    </h3>
		</div>
	</section><!--/form-->
	
	<%@include file="/footer.jsp" %><!-- footer -->
	
    <script src="js/jquery.js"></script>
	<script src="js/price-range.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
</body>
</html>