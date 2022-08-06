<%@page import="vo.Employee"%>
<%@page import="java.util.List"%>
<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null) { // 로그인 상태가 아닐 경우 loginForm.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}	

	// 페이징
	int currentPage = 1; // 기본값 1
	int rowPerPage = 10; // 리스트 10개씩 조회
	
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	EmployeeService employeeService = new EmployeeService();
	List<Employee> employeeList = employeeService.getEmployeeList(rowPerPage, currentPage);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Admin Index</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet">
	<link href="css/button-menu.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/favicon.ico" type="umage/x-icon" />
	<link rel="icon" href="images/favicon.ico" type="umage/x-icon" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head><!--/head-->

<body>
	
	<%@include file="/header.jsp" %><!-- header -->
	
	<!-- button menu -->
	<div class="container">
	    <h1 class="text-center">
	    	<%=session.getAttribute("id") %>(<%=session.getAttribute("user") %>) - <%=session.getAttribute("name") %> 님 반갑습니다. 
	    </h1>
	    <hr class="my-5" />
	    
		<div class="text-center">
			    <button class="col btn btn-purple-moon btn-rounded" onclick="location.href='<%=request.getContextPath()%>/employeeList.jsp'">사원관리</button>
			    <button class="col btn btn-ultra-voilet btn-rounded">상품관리</button>
			    <button class="col btn btn-pink-moon btn-rounded">고객관리</button>
			    <button class="col btn btn-cool-blues btn-rounded">주문관리</button>
			    <button class="col btn btn-dark-blue btn-rounded">공지관리</button>
		</div>
		<hr class="my-5" />
	</div><!-- button menu end -->
	
	<!-- employeeList -->
	<div class="container">
	    <div class="row col-md-8 col-md-offset-2 custyle">
	    <table class="table table-striped custab">
	    <thead>
	        <tr>
	            <th>ID</th>
	            <th>NAME</th>
	            <th>CREATE_DATE</th>
	            <th>UPDATE_DATE</th>
	            <th class="text-center">ACTIVE</th>
	        </tr>
	    </thead>
	    	<%
	    		for (Employee e : employeeList) {
	    	%>
	            <tr>
	                <td><%=e.getEmployeeId() %></td>
	                <td><%=e.getEmployeeName() %></td>
	                <td><%=e.getCreateDate() %></td>
	                <td><%=e.getUpdateDate() %></td>
	                <td class="text-center">
	                	<form action="<%=request.getContextPath() %>/modifyEmployeeActiveAction.jsp" method="post">
	                		<input type="hidden" name="employeeId" value="<%=e.getEmployeeId() %>" />
	                		<input type="hidden" name="employeeActive" value="<%=e.getActive() %>" />
	                		<%
	                			if(e.getActive().equals("N")) {
	                		%>
	                			<input type="radio" name="active" value="Y"  id="Y"   />
								<label for="Y">Y</label>
								<input type="radio" name="active" value="N"  id="N"  checked/>
								<label for="N">N</label>
	                		<%
	                			} else {
	                		%>
	                			<input type="radio" name="active" value="Y"  id="Y"  checked />
								<label for="Y">Y</label>
								<input type="radio" name="active" value="N"  id="N" />
								<label for="N">N</label>
	                		<%
	                			}
	                		%>
	                		
						    <button type="submit" class="btn btn-info btn-xs"><span class="glyphicon glyphicon-edit"></span> Edit</button>
						</form>
	                </td>
	            </tr>
	           <%
	    		}
	           %>
	    </table>
	    
	    <!-- 페이징 -->
		   <%
		   		int lastPage = employeeService.getEmployeeLastPage(rowPerPage);
		   		
		   %>
		   <div class="text-center">
		   		<ul class="mypagination justify-content-center">
		   		<%	
			   		int end = (int)(Math.ceil(currentPage / (double)rowPerPage) * rowPerPage);
					int start = end - rowPerPage + 1;
					end = (end < lastPage) ? end : lastPage; // lastPage 이상이 되면 end페이지 번호가 lastPage
					if (currentPage != 1) {
				%>
					<li class="page-item"><a class="page-link purple-moon" href="<%=request.getContextPath() %>/employeeList.jsp?currentPage=<%=1%>"><<</a></li>
					<li class="page-item"><a class="page-link purple-moon" href="<%=request.getContextPath() %>/employeeList.jsp?currentPage=<%=currentPage-1%>">Previous</a></li>
				<%		
					}
					for (int i = start; i <= end; i++){
				%>	
					<li class="page-item"><a class="page-link purple-moon" href="<%=request.getContextPath() %>/employeeList.jsp?currentPage=<%=i%>"><%=i %></a></li>
				<%
						
					}
					if (currentPage != lastPage) {
				%>
					<li class="page-item"><a class="page-link purple-moon" href="<%=request.getContextPath() %>/employeeList.jsp?currentPage=<%=currentPage+1%>">Next</a></li>
					<li class="page-item"><a class="page-link purple-moon" href="<%=request.getContextPath() %>/employeeList.jsp?currentPage=<%=lastPage%>">>></a></li>
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
