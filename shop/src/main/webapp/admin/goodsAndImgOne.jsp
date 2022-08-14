<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.Goods"%>
<%@page import="service.GoodsService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null || !session.getAttribute("user").equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

	Map<String, Object> goodsMap = null;
	GoodsService goodsService = new GoodsService();
	
	goodsMap = goodsService.getGoodsAndImgOne(goodsNo);
	
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
	<section id="form"><!--form-->
		<h2 class="text-center">상품 상세보기</h2>
		<div class="container">
			<div class="row">
				<div class="col-sm-5 col-sm-offset-1">
		            <img width="450" height="427" alt="상품이미지" src="<%=request.getContextPath() %>/upload/<%=goodsMap.get("filename")%>">
				</div>
				<div class="col-sm-6">
					<table class="table table-striped custab">
						<%
							for (String key : goodsMap.keySet()) {
								Object s = goodsMap.get(key);
						%>
					        <tr>
					            <th><%=key %></th>
					            <td><%=s %></td>
					        </tr>
					     <%
							}
					     %>
				    </table>
				</div>
			</div>
			<div class="text-right">
				<button class="btn btn-ultra-voilet btn-rounded" onclick="location.href='<%=request.getContextPath()%>/admin/modifyGoodsForm.jsp?goodsNo=<%=goodsNo%>'">상품수정</button>
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
