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
	<title>공지사항 등록페이지</title>	
		<link rel="stylesheet" href="/css/main.css" />
	<!-- ******************************************************** -->
	<!--  JQuery 라이브러리 수입하기 -->
	<!-- ******************************************************** -->
	<script src="/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>	
	<script>
	<%String referer = request.getHeader("referer");%>
	//******************************************************** 
	// body 태그 안의 모든 내용을 읽어들인 이후 호출할 자스 코딩 설정하기
	//******************************************************** 
	$(function(){

		//로그아웃
		$(".logoutBtn").click(
		function(){
			if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
			location.replace("/logout.do");
		});
		//----------------------------------------------
		// 수정 버튼에 클릭 이벤트가 발생하면 checkBoardUpDelForm 함수 호출하기
		//----------------------------------------------
		$(".boardUpBtn").bind("click",function(){

			checkBoardUpForm();
		});

		//----------------------------------------------
		// 삭제 버튼에 클릭 이벤트가 발생하면 checkBoardUpDelForm 함수 호출하기
		//----------------------------------------------
		$(".boardDelBtn").bind("click",function(){
			checkBoardDelForm();
		});
		
		//----------------------------------------------
		// 목록보기 버튼에 클릭 이벤트가 발생하면 
		// name=boardListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
		//----------------------------------------------
		$(".boardListBtn").bind("click",function(){
			 //name=boardListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
			document.boardListForm.submit();
		});
		
	}) //$(function(){ 끝나는 지점
	
	
		
	//**********************************************************
	// 수정 관련 유효성 체크,비동기 방식으로 웹서버에 접속하는  함수 선언
	//**********************************************************
	function checkBoardUpForm(){
		//alert(   $("[name='boardUpDelForm']").serialize()  ); return;
	
			//-----------------------------------
			// 수정 관련 유효성 체크
			//-----------------------------------
			var formObj = $("[name='boardUpDelForm']");			
			// 제목 가져와서 변수 subject 에 저장하기
			var subject = formObj.find(".subject").val(); 
				// 만약에 subject 변수안의 데이터가 String 이 아니면 "" 저장하기
				if( typeof(subject)!="string" ) { subject = ""; }
			// subject 변수안의 데이터의 앞뒤 공백 제거하기
			subject = $.trim(subject);
			// subject 변수안의 데이터를 웹화면에 삽입하기
			formObj.find(".subject").val(subject);
			// 제목이 15자보다 크면 경고하고 함수 중단
			if( subject.length>40 ){
				alert("제목은 1~40자까지 입력 해야합니다.");				
				formObj.find(".subject").val(  ""  );
				return;
			}  
			// 제목이 "" 면 경고하고 함수 중단
			else if(subject.length==0 ){
				alert("제목은 한글자 이상 입력 해야합니다.");
				return;
			}
			// 제목에 <script> 이 들어 있으면 경고 하고 함수 중단하기
			if( subject.toUpperCase().indexOf(  ("<script>").toUpperCase()  )>=0 ){
				alert("제목에 <script>  는 사용할 수 없습니다.");
				formObj.find(".subject").val(  ""  );
				return;
			}  
			// 내용 가져와서 변수 content 에 저장하기
			var content = formObj.find(".content").val(); 
			// 내용 가져와서 변수 content 에 저장하기
			var content = formObj.find(".content").val(); 
				// 만약에 content 변수안의 데이터가 String 이 아니면 "" 저장하기
				if( typeof(content)!="string" ) { content = ""; }
			// content 변수안의 데이터의 앞뒤 공백 제거하기
			content = $.trim(content);
			// content 변수안의 데이터를 웹화면에 삽입하기
			formObj.find(".content").val(content);
			// 내용이 500 자보다 크면 경고하고 함수 중단
			if( content.length>2000 ){
				alert("내용은 1~2000자까지 입력 해야합니다.");				
				formObj.find(".content").val(  ""  );				
				return;
			}  
			// 내용이 "" 면 경고하고 함수 중단
			else if(content.length==0 ){
				alert("내용은 한글자 이상 입력 해야합니다.");
				return;
			}
			// 내용에 <script> 이 들어 있으면 경고 하고 함수 중단하기
			if( subject.toUpperCase().indexOf(  ("<script>").toUpperCase()  )>=0 ){
				alert("내용에 <script>  는 사용할 수 없습니다.");
				formObj.find(".content").val(  ""  );
				return;
			}
			//-----------------------------------
			// 수정여부를 물어보기
			//-----------------------------------
			if( confirm("정말 수정하시겠습니까?")==false ) { return; }
			
			//------------------------------------------------
			// 현재 화면에서 페이지 이동 없이(=비동기 방식으로)
			// 웹서버쪽 "/boardUpProc.do" 로 접속해서 수정하기
			//------------------------------------------------
			$.ajax({
					//-------------------------------
					// 서버 쪽 호출 URL 주소 지정
					//-------------------------------
					url : "/boardUpProc.do"
					//-------------------------------
					// form 태그 안의 입력양식 데이터 즉, 파라미터값을 보내는 방법 지정
					//-------------------------------
					, type : "post"
					//-------------------------------
					// 서버로 보내는 데이터  설정하기.
					//-------------------------------
					,data: $("[name='boardUpDelForm']").serialize()
					//-------------------------------
					// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
					//-------------------------------  
					, success : function( boardUpCnt ){
						
						if( boardUpCnt==1 ){
							alert("수정이 성공했습니다.");
							document.boardListForm.submit();
						}
						else{
							alert("삭제된 게시물입니다.");
							document.boardListForm.submit();
							
						}
						
					}
					//-----------------------------------------------------
					// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
					//----------------------------------------------------------
					, error : function(){
						alert("서버 접속 실패");
					}
			});

	}
	
	
	//**********************************************************
	// 삭제 관련 비동기 방식으로 웹서버에 접속하는  함수 선언
	//**********************************************************
	function checkBoardDelForm(){
		//alert(   $("[name='boardUpDelForm']").serialize()  ); return;
			
			//-----------------------------------
			// 삭제 여부를 물어보기
			//-----------------------------------
			if( confirm("정말 삭제하시겠습니까?")==false ) { return; }
			
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
					url : "/boardDelProc.do"
					//-------------------------------
					// form 태그 안의 입력양식 데이터 즉, 파라미터값을 보내는 방법 지정
					//-------------------------------
					, type : "post"
					//-------------------------------
					// 웹서버로 보내는 데이터  설정하기.
					//-------------------------------
					,data: $("[name='boardUpDelForm']").serialize()
					//-------------------------------
					// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
					//-------------------------------  
					, success : function( boardDelCnt ){
						//$("body").prepend( boardDelCnt + "<hr>")
						if( boardDelCnt==1 ){
							alert("삭제가 성공했습니다.");
							document.boardListForm.submit();
						}
						else if( boardDelCnt==0 ){
							alert("삭제된 게시물입니다.");
							document.boardListForm.submit();							
						}
						
						
					}
					//-----------------------------------------------------
					// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
					//----------------------------------------------------------
					, error : function(){
						alert("서버 접속 실패");
					}
				
			});

		
	} //checkBoardUpForm(){ 끝
		
	</script>
		</head>
	<body class="is-preload">
		<!--===========================================================-->
		<!-- <form name="boardRegForm" class="boardRegForm" method="post" action="/boardRegForm> -->
		<form name="boardUpDelForm" > 
		<!--===========================================================-->

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">

							<!-- Header -->
								<header id="header">
									<strong>공지사항</strong>
									<span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>
								</header>

							<!-- Content -->                            
                               
                                <table border=1 cellpadding="5" cellspacing="1" >
                                    <tr>
                                        <th>제목</th>
                                        <td>
                                            <input type="text" name="subject" class="subject" size="40" maxlength="30" value="${requestScope.boardDTO.subject}">
            
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>내용</th>
                                        <td>
                                            <textarea  cols="30" rows="10" maxlength="500" name="content"  class="content">${requestScope.boardDTO.content}</textarea>
                                        </td>
                                    </tr>
                                </table>
                                <input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">  
							
							
                                <br>
                                <br>
								<center>
                                <input type="button" value="수정" class="boardUpBtn">    
								<input type="button" value="삭제" class="boardDelBtn"> 
								<input type="button" value="목록보기" class="boardListBtn">
								<!--===========================================================-->
								</form>
								<!--===========================================================-->
								<form name="boardListForm" method="post" action="/boardList.do"> 
									<%@include file="/WEB-INF/views/moveData.jsp" %>
								</form>	
								<form name="directBoardListForm" method="post" action="/boardList.do"> 
																		
								</form>
							</section>
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