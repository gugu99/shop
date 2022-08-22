<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null && session.getAttribute("user").equals("customer")) { // 로그인 상태가 아닐 경우 loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}	
	
	String customerId = (String)session.getAttribute("id");
	
	//페이징
	int currentPage = 1; // 기본값 1
	int rowPerPage = 10; // 리스트 10개씩 조회
	
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	DecimalFormat df = new DecimalFormat("###,###"); // 가격 천단위에 ,넣기
	
	OrdersService ordersService = new OrdersService();
	List<Map<String, Object>> ordersList = ordersService.getOrdersListByCustomer(customerId, rowPerPage, currentPage);
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
	
	<%@include file="/customerMenu.jsp" %><!-- button menu -->
	
	<div class="container">
	    <div class="row col-md-12  custyle">
	    <table class="table table-striped custab">
	    <thead>
	        <tr>
	            <th>ORDER NO</th>
	            <th>CUSTOMER ID</th>
	            <th>GOODS NAME</th>
	            <th>ORDER PRICE</th>
	            <th>ORDER QUANTITY</th>
	            <th>CREATE DATE</th>
	            <th>UPDATE DATE</th>
	            <th>ORDER STATE</th>
	        </tr>
	    </thead>
	    	<%
	    		for (Map<String, Object> o : ordersList) {
	    	%>
	            <tr>
	                <td><a href="<%=request.getContextPath() %>/order/customerOrdersOne.jsp?orderNo=<%=o.get("orderNo") %>"><%=o.get("orderNo")%></a></td>
	                <td><%=o.get("customerId") %></td>
	                <td><%=o.get("goodsName") %></td>
	                <td><%=df.format(o.get("orderPrice")) %></td>
	                <td><%=o.get("orderQuantity") %></td>
	                <td><%=o.get("createDate") %></td>
	                <td><%=o.get("updateDate") %></td>
	                <td>
	                	<form action="<%=request.getContextPath() %>/order/modifyOrderStateAction.jsp" method="post">
	                		<%=o.get("orderState") %>
	                		<input type="hidden" name="orderNo" value="<%=o.get("orderNo") %>" />
	                		<input type="hidden" name="orderState" value="취소" />
	                		<%
	                			if (!o.get("orderState").equals("취소")) {
	                		%>
						    <button type="submit" class="btn btn-danger btn-xs">
						    	<span class="glyphicon glyphicon-edit"></span> 취소
						    </button>
						    <%
	                			}
						    %>
						</form>
	                </td>
	            </tr>
	           <%
	    		}
	           %>
	    </table>
	    
	    <!-- 페이징 -->
		   <%
		   		int lastPage = ordersService.getOrdersListLastPage(rowPerPage);
		   		
		   %>
		   <div class="text-center">
		   		<ul class="mypagination justify-content-center">
		   		<%	
			   		int end = (int)(Math.ceil(currentPage / (double)rowPerPage) * rowPerPage);
					int start = end - rowPerPage + 1;
					end = (end < lastPage) ? end : lastPage; // lastPage 이상이 되면 end페이지 번호가 lastPage
					if (currentPage != 1) {
				%>
					<li class="page-item"><a class="page-link pink-moon" href="<%=request.getContextPath() %>/order/customerOrdersList.jsp?currentPage=<%=1%>"><<</a></li>
					<li class="page-item"><a class="page-link pink-moon" href="<%=request.getContextPath() %>/order/customerOrdersList.jsp?currentPage=<%=currentPage-1%>">Previous</a></li>
				<%		
					}
					for (int i = start; i <= end; i++){
				%>	
					<li class="page-item"><a class="page-link pink-moon" href="<%=request.getContextPath() %>/order/customerOrdersList.jsp?currentPage=<%=i%>"><%=i %></a></li>
				<%
						
					}
					if (currentPage != lastPage && lastPage != 0) {
				%>
					<li class="page-item"><a class="page-link pink-moon" href="<%=request.getContextPath() %>/order/customerOrdersList.jsp?currentPage=<%=currentPage+1%>">Next</a></li>
					<li class="page-item"><a class="page-link pink-moon" href="<%=request.getContextPath() %>/order/customerOrdersList.jsp?currentPage=<%=lastPage%>">>></a></li>
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