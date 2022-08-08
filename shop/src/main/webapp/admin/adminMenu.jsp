<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container">
    <h1 class="text-center">
    	<%=session.getAttribute("id") %>(<%=session.getAttribute("user") %>) - <%=session.getAttribute("name") %> 님 반갑습니다. 
    </h1>
    <hr class="my-5" />
    
	<div class="text-center">
		    <button class="col btn btn-purple-moon btn-rounded" onclick="location.href='<%=request.getContextPath()%>/admin/employeeList.jsp'">사원관리</button><!-- 사원관리/권한수정 -->
		    <button class="col btn btn-ultra-voilet btn-rounded" onclick="location.href='<%=request.getContextPath()%>/admin/adminGoodsList.jsp'">상품관리</button><!-- 상품목록 / 등록 / 수정(품절) / 삭제(장바구니,주문이 없는 경우) -->
		    <button class="col btn btn-pink-moon btn-rounded" onclick="location.href='<%=request.getContextPath()%>/admin/customerList.jsp'">고객관리</button><!-- 고객목록/강제탈퇴/비밀번호수정(전달 구현X) -->
		    <button class="col btn btn-cool-blues btn-rounded">주문관리</button><!-- 주문목록/수정 -->
		    <button class="col btn btn-dark-blue btn-rounded">공지관리</button><!-- 공지CRUD -->
	</div>
	<hr class="my-5" />
</div>