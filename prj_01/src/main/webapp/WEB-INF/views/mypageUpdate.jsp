<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	   <!-- 사번(uid) 가져오기 -->
   
    <!DOCTYPE HTML>

<html>
	<head>
		<title>마이페이지화면</title>
		<meta charset="utf-8" />
		
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/css/main.css" />
	
	<script src="/js/jquery-1.11.0.min.js"></script>
	<script>

	//**********************************************************
	// 웹브라우저가 body 태그 안을 모두 읽어들인 후 실행할 자스 코딩 설정하기
	//**********************************************************
	$(function(){
		//alert("바디읽음"); 
		//return;
			//로그아웃
			$(".logoutBtn").click(
			function(){
				if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
				location.replace("/logout.do");
			});		

		//----------------------------------------------
		// 수정 버튼에 클릭 이벤트가 발생하면 checkBoardUpDelForm 함수 호출하기
		//----------------------------------------------
		$(".MypageUpdateBtn").bind("click",function(){

			checkMypageUpdate();
		});		// $(".MypageUpdateBtn").bind("click",function(){ 끝
		
		
			//-------------
			
		$(".MypageBackBtn").bind("click",function(){
			document.mypageDetailForm.submit();
			
		});	
		var pwd = $("[name=mypageUpForm]").find(".emp_pwd");
    	var pwd_confirm = $("[name=mypageUpForm]").find(".emp_pwd_confirm")
    	
    	
    	pwd.val("${requestScope.employeeDTO.emp_pwd}");
    	pwd_confirm.val("${requestScope.employeeDTO.emp_pwd_confirm}");
    	// 수정하러 들어갈 때 새로운 암호 부분 비어둘 때
    	//pwd.val("")
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 비밀번호 일치확인
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    	
    	pwd_confirm.blur(function(){
    		//alert("떠라")
    		//return;
    		
    		var pwdVal = pwd.val();
    		var pwd_confirmVal = pwd_confirm.val();
    		//alert( pwdVal + "  " + pwd_confirmVal    ); return;
			
    		if( !(pwdVal == pwd_confirmVal) ){
    			alert("비밀번호가 일치하지 않습니다.")
    			$("[name=emp_pwd]").val("");
    			$("[name=emp_pwd_confirm]").val("");
				$("[name=emp_pwd]").focus();
    			
    		}
    		else{ 
    				
    		}
    	
    	}) // // pwd_confirm.blur(function(){ 끝
			
			
	}) //		$(function(){ 끝
	
		//**********************************************************
		// 수정 관련 유효성 체크,비동기 방식으로 웹서버에 접속하는  함수 선언
		//**********************************************************
		function checkMypageUpdate(){
		//alert($('[name=mypageUpForm]').serialize() ); return;
		//alert("수정"); return;
			//===============================================
			// 입력양식 유효성 체크하기
			//===============================================
			var formObj = $("[name='mypageUpForm']");
			//--------------
			
			//------------------------------------------------
			// 현재 화면에서 페이지 이동 없이(=비동기 방식으로)
			// 웹서버쪽 "/boardUpProc.do" 로 접속해서 수정하기
			//------------------------------------------------
			$.ajax({
					//-------------------------------
					// 서버 쪽 호출 URL 주소 지정
					//-------------------------------
					url : "/mypageUpProc.do"
					//-------------------------------
					// form 태그 안의 입력양식 데이터 즉, 파라미터값을 보내는 방법 지정
					//-------------------------------
					, type : "post"
					//-------------------------------
					// 서버로 보내는 데이터  설정하기.
					//-------------------------------
					,data: $("[name='mypageUpForm']").serialize()
					//-------------------------------
					// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
					//-------------------------------  
					, success : function( empUpCnt ){
						
						if( empUpCnt==1 ){
							alert("수정이 성공했습니다.");
							document.mypageDetailForm.submit();
						}
						else if( empUpCnt==0 ){
							alert("삭제된 게시물입니다.");
							document.mypageMain.submit();
							
						}
						/*
						else if( boardUpCnt==-1 ){
							alert("암호가 틀립니다.");
							$("[name=pwd]").val("");
							$("[name=pwd]").focus();
						}
						*/
					}
					//-----------------------------------------------------
					// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
					//----------------------------------------------------------
					, error : function(){
						alert("서버 접속 실패");
					}
			});
		
		
		
		}	//checkMypageUpdate 블록 끝
		
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
									<!-- ========================================== -->
									<!--MyPageUpForm form 태그 시작 -->
									<!-- ========================================== -->
									<form name="mypageUpForm">
										
										<span><img src="images/profile.jpg" width="250px" height="300px" alt="profile" /></span>

										<table border="1" cellpadding="5" cellspacing="0" align="center">
											<tr>
												<th>이름</th>
												<td colspan="3"> 
												
													${requestScope.employeeDTO.emp_name}
												</td>
												
											</tr>
											<tr>
												<th>사번</th>
												<td> 
													${requestScope.employeeDTO.emp_no}
												</td>
											</tr>
											<tr>
												<th>생년월일</th>
												<td> 
													${mypage.birthday}
												</td>
											</tr>
											<tr>
												<th>전화번호</th>
												<td>
													<input type="text" name="phone_num" class="phone_num" maxlength="15" value="${requestScope.employeeDTO.phone_num}"> 
													
												</td> 
											</tr>
											<tr>
												<th>이메일</th>
												<td>
													<input type="text" name="email" class="email" maxlength="30" value="${requestScope.employeeDTO.email}"> 
												</td>
											</tr>
											
											<tr>
												<th>새로운 암호</th>
												<td>
													<input type="password" name="emp_pwd" class="emp_pwd">
													
													기존 암호: ${requestScope.employeeDTO.emp_pwd}
												</td>
											</tr>
											<tr>
												<th>새로운 암호확인</th>
												<td>
												<input type="password" name="emp_pwd_confirm" class="emp_pwd_confirm">
                                        			 ${requestScope.employeeDTO.emp_pwd_confirm}
													<!-- <input type="text" name="new_pwd_confirm" maxlength="15">  -->
													
												</td>
											</tr> 
											
										</table>
										
									<!-------------------------------------------------------->
									<!--- 수정할 번호가 저장된 hidden 태그 선언하기->
									<!-------------------------------------------------------->
									
									<input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}"> 
									<input type="hidden" name="emp_name" value="${requestScope.employeeDTO.emp_name}"> 
									<input type="hidden" name="emp_role" value="${requestScope.employeeDTO.emp_role}"> 
									<input type="hidden" name="dep_no" value="${requestScope.employeeDTO.dep_no}"> 
									<input type="hidden" name="jikup_code" value="${requestScope.employeeDTO.jikup_code}"> 
									<input type="hidden" name="allow_code" value="${requestScope.employeeDTO.allow_code}"> 
									<input type="hidden" name="mgr_emp_no" value="${requestScope.employeeDTO.mgr_emp_no}"> 
									<input type="hidden" name="jumin_num" value="${requestScope.employeeDTO.jumin_num}">
									
									
									
									
										<br>
										<center>
										<input type="button" name="MypageUpdateBtn" class="MypageUpdateBtn" value="수정하기" >
										<input type="button" name="MypageBackBtn" class="MypageBackBtn" value="수정취소" >
										</center>
									<br>
									</form>
									<!-- ========================================== -->
									<!-- MyPageUpForm form 태그 끝 -->
									<!-- ========================================== -->
									<form name="mypageDetailForm" method="post" action="/mypageMain.do"> 
								
									</form>	
									<!-- <form name="mypageUpForm" method="post" action="mypageUpForm.do"> 
									<input type="text" name="emp_no" value="${requestScope.employeeDTO.emp_no}">
									
									
								</form>	 -->
									

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