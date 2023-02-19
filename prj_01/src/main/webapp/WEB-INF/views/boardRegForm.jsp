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

		
		//------------------------------------------------------------------------
		// 등록 버튼을 클릭하면 boardRegBtnCheck 함수 호출
		//------------------------------------------------------------------------
		$(".boardRegBtn").bind("click",function(){
			
			boardRegBtnCheck();
		});
		
		//----------------------------------------------
		// 목록보기 버튼에 클릭 이벤트가 발생하면 
		// name=boardListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
		//----------------------------------------------
		$(".boardListBtn").bind("click",function(){
			
			
			// name=boardListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
			document.boardListForm.submit();
		});
	}) //$(function(){ 끝나는 지점
	
	
		
	//**********************************************************
	// 유효성 체크,비동기 방식으로 웹서버에 접속하는  함수 선언
	//**********************************************************
	function boardRegBtnCheck(){
		
		var formObj = $("[name='boardRegForm']");
		// 제목 가져와서 변수 subject 에 저장하기
		var subject = formObj.find(".subject").val(); 
		// 만약에 subject 변수안의 데이터가 String 이 아니면 "" 저장하기
		if( typeof(subject)!="string" ) { subject = ""; }
		// subject 변수안의 데이터의 앞뒤 공백 제거하기
		subject = $.trim(subject);
		// subject 변수안의 데이터를 웹화면에 삽입하기
		formObj.find(".subject").val(subject);
		// 제목이 40자보다 크면 경고하고 함수 중단
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
		// 내용이 2000 자보다 크면 경고하고 함수 중단
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
		//------------------------------------------------
		// 비동기 방식으로 웹서버에 접속해서 
		// 게시판 새글쓰기 관련 입력양식의 데이터 전송하기
		//------------------------------------------------
		$.ajax( {
				//------------------------------------------
				// 웹서버에 접속할 떄 사용할 URL 주소 지정
				//------------------------------------------
				url:"/boardRegProc.do"
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
				,data:$("[name='boardRegForm']").serialize()
				//----------------------------------------------------------
				// 웹서버와 통신한 후 웹서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
				// 익명함수의 매개변수에는 웹서버가 보내온 [새글의 입력된 행 개수]가 들어온다
				//----------------------------------------------------------
				,success:function(regCnt){
					//---------------------------------
					// 게시판 글 입력 성공 행의 개수가 1이면, 즉 입력이 성공했으면
					//---------------------------------
					if(regCnt==1){
							location.replace("/boardList.do");
					}else{
						alert("새글 쓰기가 실패하였습니다.");
					}
				}
				// 웹서버와 통신이 실패했을 경우 실행할 익명함수 설정.
				//----------------------------------------------------------
				,error:function( ){
					alert("웹서버 접속에 실패했습니다. 관리자에게 문의바랍니다.");
				}
		} )
		
	} //boardRegBtnCheck(){ 끝
	
	</script>
		</head>
	<body class="is-preload">
		
		<!--===========================================================-->
		<!-- <form name="boardRegForm" class="boardRegForm" method="post" action="/boardRegForm> -->
		<form name="boardRegForm" > 
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
                                            <input type="text" name="subject" class="subject" size="40" maxlength="30">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>내용</th>
                                        <td>
                                        	<textarea id="editor" name="content" class="content" rows="10"></textarea>
                                        	


<!--  <textarea  cols="30" rows="10" maxlength="500" name="content"  class="content"></textarea> -->
                                           
                                        
                                        
                                        
                                        </td>
                                    </tr>
                                </table>
                                
                                
                                
								
									<c:if test="${!empty param.mom_b_no}">
								<input type="text" name="b_no" value="${param.mom_b_no}">
								</c:if>
								 
							
							
                                <br>
                                <br>
								<center>
                                <input type="button" name="boardRegBtn" class="boardRegBtn" value="등록">
                                <input type="button" name="boardListBtn" class="boardListBtn" value="취소">
                                <!--===========================================================-->
								</form>
								<!--===========================================================-->
								<!--===========================================================-->
								<!-- 웹서버에 "/boardList.do"  URL 주소로 접속하기 위한 form 태그 선언-->
								<!--===========================================================-->
								<form name="boardListForm" method="post" action="/boardList.do"></form>
									<%@include file="/WEB-INF/views/moveData.jsp" %>									
									
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



<script type="text/javascript">
CKEDITOR.replace("content");
</script>