<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="service.ReviewService"%>
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
	
	ReviewService reviewService = new ReviewService();
	List<Map<String, Object>> reviewList = reviewService.getReviewByCustomer(customerId, rowPerPage, currentPage);
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
	    <div class="row col-md-10 col-md-offset-1 custyle">
	    <div class="text-center">
	    	<h2>리뷰</h2>
	    </div>
	    <form action="<%=request.getContextPath()%>/review/modifyReviewAction.jsp" method="post">
	    	 <table class="table table-striped custab">
	    	<%
	    		for (Map<String, Object> m : reviewList) {
	    	%>
	        <tr>
	        	<th>주문번호 :</th>
	            <td><input type="text" name="orderNo" value="<%=m.get("orderNo") %>" readonly></td>
	            <th>상품명 :</th>
	            <td><%=m.get("goodsName") %></td>
	            <th>작성일 :</th>
	            <td><%=m.get("createDate") %></td>
	            <th>수정일 :</th>
	            <td><%=m.get("updateDate") %></td>
	        </tr>
	        <tr>
	            <th>내용</th>
	            <td colspan="6"><textarea rows="3" class="form-control" name="reviewContent"><%=m.get("reviewContent") %></textarea></td>
	            <td class="text-right">
	            	<button type="submit" class="btn btn-info btn-xs">
				    	<span class="glyphicon glyphicon-edit"></span> Edit
				    </button>
				    <button type="button" class="btn btn-danger btn-xs" onclick="location.href='<%=request.getContextPath()%>/review/removeReviewAction.jsp?orderNo=<%=m.get("orderNo")%>'">
				    	<span class="glyphicon glyphicon-edit"></span> Del
				    </button>
	            </td>
	        </tr>
	        <%
	    		}
	        %>
	    </table>
	    </form>
	   
	    	<%
	    		if (reviewList.size() == 0) {
	    	%>
	    		<div class="text-center">
	    			등록한 리뷰가 없습니다.
	    		</div>
	    	<%
	    		}
	    	%>
	    
	    <!-- 페이징 -->
		   <%
		   		int lastPage = reviewService.getReviewByCustomerLastPage(customerId, rowPerPage);
		   		
		   %>
		   <div class="text-center">
		   		<ul class="mypagination justify-content-center">
		   		<%	
			   		int end = (int)(Math.ceil(currentPage / (double)rowPerPage) * rowPerPage);
					int start = end - rowPerPage + 1;
					end = (end < lastPage) ? end : lastPage; // lastPage 이상이 되면 end페이지 번호가 lastPage
					if (currentPage != 1) {
				%>
					<li class="page-item"><a class="page-link purple-moon" href="<%=request.getContextPath() %>/review/reviewList.jsp?currentPage=<%=1%>"><<</a></li>
					<li class="page-item"><a class="page-link purple-moon" href="<%=request.getContextPath() %>/review/reviewList.jsp?currentPage=<%=currentPage-1%>">Previous</a></li>
				<%		
					}
					for (int i = start; i <= end; i++){
				%>	
					<li class="page-item"><a class="page-link purple-moon" href="<%=request.getContextPath() %>/review/reviewList.jsp?currentPage=<%=i%>"><%=i %></a></li>
				<%
						
					}
					if (currentPage != lastPage && lastPage != 0) {
				%>
					<li class="page-item"><a class="page-link purple-moon" href="<%=request.getContextPath() %>/review/reviewList.jsp?currentPage=<%=currentPage+1%>">Next</a></li>
					<li class="page-item"><a class="page-link purple-moon" href="<%=request.getContextPath() %>/review/reviewList.jsp?currentPage=<%=lastPage%>">>></a></li>
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