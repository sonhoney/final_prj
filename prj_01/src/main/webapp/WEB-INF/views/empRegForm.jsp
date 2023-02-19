<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML><html>
	<head>
	
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
	<script src="/ckeditor/ckeditor.js"></script>
	<script src="/ckeditor/ko.js"></script>
	<title>직원등록 상세페이지</title>	
		<link rel="stylesheet" href="/css/main.css" />
	<!-- ******************************************************** -->
	<!--  JQuery 라이브러리 수입하기 -->
	<!-- ******************************************************** -->
	<script src="/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>	
	<script>
		var empRegForm;
		//**********************************************************
		// 웹브라우저가 body 태그 안을 모두 읽어들인 후 실행할 자스 코딩 설정하기
		//**********************************************************
		$(function(){

			//로그아웃
			$(".logoutBtn").click(
			function(){
				if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
				location.replace("/logout.do");
			});
			

			// 부서 변경시 새로 직속 상관 리스트를 가져오는 ajax 
			$(".dep_no").change(function(){
				alert("s")
				$.ajax({
					url : "/mgrListProc.do"
					, type : "post"
					,data: $("[name='empRegForm']").serialize()  	// , data:"admin_id="+admin_idVal+"&pwd="+pwdVal
					, success : 
						function( json ){
							//alert(${requestScope.employeeDTO.emp_pwd_confirm}); return;
							if( json!=null ){

								$(".mgrLsit").empty() ;

								for( var key in json){
									console.log( "value값  =>" +key +"//화면 데이터=>"+ json[key] )
									$(".mgrLsit").append("<option value="+key+">"+json[key]+"</option>")
								}

								return;
								
							}
						
						}
					
					, error : function(){
							alert("서버 접속 실패");
						}
				});


			})
			
			
			empRegForm = $("[name=empRegForm]");
			//alert(${requestScope.employeeDTO.emp_no});
			//return;
			
			
			//  empList_beforeAllowBtn 리스트 / empUpBtn 수정
			//----------------------------------------------
			// 등록하기 버튼에 클릭 이벤트가 발생하면 goBoardUpDelForm 함수 호출하기
			//----------------------------------------------
			$(".empRegBtn").bind("click",function(){
				//alert("등록"); return;
				empRegFormCheck();
			});
			//----------------------------------------------
			// 목록보기 버튼에 클릭 이벤트가 발생하면 
			// name=empListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
			//----------------------------------------------
			$(".empListBtn").bind("click",function(){
				// name=boardListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
				//alert("취소버튼")
				//return;
				document.empListForm.submit();
			});
			
			
			$(".emp_no_checkBtn").bind("click",function(){
				//alert("등록"); return;
				emp_no_check();
			});
			
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			// 게시판 수정/삭제 화면으로 이동하는 함수 선언
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			function goEmpUpForm(){
				//alert("수정버튼누름")
				//return;
				//---------------------------------
				// name=boardUpDelForm 을 가진 form 태그의 action 값의 URL 주소로 서버에 접속하라
				// form 태그 내부의 입력양식들의 입력된 데이터도 서버로 전송된다.
				// 현재는 hidden 태그에 입려독된 게시판 번호가 전송된다.
				//---------------------------------
				document.empUpDelForm.submit();
			}
			
			
			var pwd = $("[name=empRegForm]").find(".emp_pwd");
	    	var pwd_confirm = $("[name=empRegForm]").find(".emp_pwd_confirm")
	    	
	    	
	    	pwd.val("${requestScope.employeeDTO.emp_pwd}");
	    	pwd_confirm.find(".emp_pwd_confirm").val("${requestScope.employeeDTO.emp_pwd_confirm}");
			
			
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
	    	}) // pwd_confirm.blur(function(){ 끝
	    	
	    	
			/*
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			// 직원정보에 맞게 select박스 선택되어지는 거
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			
			// 부서번호값 가져와서 select박스 선택하기
			$("select[name=dep_no]").val(${requestScope.employeeDTO.dep_no});
			
			// 정상 작동
        	$("select[name=jikup_code]").val(${requestScope.employeeDTO.jikup_code});
			
			// val(  "따옴표 추가"  ) -> 해결완
        	$("select[name=emp_role]").val(   "${requestScope.employeeDTO.emp_role}"  );
        	//$("select[name=emp_role]").val(${requestScope.employeeDTO.emp_role}).prop("selected", true);

        	// val(  "따옴표 추가"  ) -> 해결완
        	$("select[name=allow_code]").val( "${requestScope.employeeDTO.allow_code}" );

        	$("[name=empDetailForm]").find(".emp_pwd").val("${requestScope.employeeDTO.emp_pwd}");
			*/
			
			
			
		}) // 	$(function(){ 끝
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 사번 중복체크
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		function emp_no_check(){
			//alert("중복체크함수들어옴"); return;
		
		        var emp_no = $("[name=empRegForm]").find(".emp_no").val(); //id값이 "id"인 입력란의 값을 저장
		        $.ajax({
		            url:'/emp_no_check.do', //Controller에서 요청 받을 주소
		            type:'post', //POST 방식으로 전달
		            data:{emp_no:emp_no},
		            success:function(emp_no_check_cnt){ //컨트롤러에서 넘어온 cnt값을 받는다 
		                if(emp_no_check_cnt == 1){ //1은 중복
		                	 $('.emp_no_already').css("display","inline-block");
		                     $('.emp_no_ok').css("display", "none");
		                     //alert("이미 사용 중인 사번입니다.");
			                	$("[name=empRegForm]").find(".emp_no").val("");
			                	$("[name=empRegForm]").find(".emp_no").focus();
		                	/*
		                	alert("이미 사용중인 사번입니다.");
		                	$("[name=empRegForm]").find(".emp_no").val("");
		                	$("[name=empRegForm]").find(".emp_no").focus();
		                	*/
		                } else { // 사용 가능
		                	
		                	$('.emp_no_ok').css("display","inline-block"); 
		                    $('.emp_no_already').css("display", "none");
		                	/*
		                    alert("사용 가능한 사번입니다.");
		               		 */
		                    
		                }
		            },
		            error:function(){
		                alert("에러입니다");
		            }
		        });
		     }; //function emp_no_check(){ 끝
			
		    
			
	
		//**********************************************************
		// 유효성 체크,비동기 방식으로 웹서버에 접속하는  함수 선언
		//**********************************************************
		function empRegFormCheck(){
			//alert(   $("[name='empRegForm']").serialize()  ); return;
			
			var empRegForm = $("[name='empRegForm']");
			
			//------------------------------------------------
			// 사원 등록 관련 입력양식의 유효성 체크하기
			//------------------------------------------------
			
			// 사원이름 가져와서 변수 emp_name 에 저장하기
			var emp_name = empRegForm.find(".emp_name").val();
			// 사원 이름이 한글으로 2~10자보다 크면 경고하고 함수 중단
			var regExp = new RegExp(/^[가-힣]{2,10}$/);
			if( regExp.test(emp_name)==false ){
				alert("사원 이름은 한글 2~10자로 입력해주시기 바랍니다.");
				empRegForm.find(".emp_name").val("");
				return;
			}
			
			// 사번 가져와서 변수 emp_no에 저장하기
			var emp_no = empRegForm.find(".emp_no").val();
			// 사번은 숫자로 구성되고 4자 보다 크면 경고하고 함수 중단
			regExp = new RegExp(/^[0-9]{1,10}$/);
			if( regExp.test(emp_no)==false ){
				alert("사번은 숫자 1~10자로 입력해주시기 바랍니다.");
				empRegForm.find(".emp_no").val("");
				return;
			}
			
			// 사번 가져와서 변수 emp_no에 저장하기
			var emp_no = empRegForm.find(".emp_no").val();
			// 사번은 숫자로 구성되고 4자 보다 크면 경고하고 함수 중단
			regExp = new RegExp(/^[0-9]{1,10}$/);
			if( regExp.test(emp_no)==false ){
				alert("사번은 숫자 1~10자로 입력해주시기 바랍니다.");
				empRegForm.find(".emp_no").val("");
				return;
			}
			
			// 암호 가져와서 변수 pwd 에 저장하기
			var emp_pwd = empRegForm.find(".emp_pwd").val();
			// 암호가 영소문 또는 숫자로 구성되고 4자 보다 크면 경고하고 함수 중단
			regExp = new RegExp(/^[0-9]{4}$/);
			if( regExp.test(emp_pwd)==false ){
				alert("암호는 숫자 4자로 입력해주시기 바랍니다.");
				empRegForm.find(".emp_pwd").val("");
				return;
			}
			
			// 주민등록번호 가져와서 변수 jumin_num 에 저장하기
			var jumin_num = empRegForm.find(".jumin_num").val();
			// 주민등록번호 형식이 아니면 경고하고 함수 중단
			regExp = new RegExp('^[0-9]{13}$');
			if( regExp.test(jumin_num)==false ){
				alert("주민등록번호 형식이 올바르지 않습니다. 숫자 13자리로 입력해주시기 바랍니다.");
				empRegForm.find(".jumin_num").val("");
				return;
			}
			
			// 이메일 가져와서 변수 email 에 저장하기
			var email = empRegForm.find(".email").val();
			// 이메일 형식이 아니면 경고하고 함수 중단
			regExp = new RegExp('^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$');
			if( regExp.test(email)==false ){
				alert("이메일 형식이 올바르지 않습니다. 다시 입력해주시기 바립니다.");
				empRegForm.find(".email").val("");
				return;
			}
			
			
			
			// 전화번호 가져와서 변수 jumin_num 에 저장하기
			var phone_num = empRegForm.find(".phone_num").val();
			// 전화번호 형식이 아니면 경고하고 함수 중단
			regExp = new RegExp('^[0-9]{11}$');
			if( regExp.test(phone_num)==false ){
				alert("전화번호는 숫자 11자리로 입력해주시기 바랍니다.");
				empRegForm.find(".phone_num").val("");
				return;
			}
			
			
			//------------------------------------------------
			// 비동기 방식으로 웹서버에 접속해서 
			// 게시판 새글쓰기 관련 입력양식의 데이터 전송하기
			//------------------------------------------------
			$.ajax( {
					//------------------------------------------
					// 웹서버에 접속할 떄 사용할 URL 주소 지정
					//------------------------------------------
					url:"/empRegProc.do"
					//------------------------------------------
					// 웹서버에 전송할 데이터를 보내는 방법 지정
					// 즉, 파라미터명(입력양식name값)과 파라미터값(입력양식value값)을 보내는 방법 지정
					//------------------------------------------
					,type:"post"
					//----------------------------------------------------------
					// 웹서버로 보낼 파라미터명(입력양식name값)과 파라미터값(입력양식value값)을 
					// 아래와 같은 형식의 문자열로 조합해서 설정하기
						// "파라미터명1=파라미터값1&파라미터명2=파라미터값2&~"
					//----------------------------------------------------------
					,data:$("[name='empRegForm']").serialize() 
					//----------------------------------------------------------
					// 웹서버와 통신한 후 웹서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
					// 익명함수의 매개변수에는 웹서버가 보내온 [새글의 입력된 행 개수]가 들어온다
					//----------------------------------------------------------
					,success:function(empRegCnt){
							//---------------------------------
							// 게시판 글 입력 성공 행의 개수가 1이면, 즉 입력이 성공했으면
							//---------------------------------
							if( empRegCnt==1 ){
								alert("새로운 직원을 등록했습니다.");
								document.empListForm.submit();
								/*
								if( confirm("다시 새 글을 쓰시겠습니까?")==false ){
									location.replace("/boardList.do")
								}else{
									document.empRegForm.reset();
								}*/
							}
							else{
								alert("직원 등록에 실패했습니다.")
							}
						
					}
					//----------------------------------------------------------
					// 웹서버와 통신이 실패했을 경우 실행할 익명함수 설정.
					//----------------------------------------------------------
					,error:function( ){
						alert("웹서버 접속 실패! 관리자에게 문의 바람!");
					}
			} )

		} // function regFormCheck(){ 끝
		
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
									<strong>직원 정보 등록</strong>	
									<span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>								
								</header>

							<!-- Content -->   
							<!--===========================================================-->
							<form name="empRegForm" class="empRegForm">
								<!--===========================================================-->                                                   
									<table border=1 cellpadding="5" cellspacing="1" >
										<tr>
											<th>이름</th>
											<th>사번</th>
										</tr>
										<tr>
											<td>
												<input type="text" name="emp_name" class="emp_name">
											</td>
											<td>
												<input type="text" name="emp_no" class="emp_no" oninput = "emp_no_check()">
												  <!-- <input type="button" class="emp_no_checkBtn" name="emp_no_checkBtn" value="중복확인"> -->
												  
												<style>
												.emp_no_ok{
												color:#008000;
												display: none;
												}
												
												.emp_no_already{
												color:#fb6f6a; 
												display: none;
												}
												</style>
												<span class="emp_no_ok">사용 가능한 사번입니다.</span>
												<span class="emp_no_already">이미 사용 중인 사번입니다.</span>
											</td>
										</tr>
										<tr>
											<th>암호</th>
											<th>암호확인</th>
										</tr>
										<tr>
											<td>
												   <input type="text" name="emp_pwd" class="emp_pwd">
													
											</td>
											<td>
												<input type="text" name="emp_pwd_confirm" class="emp_pwd_confirm">
											</td>
										</tr>
										<tr>
											<th>주민등록번호</th>
											<th>이메일</th>
										</tr>
										<tr>
											<td>
												 <input type="text" name="jumin_num" class="jumin_num">
											</td>
											<td>
												<input type="text" name="email" class="email">
											</td>
										</tr>
										<tr>
											<th>권한설정</th>
											<th>소속부서</th>
										</tr>
										<tr>
											<td>
											<!-- <select name="emp_role" class="emp_role">
													<option value="user">일반계정</option>
													<option value="admin">관리자계정</option>
												</select> -->
												<select name="emp_role">
													 <option value="user">일반계정</option>
													<option value="admin">관리자계정</option>
												</select>
												
												<!-- <input type="text" name="emp_role" class="emp_role"> -->
												
												
											<!--
											
											 <select name="emp_role">
													 <option value="user">일반계정</option>
													<option value="admin">관리자계정</option>
												</select> -->
												
											   
											</td>
											<td>
											<!--  <select name="dep_no" name="dep_no">
													<option value="10">행정</option>
													<option value="20">사무</option>
													<option value="30">구매</option>
													<option value="40">접대</option>
													<option value="50">회계</option>
													<option value="60">기타</option>
												</select> -->
											   <select name="dep_no" class="dep_no">
													<option value="10">행정</option>
													<option value="20">사무</option>
													<option value="30">구매</option>
													<option value="40">접대</option>
													<option value="50">회계</option>
													<option value="60">기타</option>
												</select>
												
												<!-- <input type="text" name="dep_no" class="dep_no"> -->
												
												<!-- 
												
												 <select name="dep_no" name="dep_no">
													<option value="3">인사부</option>
													<option value="6">영업부</option>
													<option value="9">사업부</option>
													<option value="12">개발부</option>
												</select> -->
											   
												
											</td>
										</tr>
										<tr>
											<th>직급</th>
											<th>직속상관</th>
										</tr>
										<tr>
											<td>
											<!-- <select name="jikup_code" class="jikup_code">
												   <option value="1">사장</option>
													<option value="2">부장</option>
													<option value="3">차장</option>
													<option value="4">과장</option>
													<option value="5">대리</option>
													<option value="6">사원</option>
												</select> -->
											<select name="jikup_code" class="jikup_code">
												   <option value="1">사장</option>
													<option value="2">부장</option>
													<option value="3">차장</option>
													<option value="4">과장</option>
													<option value="5">대리</option>
													<option value="6">사원</option>
												</select>
												
												<!--<input type="text" name="jikup_code" class="jikup_code">  -->
										   
												<!-- 
												 
												<select name="jikup_code" class="jikup_code">
													<option value="11">사원</option>
													<option value="22">주임</option>
													<option value="33">대리</option>
													<option value="44">과장</option>
													<option value="55">차장</option>
													<option value="66">팀장</option>
												</select> -->
												
											</td>
											<td>
											<!-- <input type="text" name="mgr_emp_no" class="mgr_emp_no"> -->
											
											<!-- <select >
												<option value="">-</option>
											</select> -->
											<input type="text" name="mgr_emp_no" class="mgr_emp_no">

												<!--
												<select name="mgrList" class="mgrList">

												</select>
											    -->
												
											</td>
										</tr>
										<tr>
											<th>전화번호</th>
											<th>가입상태</th>
										</tr>
										<tr>
											<td>
												
												<input type="text" name="phone_num" class="phone_num">
											</td>
											<td>
											<!--  <select name="allow_code" class="allow_code">
													<option value="1">authorized</option>
													<option value="2">unauthorized</option>
												</select> -->
												<select name="allow_code" class="allow_code">
													<option value="1">가입승인</option>
													<option value="2">승인대기</option>
												</select>
												
												<!-- <input type="text" name="allow_code" class="allow_code"> -->
										   
												
												<!-- <select name="code_allow" class="code_allow">
													<option value="0">승인대기</option>
													<option value="100">가입승인</option>
												</select> 
												 <input type="text" name="allow_code" class="allow_code">-->
											   
											</td>
										</tr>
									</table>
								</form>
									<center>
									<input type="button" class="empRegBtn" name="empRegBtn" value="등록하기">
									<input type="button" class="empListBtn" name="empListBtn" value="취소">
									
									</center>

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
		<!--===========================================================-->
		
		<!--===========================================================-->
		<!-- 이게 boardList랑 같은 기능 -->
		<form name="empListForm" method="post" action="/empList.do"> 
		
		</form>
		
		<!-- 수정할 때 들어갈 곳 
		<form name="empUpForm" method="post" action="/empUpForm.do"> 
			<input type="text" name="emp_no" class="emp_no" value="${requestScope.employeeDTO.emp_no}">
			<input type="text" name="RNUM" class="RNUM" value="${requestScope.employeeDTO.RNUM}">
		</form>
		
		-->
		
		
		
		
	</body>
</html>