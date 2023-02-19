<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

    <!DOCTYPE HTML>

<html>
	<head>
	
		<title>마이페이지화면</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/css/main.css" />
		
		
		<script src="/js/jquery-1.11.0.min.js"></script>
		
		<script>
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 게시판 수정/삭제 화면으로 이동하는 함수 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		$(function(){		
			//로그아웃
			$(".logoutBtn").click(
			function(){
				if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
				location.replace("/logout.do");
			});
			//alert("바디읽음"); return;
			//alert(   $('[name=mypageUpForm]').serialize()  ); return;

			//----------------------------------------------
			// 수정/삭제 버튼에 클릭 이벤트가 발생하면 goMypageUpForm 함수 호출하기
			//----------------------------------------------
			$(".mypageUpBtn").bind("click",function(){
				
				goMypageUpForm();
			});
			
		}) //$(function(){ 끝나는 지점
			
			
			
		function goMypageUpForm(){
				//alert("수정버튼누름")				
				//return;
				//---------------------------------
				// name=empdUpDelForm 을 가진 form 태그의 action 값의 URL 주소로 서버에 접속하라
				// form 태그 내부의 입력양식들의 입력된 데이터도 서버로 전송된다.
				// 현재는 hidden 태그에 입려독된 게시판 번호가 전송된다.
				//---------------------------------
				//$('[name=mypageUpForm]').serialize();
				document.mypageUpForm.submit();
			}
		</script>
		
		
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">

							<!-- Header -->
								<header id="header">
									<strong>마이페이지</strong>	
									<span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>
									
								</header>

							<!-- Content -->
								
									<header class="main">
										
									</header>
									<br><br>

									<form name="mypageDetailForm" action="" method="post">
										
										<center><img src="images/profile.png"  width="160px" height="150px" alt="profile" /></center>

										<table border="1" cellpadding="5" cellspacing="0" align="center">
											
											<tr>
												<th>이름</th>
												<td colspan="3"> 
													${mypage.emp_name}
												</td>
												
											</tr>
											<tr>
												<th>사번</th>
												<td> 
													${mypage.emp_no}
												</td>
												<th>부서</th>
												<td> 
													${mypage.dep_name}
												</td>
											</tr>
											<tr>												
												<th>직급</th>
												<td> 
													${mypage.jikup_name}
												</td>
												<th>직속상관이름</th>
												<td> 
													${mypage.emp_name2}
												</td>
											</tr>
											<tr>
												<th>생년월일</th>
												<td colspan="3"> 
													${mypage.birthday}
												</td>
											</tr>
											<tr>
												<th>전화번호</th>
												<td colspan="3">
													${mypage.phone_num}
												</td>
											</tr>
											<tr>
												<th>이메일</th>
												<td colspan="3">
													${mypage.email}
												</td>
											</tr>
																						
											 
											
											
										</table>
							
										<br>
										<center>
										<c:if test="${ sessionScope.emp_role eq 'user' }">
											<input type="button" class="mypageUpBtn" name="mypageUpBtn" value="수정">
										</c:if>
										</center>
									</form>
									
									<!--===========================================================-->
									<!-- 웹서버에 "/mypageUpForm.do"  URL 주소로 접속하기 위한 form 태그 선언-->
									<!--===========================================================-->
									<form name="mypageUpForm" method="post" action="/mypageUpdate.do"> 
										<!----------------------------------------------------->
										<!-- 웹서버에 "/mypageUpForm.do"  URL 주소로 접속할 때 가져갈 데이터 저장 목적의 hidden 태그 선언-->
										<!-- 현재 이 hidden 태그에는 수정삭제 할 게시판의 고유번호가 저장되어 있다.-->
										<!----------------------------------------------------->
										<input type="hidden" name="emp_no" value="${mypage.emp_no}">
									</form>
	
						</div>
					</div>

				<!-- Sidebar -->
					<div id="sidebar">
						<div class="inner">

							<%@include file="/WEB-INF/views/sideBar.jsp" %>

							

						</div>
					</div>

			</div>

		<!-- Scripts -->
			<script src="/js/jquery.min.js"></script>
			<script src="/js/browser.min.js"></script>
			<script src="/js/breakpoints.min.js"></script>
			<script src="/js/util.js"></script>
			<script src="/js/main.js"></script>

	</body>
</html>