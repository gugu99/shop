<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("user") != null) { // 로그인 상태면 index.jsp로 이동
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Sign Up</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet">
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head><!--/head-->

<body>
	
	<%@include file="/header.jsp" %><!-- header -->
	
	<section id="form">
		<div class="container">
			<div class="row">
			<div class="col-sm-4 col-sm-offset-4">
					<div class="login-form"><!--idCheck form-->
						<h2>아이디 중복검사</h2>
						<div>
							<%
								if (request.getParameter("errorMsg") != null) { // 에러메세지가 있으면 에러메세지 출력
							%>
								<span class="error-msg"><%=request.getParameter("errorMsg") %></span>
							<%
								}
							%>
						</div>
						<form>
							<label for="ckId">ID</label>
							<input type="text" name="ckId" id="ckId" placeholder="Enter Id" />
							<button type="button" id="ckIdBtn" class="btn btn-default pull-right">아이디 중복검사</button>
						</form>
					</div><!--/idCheck form-->
				</div>
			</div>
		</div>
	</section>
	
	<section id="form"><!--form-->
		<div class="container">
			<div class="row">
				<div class="col-sm-4 col-sm-offset-2">
					<div class="signup-form"><!--customerIdCheck form-->
						<h2>고객 회원가입</h2>
						<%
							String ckId = "";
							if (request.getParameter("ckId") != null) {
								ckId = request.getParameter("ckId");
							}
						%>
						<form action="<%=request.getContextPath() %>/addCustomerAction.jsp" method="post" id="customerSignupForm">
							<label for=customerId>ID</label>
							<input type="text" name="customerId" id="customerId" value="<%=ckId %>" placeholder="아이디 중복검사를 하세요!" readonly/>
							<label for="customerPass">PASSWORD</label>
							<input type="password" name="customerPass" id="customerPass" placeholder="Enter Password" />
							<label for="customerName">NAME</label>
							<input type="text" name="customerName" id="customerName" placeholder="Enter Name" />
							<label for="customerAddress">ADDRESS</label>
							<input type="text" name="addr" id="addr" placeholder="Enter Address"  readonly/>
							<button type="button" id="addrBtn" class="btn btn-default pull-right">우편번호 찾기</button>
							<input type="text" name="detailAddress" id="detailAddress" placeholder="Enter DetailAddress" />
							<label for="customerTelephone">Phone</label>
							<input type="text" name="customerTelephone" id="customerTelephone" placeholder="Enter PhoneNumber( - 빼고 입력)" />
							<button type="button" id="customerSignupBtn" class="btn btn-default pull-right">회원가입</button>
						</form>
					</div>
				</div>
					<div class="col-sm-1">
						<h2 class="or">OR</h2>
					</div>
				<div class="col-sm-4">
				    <div class="signup-form"><!--employeeSignup form-->
						<h2>직원 회원가입</h2>
						<%-- <%
							String ckId = "";
							if (request.getParameter("ckId") != null) {
								ckId = request.getParameter("ckId");
							}
						%> --%>
						<form action="<%=request.getContextPath() %>/addEmployeeAction.jsp" method="post" id="employeeSignupForm">
							<label for=employeeId>ID</label>
							<input type="text" name="employeeId" id="employeeId" value="<%=ckId %>" placeholder="아이디 중복검사를 하세요!" readonly/>
							<label for="employeePass">PASSWORD</label>
							<input type="password" name="employeePass" id="employeePass" placeholder="Enter Password" />
							<label for="employeeName">NAME</label>
							<input type="text" name="employeeName" id="employeeName" placeholder="Enter Name" />
							<button type="button" id="employeeSignupBtn" class="btn btn-default pull-right">회원가입</button>
						</form>
					</div><!--/employeeSignup form-->
				</div>
			</div>
		</div>
	</section><!--/form-->
	
	<%@include file="/footer.jsp" %><!-- footer -->
	
	<script>
		$(function(){ 
			$('#ckIdBtn').click(function(){
				if($('#ckId').val() == '') {
					alert('아이디를 입력하세요!');
					$('#ckId').focus();
					return;
				}
				
				if ($('#ckId').val().length < 4) {
					alert('아이디를 4자이상 입력해주세요!');
					$('#ckId').focus();
					return;
				}
				
				$.ajax({
					url : '/shop/idckController',
					type : 'post',
					data : {ckId : $('#ckId').val()},
					success : function(json) {
						if (json == 'n') {
							alert('이미 사용중인 아이디입니다.');
							$('#customerId').val('');
							$('#employeeId').val('');
							$('#ckId').focus();
							return;
						}
						$('#customerId').val($('#ckId').val());
						$('#employeeId').val($('#ckId').val());
					}
				});
			});
		});
		
		$(function(){ 
			$('#customerSignupBtn').click(function(){
				if($('#customerId').val() == '') {
					alert('아이디 중복검사를 하세요!');
				} else if($('#customerPass').val() == '') {
					alert('고객 패스워드를 입력하세요!');
				} else if($('#customerName').val() == '') {
					alert('고객 이름을 입력하세요!');
				} else if($('#addr').val() == '') {
					alert('고객 주소를 입력하세요!');
				} else if($('#detailAddress').val() == '') {
					alert('고객 상세주소를 입력하세요!');
				} else if($('#customerTelephone').val() == '') {
					alert('고객 전화번호를 입력하세요!');
				} else {
					customerSignupForm.submit();
				}
			});
		});
		
		$(function(){ 
			$('#employeeSignupBtn').click(function(){
				if($('#employeeId').val() == '') {
					alert('아이디 중복검사를 하세요!');
				} else if($('#employeePass').val() == '') {
					alert('직원 패스워드를 입력하세요!');
				} else if($('#employeeName').val() == '') {
					alert('직원 이름을 입력하세요!');
				} else {
					employeeSignupForm.submit();
				}
			});
		});
	</script>
	
	<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
<script>
	$('#addrBtn').click(function(){
		sample2_execDaumPostcode();
	});
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    //document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
               /*  document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr; */
                
                // $('#') ///////////////////////////////////////////////////////////////////////
                document.getElementById('addr').value = data.zonecode + ' ' + addr;;
                
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
	
    <script src="js/jquery.js"></script>
	<script src="js/price-range.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
</body>
</html>