<%@page import="service.CartService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
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
	
	CartService cartService = new CartService();
	List<Map<String, Object>> cartList = cartService.getCartByCustomer(customerId, rowPerPage, currentPage);
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
	
	
	<div class="container">
	    <div class="row col-md-12 custyle">
	    <div class="text-center">
	    	<h2>장바구니</h2>
	    </div>
	   
	    	 <table class="table table-striped custab">
	    	<%
	    		for (Map<String, Object> m : cartList) {
	    	%>
	        <tr>
	        	<td><img width="50" height="50" alt="상품이미지" src="<%=request.getContextPath()%>/upload/<%=m.get("filename")%>"></td>
	            <th>상품명 :</th>
	            <td><%=m.get("goodsName") %></td>
	            <th>상품가격 :</th>
	            <td><%=m.get("goodsPrice") %></td>
	            <th>상품수량 :</th>
	            <td>
	            	 <form action="<%=request.getContextPath()%>/cart/modifyCartQuantityAction.jsp" method="post">
	            		 <input type="hidden" name="goodsNo" value="<%=m.get("goodsNo") %>">
		            	<input type="number" name="cartQuantity" value="<%=m.get("cartQuantity") %>">
		            	<button type="submit" class="btn btn-warning btn-xs">
					    	<span class="glyphicon glyphicon-edit"></span> 수정
				   	    </button>
				    </form>
	            </td>
	            <td>
	            	 <form action="<%=request.getContextPath()%>/order/addOrderForm.jsp" method="post">
	            	 	<input type="hidden" name="cart" value="cart">
		            	<input type="hidden" name="goodsNo" value="<%=m.get("goodsNo") %>">
		            	<input type="hidden" name="orderPrice" value="<%=m.get("goodsPrice") %>">
		            	<input type="hidden" name="orderQuantity" value="<%=m.get("cartQuantity") %>">
		            	<button type="submit" class="btn btn-info btn-xs">
					    	<span class="glyphicon glyphicon-edit"></span> 주문
					    </button>
				     </form>
				    <button type="button" class="btn btn-danger btn-xs" onclick="location.href='<%=request.getContextPath()%>/cart/removeCartAction.jsp?goodsNo=<%=m.get("goodsNo")%>'">
				    	<span class="glyphicon glyphicon-edit"></span> 삭제
				    </button>
	            </td>
	        </tr>
	        
	        <%
	    		}
	        %>
	    </table>
	   
	   
	    	<%
	    		if (cartList.size() == 0) {
	    	%>
	    		<div class="text-center">
	    			장바구니 목록이 없습니다.
	    		</div>
	    	<%
	    		}
	    	%>
	    
	    <!-- 페이징 -->
		   <%
		   		int lastPage = cartService.getCartByCustomerLastPage(customerId, rowPerPage);
		   		
		   %>
		   <div class="text-center">
		   		<ul class="pagination justify-content-center">
		   		<%	
			   		int end = (int)(Math.ceil(currentPage / (double)rowPerPage) * rowPerPage);
					int start = end - rowPerPage + 1;
					end = (end < lastPage) ? end : lastPage; // lastPage 이상이 되면 end페이지 번호가 lastPage
					if (currentPage != 1) {
				%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/cart/cartList.jsp?currentPage=<%=1%>"><<</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/cart/cartList.jsp?currentPage=<%=currentPage-1%>">Previous</a></li>
				<%		
					}
					for (int i = start; i <= end; i++){
				%>	
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/cart/cartList.jsp?currentPage=<%=i%>"><%=i %></a></li>
				<%
						
					}
					if (currentPage != lastPage && lastPage != 0) {
				%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/cart/cartList.jsp?currentPage=<%=currentPage+1%>">Next</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/cart/cartList.jsp?currentPage=<%=lastPage%>">>></a></li>
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