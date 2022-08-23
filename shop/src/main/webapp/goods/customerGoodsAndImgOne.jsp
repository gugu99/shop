<%@page import="service.ReviewService"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.Goods"%>
<%@page import="service.GoodsService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

	Map<String, Object> goodsMap = null;
	GoodsService goodsService = new GoodsService();
	
	goodsMap = goodsService.getGoodsAndImgOne(goodsNo);
	
	DecimalFormat df = new DecimalFormat("###,###"); // 가격 천단위에 ,넣기
	
	// 페이징
	int currentPage = 1; // 기본값 1
	int rowPerPage = 10; // 리스트 10개씩 조회
	
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	ReviewService reviewService = new ReviewService();
	List<Map<String, Object>> reviewList = reviewService.getReviewByGoods(goodsNo, rowPerPage, currentPage);
	
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
	
	<section id="form"><!--form-->
		<h2 class="text-center">상품 상세보기</h2>
		<div class="container">
			<div class="row">
				<div class="col-sm-5 col-sm-offset-1">
		            <img width="320" height="327" alt="상품이미지" src="<%=request.getContextPath() %>/upload/<%=goodsMap.get("filename")%>">
				</div>
				<div class="col-sm-6">
					<form action="<%=request.getContextPath() %>/cart/addCartAction.jsp" method="post">
						<input type="hidden" name="goodsNo" value="<%=goodsNo %>">
				    	<input type="hidden" name="orderPrice" value="<%=goodsMap.get("goodsPrice") %>">
						<table class="table table-striped custab">
						        <tr>
						            <th>상품명</th>
						            <td><%=goodsMap.get("goodsName") %></td>
						        </tr>
						        <tr>
						            <th>가격</th>
						            <td><%=df.format(goodsMap.get("goodsPrice")) %></td>
						        </tr>
					        	
					        	<tr>
					        		<th>수량</th>
					        		<td>
					        			<button type="button" id="plusBtn" class="btn btn-light">+</button>
										<input class="text-center" type="text" name="cartQuantity" id="cartQuantity" value="" readonly>
										<button type="button" id="minusBtn" class="btn btn-light">-</button>
					        		</td>
				        		</tr>
				        		<tr>
						            <th>합계</th>
						            <td>
						            	<input class="text-right" type="text" name="orderTotalPrice" id="orderTotalPrice" value="" readonly> 원
						            </td>
						        </tr>
					    </table>
					    <div class="text-right">
					    	<button type="submit" class="btn btn-light-moon btn-rounded">장바구니 담기</button>
					    </div>
				    </form>
				    
				    <form action="<%=request.getContextPath() %>/order/addOrderForm.jsp" method="post">
				    	<input type="hidden" name="goodsNo" value="<%=goodsNo %>">
				    	<input type="hidden" name="orderPrice" value="<%=goodsMap.get("goodsPrice") %>">
				    	<input type="hidden" name="orderQuantity" id="orderQuantity" value="">
				    	<div class="text-right">
				    		<button type="submit" class="btn btn-green-moon btn-rounded">바로 구매하기</button>
				    	</div>
				    </form>
				</div>
			</div>
		</div>
	</section>
	
	<div class="container">
	    <div class="row col-md-10 col-md-offset-1 custyle">
	    <div class="text-center">
	    	<h2>리뷰</h2>
	    </div>
	    <table class="table table-striped custab">
	    	<%
	    		for (Map<String, Object> m : reviewList) {
	    	%>
	        <tr>
	            <th>작성자 :</th>
	            <td><%=m.get("customerId") %></td>
	            <th>작성일 :</th>
	            <td><%=m.get("createDate") %></td>
	            <th>수정일 :</th>
	            <td><%=m.get("updateDate") %></td>
	        </tr>
	        <tr>
	            <th>내용</th>
	            <td colspan="6"><%=m.get("reviewContent") %></td>
	        </tr>
	        <%
	    		}
	        %>
	    </table>
	    	<%
	    		if (reviewList.size() == 0) {
	    	%>
	    		<div class="text-center">
	    			등록된 리뷰가 없습니다.
	    		</div>
	    	<%
	    		}
	    	%>
	    
	    <!-- 페이징 -->
		   <%
		   		int lastPage = reviewService.getReviewByGoodsLastPage(goodsNo, rowPerPage);
		   		
		   %>
		   <div class="text-center">
		   		<ul class="pagination justify-content-center">
		   		<%	
			   		int end = (int)(Math.ceil(currentPage / (double)rowPerPage) * rowPerPage);
					int start = end - rowPerPage + 1;
					end = (end < lastPage) ? end : lastPage; // lastPage 이상이 되면 end페이지 번호가 lastPage
					if (currentPage != 1) {
				%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/goods/customerGoodsAndImgOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=1%>"><<</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/goods/customerGoodsAndImgOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=currentPage-1%>">Previous</a></li>
				<%		
					}
					for (int i = start; i <= end; i++){
				%>	
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/goods/customerGoodsAndImgOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=i%>"><%=i %></a></li>
				<%
						
					}
					if (currentPage != lastPage && lastPage != 0) {
				%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/goods/customerGoodsAndImgOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=currentPage+1%>">Next</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/goods/customerGoodsAndImgOne.jsp?goodsNo=<%=goodsNo%>&currentPage=<%=lastPage%>">>></a></li>
				<%
					}
				%>
		   		</ul>
		   </div>  
	    </div>
	</div>
	
	<%@include file="/footer.jsp" %><!-- footer -->
	
	<script>
		$(function(){
			$('#cartQuantity').val(1);
			$('#orderTotalPrice').val(<%=goodsMap.get("goodsPrice") %>);
			
			$('#plusBtn').click(function(){
				if ($('#cartQuantity').val() == 100){
					$('#cartQuantity').val($('#cartQuantity').val());
					return;
				}
				$('#cartQuantity').val(parseInt($('#cartQuantity').val())+1);
				$('#orderQuantity').val(parseInt($('#orderQuantity').val())+1);
				$('#orderTotalPrice').val(<%=goodsMap.get("goodsPrice") %>*$('#cartQuantity').val());
			});
			$('#minusBtn').click(function(){
				if ($('#cartQuantity').val() == 1){
					$('#cartQuantity').val($('#cartQuantity').val());
					return;
				}
				$('#cartQuantity').val($('#cartQuantity').val()-1);
				$('#orderQuantity').val($('#orderQuantity').val()-1);
				$('#orderTotalPrice').val(<%=goodsMap.get("goodsPrice") %>*$('#cartQuantity').val());
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
