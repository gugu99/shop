<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null) { // 로그인 상태가 아닐 경우 loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}	

	String customerId = request.getParameter("customerId");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>GUGU99 SHOP</title>
    <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/font-awesome.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/prettyPhoto.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/price-range.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/animate.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/css/main.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/css/responsive.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/css/button-menu.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/images/favicon.ico" type="umage/x-icon" />
	<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" type="umage/x-icon" />
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head><!--/head-->

<body>
	
	<%@include file="/header.jsp" %><!-- header -->
	
	<%@include file="/admin/adminMenu.jsp" %><!-- button menu -->
	
	<section id="form"><!--form-->
		<div class="container">
			<div class="row">
				<div class="col-md-10 col-md-offset-1">
					<form action="<%=request.getContextPath()%>/admin/modifyCustomerPassAction.jsp" method="post">
						<input type="hidden" name="customerId" value="<%=customerId%>"/>
						<table class="table custab">
					        <tr>
					            <th>고객 비밀번호 수정</th>
					            <td colspan="2">
					            	<input class="form-control" type="password" name="customerPass"/>
					            </td>
					            <td>
					            	<button class="btn btn-pink-moon btn-rounded" type="submit">수정하기</button>
					            </td>
					        </tr>
					    </table>
					    <div class="text-right">
							<a class="btn btn-orange-moon btn-rounded" href="<%=request.getContextPath()%>/admin/removeCustomerAction.jsp?customerId=<%=customerId%>">강제탈퇴</a>
					    </div>
					</form>
				</div>
			</div>
		</div>
	</section>
	
	<%@include file="/footer.jsp" %><!-- footer -->
	
    <script src="js/jquery.js"></script>
	<script src="js/price-range.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
</body>
</html>