<%@page import="vo.Notice"%>
<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") == null || !session.getAttribute("user").equals("employee")) { // 로그인상태가 아닌경우 loginForm.jsp로 이동 -> 로그인상태지만 사원이 아닌경우 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));

	NoticeService noticeService = new NoticeService();
	
	Notice notice = noticeService.getNoticeOne(noticeNo);
	
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
		<div class="container">
			<div class="row">
				<div class="col-md-10 col-md-offset-1">
					<table class="table custab">
				        <tr>
				            <th>공지 번호 :</th>
				            <td><%=notice.getNoticeNo() %></td>
				            <th>작성일 :</th>
				            <td><%=notice.getCreateDate() %></td>
				            <th>수정일 :</th>
				            <td><%=notice.getUpdateDate() %></td>
				        </tr>
				        <tr>
				        	<th>제목 :</th>
				            <td colspan="6"><%=notice.getNoticeTitle() %></td>
				        </tr>
				        <tr>
				            <th>내용</th>
				            <td colspan="6"><%=notice.getNoticeContent() %></td>
				        </tr>
				    </table>
				    <div class="text-right">
						<button class="btn btn-dark-blue btn-rounded" onclick="location.href='<%=request.getContextPath()%>/admin/modifyNoticeForm.jsp?noticeNo=<%=noticeNo%>'">공지수정</button>
						<button class="btn btn-orange-moon btn-rounded" onclick="location.href='<%=request.getContextPath()%>/admin/removeNoticeAction.jsp?noticeNo=<%=noticeNo%>'">공지삭제</button>
				    </div>
				</div>
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
