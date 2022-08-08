<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null || !((String)session.getAttribute("user")).equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
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
    <title>Admin Index</title>
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
	
	<section id="form">
		<div class="container">
			<div class="row">
			<div class="col-sm-6 col-sm-offset-3">
					<div class="form-group">
						<h2>상품 등록</h2>
						<form action="<%=request.getContextPath()%>/admin/addGoodsAction.jsp" method="post" enctype="multipart/form-data">
							<table class="table table-striped custab">
								<tr>
									<th>상품 이름</th>
									<td>
										<input type="text" name="goodsName" id="goodsName" class="form-control" placeholder="Enter goodsName" />
									</td>
								</tr>
								<tr>
									<th>상품 가격</th>
									<td>
										<input type="text" name="goodsPrice" id="goodsPrice" class="form-control" placeholder="Enter goodsPrice" />
									</td>
								</tr>
								<tr>
									<th>품절 여부</th>
									<td>
										<input type="radio" name="soldOut" value="Y"  id="Y"/>
										<label for="Y">Y</label>
										<input type="radio" name="soldOut" value="N"  id="N" checked/>
										<label for="N">N</label>
									</td>
								</tr>
								<tr>
									<th>상품 이미지</th>
									<td>
										<input type="file" name="imgFile" id="imgFile"/>
									</td>
								</tr>
							</table>
							<div class="text-right">
								<button type="submit" class="btn btn-ultra-voilet btn-rounded">상품 등록</button>
							</div>
						</form>
					</div>
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