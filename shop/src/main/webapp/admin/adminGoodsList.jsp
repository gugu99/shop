<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.Goods"%>
<%@page import="service.GoodsService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------adminGoodsList.jsp");	

	if (session.getAttribute("user") == null || !session.getAttribute("user").equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 페이징
	int currentPage = 1; // 기본값 1
	int rowPerPage = 10; // 리스트 10개씩 조회
	
	DecimalFormat df = new DecimalFormat("###,###"); // 가격 천단위에 ,넣기
	
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	GoodsService goodsService = new GoodsService();
	List<Goods> goodsList = goodsService.getGoodsListByPage(rowPerPage, currentPage);
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
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head><!--/head-->

<body>
	
	<%@include file="/header.jsp" %><!-- header -->
	
	<%@include file="/admin/adminMenu.jsp" %><!-- button menu -->
	
	<!-- customerList -->
	<div class="container">
	    <div class="row col-md-10 col-md-offset-1 custyle">
	    <table class="table table-striped custab">
	    <thead>
	        <tr>
	            <th>NO</th>
	            <th>NAME</th>
	            <th>PRICE</th>
	            <th>CREATE_DATE</th>
	            <th>UPDATE_DATE</th>
	            <th>SOLDOUT</th>
	        </tr>
	    </thead>
	    	<%
	    		for (Goods g : goodsList) {
	    	%>
	            <tr>
	                <td><%=g.getGoodsNo() %></td>
	                <td><a href="<%=request.getContextPath() %>/admin/goodsAndImgOne.jsp?goodsNo=<%=g.getGoodsNo() %>"><%=g.getGoodsName() %></a></td>
	                <td><%=df.format(g.getGoodsPrice()) %></td>
	                <td><%=g.getCreateDate() %></td>
	                <td><%=g.getUpdateDate() %></td>
	                 <td>
	                	<form action="<%=request.getContextPath() %>/admin/modifyGoodsSoldOutAction.jsp" method="post">
	                		<input type="hidden" name="goodsNo" value="<%=g.getGoodsNo() %>" />
	                		<%
	                			if(g.getSoldOut().equals("N")) {
	                		%>
	                			<input type="radio" name="soldOut" value="Y"  id="Y"   />
								<label for="Y">Y</label>
								<input type="radio" name="soldOut" value="N"  id="N"  checked/>
								<label for="N">N</label>
	                		<%
	                			} else {
	                		%>
	                			<input type="radio" name="soldOut" value="Y"  id="Y"  checked />
								<label for="Y">Y</label>
								<input type="radio" name="soldOut" value="N"  id="N" />
								<label for="N">N</label>
	                		<%
	                			}
	                		%>
	                		
						    <button type="submit" class="btn btn-info btn-xs">
						    	<span class="glyphicon glyphicon-edit"></span> Edit
						    </button>
						</form>
	                </td>
	            </tr>
	           <%
	    		}
	           %>
	    </table>
	    <div class="text-right">
	    	<button class="btn btn-ultra-voilet btn-rounded" onclick="location.href='<%=request.getContextPath()%>/admin/addGoodsForm.jsp'">상품등록</button>
	    </div>
	    
	    <!-- 페이징 -->
		   <%
		   		int lastPage = goodsService.getGoodsListLastPage(rowPerPage);
		   		
		   %>
		   <div class="text-center">
		   		<ul class="mypagination justify-content-center">
		   		<%	
			   		int end = (int)(Math.ceil(currentPage / (double)rowPerPage) * rowPerPage);
					int start = end - rowPerPage + 1;
					end = (end < lastPage) ? end : lastPage; // lastPage 이상이 되면 end페이지 번호가 lastPage
					if (currentPage != 1) {
				%>
					<li class="page-item"><a class="page-link ultra-voilet" href="<%=request.getContextPath() %>/admin/adminGoodsList.jsp?currentPage=<%=1%>"><<</a></li>
					<li class="page-item"><a class="page-link ultra-voilet" href="<%=request.getContextPath() %>/admin/adminGoodsList.jsp?currentPage=<%=currentPage-1%>">Previous</a></li>
				<%		
					}
					for (int i = start; i <= end; i++){
				%>	
					<li class="page-item"><a class="page-link ultra-voilet" href="<%=request.getContextPath() %>/admin/adminGoodsList.jsp?currentPage=<%=i%>"><%=i %></a></li>
				<%
						
					}
					if (currentPage != lastPage) {
				%>
					<li class="page-item"><a class="page-link ultra-voilet" href="<%=request.getContextPath() %>/admin/adminGoodsList.jsp?currentPage=<%=currentPage+1%>">Next</a></li>
					<li class="page-item"><a class="page-link ultra-voilet" href="<%=request.getContextPath() %>/admin/adminGoodsList.jsp?currentPage=<%=lastPage%>">>></a></li>
				<%
					}
				%>
		   		</ul>
		   </div>  
	    </div>
	</div>
		
	<%@include file="/footer.jsp" %><!-- footer -->
	
    <script src="js/jquery.js"></script>
	<script src="js/price-range.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
