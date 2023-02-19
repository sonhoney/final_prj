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
	<title>직원정보 수정삭제 상세페이지</title>	
		<link rel="stylesheet" href="/css/main.css" />
	<!-- ******************************************************** -->
	<!--  JQuery 라이브러리 수입하기 -->
	<!-- ******************************************************** -->
	<script src="/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>	
	<script>

	//**********************************************************
	// 웹브라우저가 body 태그 안을 모두 읽어들인 후 실행할 자스 코딩 설정하기
	//**********************************************************
	$(function(){
         
		console.log("===>" , "${requestScope.employeeDTO.emp_role}" );

		//로그아웃
		$(".logoutBtn").click(
		function(){
			if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
			location.replace("/logout.do");
		});
		
	      // 처음 직속 상관 리스트를 가져오는 ajax 
	      $.ajax({
	            url : "/mgrListProc.do"
	            , type : "post"
	            ,data: "jikup_code="+"${requestScope.employeeDTO.jikup_code}"+"&dep_no="+"${requestScope.employeeDTO.dep_no}"      
	            , success : 
	               function( json ){
	                  //alert(${requestScope.employeeDTO.emp_pwd_confirm}); return;
	                  if( json!=null ){
	                     
	                     for( var key in json){
	                        console.log( "value값  =>" +key +"//화면 데이터=>"+ json[key] )
	                        $(".mgr_emp_no").append("<option value="+key+">"+json[key]+"</option>")
	                            }

	                     return;
	                     
	                  }
	               
	               }
	            
	            , error : function(){
	                  alert("서버 접속 실패");
	               }
	      });


	      // 부서 변경시 새로 직속 상관 리스트를 가져오는 ajax 
	      $(".dep_no").change(function(){
	         
	         $.ajax({
	            url : "/mgrListProc.do"
	            , type : "post"
	            ,data: $("[name='empUpDelForm']").serialize()     // , data:"admin_id="+admin_idVal+"&pwd="+pwdVal
	            , success : 
	               function( json ){
	                  //alert(${requestScope.employeeDTO.emp_pwd_confirm}); return;
	                  if( json!=null ){

	                     $(".mgr_emp_no").empty() ;

	                     for( var key in json){
	                        console.log( "value값  =>" +key +"//화면 데이터=>"+ json[key] )
	                        $(".mgr_emp_no").append("<option value="+key+">"+json[key]+"</option>")
	                            }

	                     return;
	                     
	                  }
	               
	               }
	            
	            , error : function(){
	                  alert("서버 접속 실패");
	               }
	         });


	      })

	      // 직급 변경시 새로 직속 상관 리스트를 가져오는 ajax 
	      $(".jikup_code").change(function(){
	         
	         $.ajax({
	            url : "/mgrListProc.do"
	            , type : "post"
	            ,data: $("[name='empUpDelForm']").serialize()     // , data:"admin_id="+admin_idVal+"&pwd="+pwdVal
	            , success : 
	               function( json ){
	                  //alert(${requestScope.employeeDTO.emp_pwd_confirm}); return;
	                  if( json!=null ){

	                     $(".mgr_emp_no").empty() ;

	                     for( var key in json){
	                        console.log( "value값  =>" +key +"//화면 데이터=>"+ json[key] )
	                        $(".mgr_emp_no").append("<option value="+key+">"+json[key]+"</option>")
	                            }

	                     return;
	                     
	                  }
	               
	               }
	            
	            , error : function(){
	                  alert("서버 접속 실패");
	               }
	         });


	      })


		// 권한 설정 디폴트 넣는 부분
	    
		
		//var emp_role = $(".emp_role");
		


		//alert("바디읽음")
		//alert(${requestScope.employeeDTO.emp_pwd})
		//alert(${requestScope.employeeDTO.emp_pwd_confirm})
		//----------------------------------------------
		// 수정 버튼에 클릭 이벤트가 발생하면 checkBoardUpDelForm 함수 호출하기
		//----------------------------------------------
		$(".empUpBtn").bind("click",function(){
			//alert("안녕")
			//return;
			checkEmpUpForm();
		});
		
		//----------------------------------------------
		// 삭제 버튼에 클릭 이벤트가 발생하면 checkBoardUpDelForm 함수 호출하기
		//----------------------------------------------
		$(".empDelBtn").bind("click",function(){
			//alert("삭제버튼눌렀어")
			//return;
			checkEmpDelForm();
		});
		
		
		//----------------------------------------------
		// 목록보기 버튼에 클릭 이벤트가 발생하면 
		// name=empListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
		//----------------------------------------------
		$(".empListBtn").bind("click",function(){
			// name=boardListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
			document.empListForm.submit();
		});
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 직원정보에 맞게 select박스 선택되어지는 거
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    	//alert(${requestScope.employeeDTO.allow_code});
		// 정상 작동
		$("select[name=dep_no]").val(${requestScope.employeeDTO.dep_no});
		
		// 정상 작동
		$("select[name=jikup_code]").val(${requestScope.employeeDTO.jikup_code});
		
		// val(  "따옴표 추가"  ) -> 해결완
    	$("select[name=emp_role]").val(   "${requestScope.employeeDTO.emp_role}"  );
    	//$("select[name=emp_role]").val(${requestScope.employeeDTO.emp_role}).prop("selected", true);

    	// val(  "따옴표 추가"  ) -> 해결완
    	$("select[name=allow_code]").val( "${requestScope.employeeDTO.allow_code}" );
		
    	var pwd = $("[name=empUpDelForm]").find(".emp_pwd");
    	var pwd_confirm = $("[name=empUpDelForm]").find(".emp_pwd_confirm")
    	
    	
    	pwd.val("${requestScope.employeeDTO.emp_pwd}");
    	pwd_confirm.find(".emp_pwd_confirm").val("${requestScope.employeeDTO.emp_pwd_confirm}");
		
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
	
		
    	
	
	})	//$(function(){ 끝

		
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 사번 중복체크
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	function emp_no_check(){
		//alert("중복체크함수들어옴"); return;
	
	        var emp_no = $("[name=empUpDelForm]").find(".emp_no").val(); //id값이 "id"인 입력란의 값을 저장
	        $.ajax({
	            url:'/emp_no_check.do', //Controller에서 요청 받을 주소
	            type:'post', //POST 방식으로 전달
	            data:{emp_no:emp_no},
	            success:function(emp_no_check_cnt){ //컨트롤러에서 넘어온 cnt값을 받는다 
	                if(emp_no_check_cnt == 1){ //1은 중복
	                	 $('.emp_no_already').css("display","inline-block");
	                     $('.emp_no_ok').css("display", "none");
	                     //alert("이미 사용 중인 사번입니다.");
		                	$("[name=empUpDelForm]").find(".emp_no").val("");
		                	$("[name=empUpDelForm]").find(".emp_no").focus();
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
	                alert("변경할 사번을 입력 해주세요 ");
	            }
	        });
	     }; //function emp_no_check(){ 끝		
		
		
	//**********************************************************
	// 수정 관련 유효성 체크,비동기 방식으로 웹서버에 접속하는  함수 선언
	//**********************************************************
	function checkEmpUpForm(){
	//alert(   $("[name='empUpDelForm']").serialize()  ); return;
	var empUpDelForm = $("[name='empUpDelForm']");
		//------------------------------------------------
		// 사원 등록 관련 입력양식의 유효성 체크하기
		//------------------------------------------------
		
/* 		var emp_role = $(".emp_role");
		
		if( emp_role.val() == "" ){
			
			alert("권한설정을 부여해 주시오.");
			return;
		} */
		
		
		
		// 사원이름 가져와서 변수 emp_name 에 저장하기
		var emp_name = empUpDelForm.find(".emp_name").val();
		// 사원 이름이 한글으로 2~10자보다 크면 경고하고 함수 중단
		var regExp = new RegExp(/^[가-힣]{2,10}$/);
		if( regExp.test(emp_name)==false ){
			alert("사원 이름은 한글 2~10자로 입력해주시기 바랍니다.");
			empUpDelForm.find(".emp_name").val("");
			return;
		}
		
		// 사번 가져와서 변수 emp_no에 저장하기
		var emp_no = empUpDelForm.find(".emp_no").val();
		// 사번은 숫자로 구성되고 4자 보다 크면 경고하고 함수 중단
		regExp = new RegExp(/^[0-9]{1,10}$/);
		if( regExp.test(emp_no)==false ){
			alert("사번은 숫자 1~10자로 입력해주시기 바랍니다.");
			empUpDelForm.find(".emp_no").val("");
			return;
		}
		
		// 사번 가져와서 변수 emp_no에 저장하기
		var emp_no = empUpDelForm.find(".emp_no").val();
		// 사번은 숫자로 구성되고 4자 보다 크면 경고하고 함수 중단
		regExp = new RegExp(/^[0-9]{1,10}$/);
		if( regExp.test(emp_no)==false ){
			alert("사번은 숫자 1~10자로 입력해주시기 바랍니다.");
			empUpDelForm.find(".emp_no").val("");
			return;
		}
		
		// 암호 가져와서 변수 pwd 에 저장하기
		var emp_pwd = empUpDelForm.find(".emp_pwd").val();
		// 암호가 영소문 또는 숫자로 구성되고 4자 보다 크면 경고하고 함수 중단
		regExp = new RegExp(/^[0-9]{4}$/);
		if( regExp.test(emp_pwd)==false ){
			alert("암호는 숫자 4자로 입력해주시기 바랍니다.");
			empUpDelForm.find(".emp_pwd").val("");
			return;
		}
		
		// 주민등록번호 가져와서 변수 jumin_num 에 저장하기
		var jumin_num = empUpDelForm.find(".jumin_num").val();
		// 주민등록번호 형식이 아니면 경고하고 함수 중단
		regExp = new RegExp('^[0-9]{13}$');
		if( regExp.test(jumin_num)==false ){
			alert("주민등록번호 형식이 올바르지 않습니다. 숫자 13자리로 입력해주시기 바랍니다.");
			empUpDelForm.find(".jumin_num").val("");
			return;
		}
		
		// 이메일 가져와서 변수 email 에 저장하기
		var email = empUpDelForm.find(".email").val();
		// 이메일 형식이 아니면 경고하고 함수 중단
		regExp = new RegExp('^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$');
		if( regExp.test(email)==false ){
			alert("이메일 형식이 올바르지 않습니다. 다시 입력해주시기 바립니다.");
			empUpDelForm.find(".email").val("");
			return;
		}
		
		
		
		// 전화번호 가져와서 변수 jumin_num 에 저장하기
		var phone_num = empUpDelForm.find(".phone_num").val();
		// 전화번호 형식이 아니면 경고하고 함수 중단
		regExp = new RegExp('^[0-9]{11}$');
		if( regExp.test(phone_num)==false ){
			alert("전화번호는 숫자 11자리로 입력해주시기 바랍니다.");
			empUpDelForm.find(".phone_num").val("");
			return;
		}	
		
		var phone_num = empUpDelForm.find(".phone_num").val();
		// 전화번호 형식이 아니면 경고하고 함수 중단
		regExp = new RegExp('^[0-9]{11}$');
		if( regExp.test(phone_num)==false ){
			alert("전화번호는 숫자 11자리로 입력해주시기 바랍니다.");
			empUpDelForm.find(".phone_num").val("");
			return;
		}	
		
		
		//------------------------------------------------
		// 현재 화면에서 페이지 이동 없이(=비동기 방식으로)
		// 웹서버쪽 "/empUpProc.do" 로 접속해서 수정하기
		//------------------------------------------------
		$.ajax({
				//-------------------------------
				// 서버 쪽 호출 URL 주소 지정
				//-------------------------------
				url : "/empUpProc.do"
				//-------------------------------
				// form 태그 안의 입력양식 데이터 즉, 파라미터값을 보내는 방법 지정
				//-------------------------------
				, type : "post"
				//-------------------------------
				// 서버로 보내는 데이터  설정하기.
				//-------------------------------
				,data: $("[name='empUpDelForm']").serialize()
				//-------------------------------
				// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
				//-------------------------------  
				, success : 
					function( empUpCnt ){
					//alert(${requestScope.employeeDTO.emp_pwd_confirm}); return;
					if( empUpCnt==1 ){
						alert("직원정보 수정에 성공했습니다.");
						//return;
						document.empListForm.submit();
					}
					else if( empUpCnt==0 ){
						alert("삭제된 직원입니다.");
						document.empListForm.submit();
						
					}
					
					
					
			
					
				}
				
				
				
				/*
				function(){
					if(emp_pwd_confirm!=emp_pwd){
							alert("비밀번호가 일치하지 않습니다.")
							document.empListForm.submit();
						}
					else{
						alert("비밀번호가 일치합니다.")
						document.empListForm.submit();
					}
				}
				*/
					
				//-----------------------------------------------------
				// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
				//----------------------------------------------------------
				, error : function(){
					alert("서버 접속 실패");
				}
		});
	
	} // function checkEmpUpForm(){ 끝
		
		
	//**********************************************************
	// 삭제 관련 비동기 방식으로 웹서버에 접속하는  함수 선언
	//**********************************************************
	function checkEmpDelForm(){
			//-----------------------------------
			// 삭제 여부를 물어보기
			//-----------------------------------
			if( confirm("직원을 삭제하시겠습니까?")==false ) { return; }
			
			//------------------------------------------------
			// 현재 화면에서 페이지 이동 없이(=비동기 방식으로)
			// 웹서버쪽 "/boardDelProc.do" 로 접속해서 삭제하기
			// <주의> 게시판 삭제를 위해서는 [게시판 고유번호]와 [암호]가 필요하다.
			//        즉 웹서버쪽으로 삭제할 [게시판 고유번호]와 [암호]를 전달해줘야한다.
			//------------------------------------------------
			
			//alert(  $("[name='boardUpDelForm']").serialize()  ); return;
			
			$.ajax({
					//-------------------------------
					// 웹서버 접속 시 사용할 URL 주소 지정
					//-------------------------------
					url : "/empDelProc.do"
					//-------------------------------
					// form 태그 안의 입력양식 데이터 즉, 파라미터값을 보내는 방법 지정
					//-------------------------------
					, type : "post"
					//-------------------------------
					// 웹서버로 보내는 데이터  설정하기.
					//-------------------------------
					,data: $("[name='empUpDelForm']").serialize()
					//-------------------------------
					// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
					//-------------------------------  
					,success : function( empDelCnt ){
						//$("body").prepend( boardDelCnt + "<hr>")
						if( empDelCnt==1 ){
							alert("직원이 삭제되었습니다.");
							document.empListForm.submit();
						}
						else if( empDelCnt==0 ){
							alert("삭제된 직원입니다.");
							document.empListForm.submit();
						}
						/*
						else if( empDelCnt==-1 ){
							alert("암호가 틀립니다.");
							$("[name=pwd]").val("");
							$("[name=pwd]").focus();
						}
						*/
						/*
						else if( boardDelCnt==-2 ){
							alert("자식글이 있어서 삭제는 되지 않고 내용을 비웠습니다.");
							document.boardListForm.submit();
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
									<strong>직원 정보 수정</strong>			
									<span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>						
								</header>

							<!-- Content -->   
							<!--===========================================================-->
							<form name="empUpDelForm">
								<!--===========================================================-->                                                   
								   <table border=1 cellpadding="5" cellspacing="1" >
										<tr>
											<th>이름</th>
											<th>변경할 사번</th>
										</tr>
										<tr>
											<td>
												<input type="text" name="emp_name" class="emp_name" value="${requestScope.employeeDTO.emp_name}">
												
											</td>
											<td>
												<input type="text" name="emp_no" class="emp_no" value="${requestScope.employeeDTO.emp_no}" oninput = "emp_no_check()">
												<br> <div style="font-size:12px; font-style: italic;" >
														기존 사번: ${requestScope.employeeDTO.emp_no}
													</div>
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
											<th>새로운 암호</th>
											<th>새로운 암호확인</th>
										</tr>
										<tr>
											<td>
											   <input type="text" name="emp_pwd" class="emp_pwd">
														  <br> <div style="font-size:12px; font-style: italic;" >
																	기존 암호: ${requestScope.employeeDTO.emp_pwd}
																</div>
											</td>
											<td>
												 <input type="text" name="emp_pwd_confirm" class="emp_pwd_confirm">
												 ${requestScope.employeeDTO.emp_pwd_confirm}
													
											</td>
										</tr>
										<tr>
											<th>주민등록번호</th>
											<th>이메일</th>
										</tr>
										<tr>
											<td>
												<input type="text" name="jumin_num" class="jumin_num" value="${requestScope.employeeDTO.jumin_num}">
												
											</td>
											<td>
											<input type="text" name="email" class="email" value="${requestScope.employeeDTO.email}">
												
											</td>
										</tr>
										<tr>
											<th>권한설정</th>
											<th>소속부서</th>
										</tr>
										<tr>
											<td>
												
												
												<select name="emp_role" class="emp_role">
													<option value="user">일반계정</option>
													<option value="admin">관리자계정</option>
												</select>
												
											</td>
											<td>
												<select name="dep_no" class="dep_no">
													<option value="10">행정</option>
													<option value="20">사무</option>
													<option value="30">구매</option>
													<option value="40">접대</option>
													<option value="50">회계</option>
													<option value="60">기타</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>직급</th>
											<th>직속상관</th>
										</tr>
										<tr>
											<td>
												
												<select name="jikup_code" class="jikup_code">
													<option value="1">사장</option>
													<option value="2">부장</option>
													<option value="3">차장</option>
													<option value="4">과장</option>
													<option value="5">대리</option>
													<option value="6">사원</option>
												</select>
											</td>
											<td>
											<!-- <select>
													<option value="${requestScope.employeeDTO.mgr_emp_no}">
													${requestScope.employeeDTO.mgr_emp_no}
													</option>
													<input type="text" name="mgr_emp_no" class="mgr_emp_no" value="${requestScope.employeeDTO.mgr_emp_no}">
													
												</select>  -->
												
												
												
												
												
												<!-- <input type="text" name="mgr_emp_no" class="mgr_emp_no" value="${requestScope.employeeDTO.mgr_emp_no}"> -->
												<select name="mgr_emp_no" class="mgr_emp_no" >
													
												</select>
										   
											</td>
										</tr>
										<tr>
											<th>전화번호</th>
											<th>가입상태</th>
										</tr>
										<tr>
											<td>
												<input type="text" name="phone_num" class="phone_num" value="${requestScope.employeeDTO.phone_num}">
												
											</td>
											<td>
												<select name="allow_code" class="allow_code">
													<option value="1">가입승인</option>
													<option value="2">승인대기</option>
												</select>
											</td>
										</tr>
									</table>
									
									
									<center>
									<br>
									<input type="button" class="empUpBtn" name="empUpBtn" value="수정">
									<input type="button" class="empDelBtn" name="empDelBtn" value="삭제">
									<input type="button" class="empListBtn" name="empListBtn" value="취소">
									</form>
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


		<input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no }">	
		<!--===========================================================-->
		</form>
		<!--===========================================================-->
		<!-- 취소 누르면 들어갈 form 태그 -->
		<form name="empListForm" method="post" action="/empList.do"> 
			<%@include file="/WEB-INF/views/moveData_emp.jsp" %>
			
		</form>
		
		<!-- 수정 페이지 emp_pwd_confirm-->
		<form name="empUpDelForm" method="post" action="empUpDelForm.do"> 
			<input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}">
			
			<!--<input type="text" name="emp_pwd_confirm" value="${requestScope.employeeDTO.emp_pwd_confirm}">  -->
			
		</form>
		

	</body>
</html>