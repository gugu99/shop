<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container">
    <h1 class="text-center">
    	<%=session.getAttribute("id") %>(<%=session.getAttribute("user") %>) - <%=session.getAttribute("name") %> 님 반갑습니다. 
    </h1>
    <hr class="my-5" />
    
	<div class="text-center">
		    <button class="col btn btn-purple-moon btn-rounded" onclick="location.href='<%=request.getContextPath()%>/review/reviewList.jsp'">리뷰 관리</button>
		    <button class="col btn btn-ultra-voilet btn-rounded" onclick="location.href='<%=request.getContextPath()%>/modifyCustomerForm.jsp'">회원정보 수정</button>
		    <button class="col btn btn-pink-moon btn-rounded" onclick="location.href='<%=request.getContextPath()%>/order/customerOrdersList.jsp'">주문 목록</button>
	</div>
	<hr class="my-5" />
</div>