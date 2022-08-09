<%@page import="vo.Notice"%>
<%@page import="service.NoticeService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("\n--------------------adminGoodsList.jsp");	

	if (session.getAttribute("user") == null || !((String)session.getAttribute("user")).equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 페이징
	int currentPage = 1; // 기본값 1
	int rowPerPage = 10; // 리스트 10개씩 조회
	
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	NoticeService noticeService  = new NoticeService();
	List<Notice> noticeList = noticeService.getNoticeList(rowPerPage, currentPage);
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
	            <th>TITLE</th>
	            <th>CREATE_DATE</th>
	            <th>UPDATE_DATE</th>
	        </tr>
	    </thead>
	    	<%
	    		for (Notice n : noticeList) {
	    	%>
	            <tr>
	                <td><%=n.getNoticeNo() %></td>
	                <td><a href="<%=request.getContextPath() %>/admin/adminNoticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a></td>
	                <td><%=n.getCreateDate() %></td>
	                <td><%=n.getUpdateDate() %></td>
	            </tr>
	           <%
	    		}
	           %>
	    </table>
	    <div class="text-right">
	    	<button class="btn btn-dark-blue btn-rounded" onclick="location.href='<%=request.getContextPath()%>/admin/addNoticeForm.jsp'">공지등록</button>
	    </div>
	    
	    <!-- 페이징 -->
		   <%
		   		int lastPage = noticeService.getNoticeLastPage(rowPerPage);
		   		
		   %>
		   <div class="text-center">
		   		<ul class="mypagination justify-content-center">
		   		<%	
			   		int end = (int)(Math.ceil(currentPage / (double)rowPerPage) * rowPerPage);
					int start = end - rowPerPage + 1;
					end = (end < lastPage) ? end : lastPage; // lastPage 이상이 되면 end페이지 번호가 lastPage
					if (currentPage != 1) {
				%>
					<li class="page-item"><a class="page-link dark-blue" href="<%=request.getContextPath() %>/admin/adminNoticeList.jsp?currentPage=<%=1%>"><<</a></li>
					<li class="page-item"><a class="page-link dark-blue" href="<%=request.getContextPath() %>/admin/adminNoticeList.jsp?currentPage=<%=currentPage-1%>">Previous</a></li>
				<%		
					}
					for (int i = start; i <= end; i++){
				%>	
					<li class="page-item"><a class="page-link dark-blue" href="<%=request.getContextPath() %>/admin/adminNoticeList.jsp?currentPage=<%=i%>"><%=i %></a></li>
				<%
						
					}
					if (currentPage != lastPage) {
				%>
					<li class="page-item"><a class="page-link dark-blue" href="<%=request.getContextPath() %>/admin/adminNoticeList.jsp?currentPage=<%=currentPage+1%>">Next</a></li>
					<li class="page-item"><a class="page-link dark-blue" href="<%=request.getContextPath() %>/admin/adminNoticeList.jsp?currentPage=<%=lastPage%>">>></a></li>
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
