<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html><head>
<meta charset="UTF-8">
<script src="/js/jquery-1.11.0.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="/css/main.css" />	
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
		//----------------------------------------------
		// 수정/삭제 버튼에 클릭 이벤트가 발생하면 goBoardUpDelForm 함수 호출하기
		//----------------------------------------------
		$(".boardUpDelBtn").bind("click",function(){
			//alert("수정/삭제")
			//return;
			goBoardUpDelForm();
		});
		//----------------------------------------------
		// 목록보기 버튼에 클릭 이벤트가 발생하면 
		// name=boardListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
		//----------------------------------------------
		$(".boardListBtn").bind("click",function(){
			if("${requestScope.referer}"=="http://localhost:8081/main.do"){	
				//alert("메인에서왔어요");return;
				document.directBoardListForm.submit();
								
			}else{		
				//alert("메인아님");return;
				document.boardListForm.submit();	
			}
			
		});
	}) //$(function(){ 끝나는 지점
	
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 게시판 수정/삭제 화면으로 이동하는 함수 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	function goBoardUpDelForm(){
		//---------------------------------
		// name=boardUpDelForm 을 가진 form 태그의 action 값의 URL 주소로 서버에 접속하라
		// form 태그 내부의 입력양식들의 입력된 데이터도 서버로 전송된다.
		// 현재는 hidden 태그에 입려독된 게시판 번호가 전송된다.
		//---------------------------------
		document.boardUpDelForm.submit();
	
	}
	</script>
	
	
	
	
		</head>
	<body class="is-preload">
		<!--===========================================================-->
		<!-- <form name="boardRegForm" class="boardRegForm" method="post" action="/boardRegForm> -->
		<form name="boardDetailForm" > 
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
                                    	<th width="80">글번호</th>
                                        <td>
                                            ${requestScope.boardDTO.b_no}
                                        </td>
                                        <th>조회수</th>
                                        <td>
                                            ${requestScope.boardDTO.readcount}
                                        </td>
                                    <tr>
                                    	<th>작성자</th>
                                        <td>
                                            관리자
                                        </td>
                                        <th>작성일</th>
                                        <td>
                                            ${requestScope.boardDTO.reg_date}
                                        </td>
                                   	</tr>
                                        <th>글제목</th>
                                        <td colspan="3">
                                            ${requestScope.boardDTO.subject}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>글내용</th>
                                        <td colspan="3">
                                            <pre style='white-space:pre-wrap; word_wrap:break-word; word-break: break-all;'>${requestScope.boardDTO.content}</pre>
                                        </td>
                                    </tr>
                                </table>
                                
                                <!-- <c:if test="${!empty param.mom_b_no}">
								<input type="text" name="b_no" value="${param.mom_b_no}">
								</c:if> -->
                                
							
							
                                <br>
                                <br>
								<center>
								<%		
									String emp_role = (String)session.getAttribute("emp_role");
                               		if(emp_role != null ){
                            	   		if(emp_role.equals("admin")){%>
								  		<input type="button" name="boardUpDelBtn" class="boardUpDelBtn" value="수정/삭제"><%}}
								%>
                                
                                <input type="button" name="boardListBtn" class="boardListBtn" value="목록보기">
                                <!--===========================================================-->
								</form>
								<!--===========================================================-->
								<!--===========================================================-->
								<!-- 웹서버에 "/boardList.do"  URL 주소로 접속하기 위한 form 태그 선언-->
								<!--===========================================================-->
								<form name="boardListForm" method="post" action="/boardList.do"> 
									<%@include file="/WEB-INF/views/moveData.jsp" %>									
								</form>
								<form name="directBoardListForm" method="post" action="/boardList.do"> 
																		
								</form>
								
								<!--===========================================================-->
								<!-- 웹서버에 "/boardUpDelForm.do"  URL 주소로 접속하기 위한 form 태그 선언-->
								<!--===========================================================-->
								<form name="boardUpDelForm" method="post" action="/boardUpDelForm.do"> 
									<!----------------------------------------------------->
									<!-- 웹서버에 "/boardUpDelForm.do"  URL 주소로 접속할 때 가져갈 데이터 저장 목적의 hidden 태그 선언-->
									<!-- 현재 이 hidden 태그에는 수정삭제 할 게시판의 고유번호가 저장되어 있다.-->
									<!----------------------------------------------------->
									<input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">
									<%@include file="/WEB-INF/views/moveData.jsp" %>
								</form>
								
								<!--===========================================================-->
								<!-- 웹서버에 "/boardRegForm.do"  URL 주소로 접속하기 위한 form 태그 선언-->
								<!--===========================================================-->
								<form name="boardRegForm" method="post" action="/boardRegForm.do"> 
									<!----------------------------------------------------->
									<!-- 웹서버에 "/boardRegForm.do"  URL 주소로 접속할 때 가져갈 데이터 저장 목적의 hidden 태그 선언-->
									<!-- 현재 이 hidden 태그에는 댓글쓰기 화면에서 필요한 엄마 글 게시판의 고유번호가 저장되어 있다.-->
									<!----------------------------------------------------->
									<input type="hidden" name="mom_b_no" value="${requestScope.boardDTO.b_no}">
									<%@include file="/WEB-INF/views/moveData.jsp" %>
								</form>
							</section>
						</div>
					</div>
		
				<!-- Sidebar -->
					<div id="sidebar">
						<div class="inner">

							<!-- Search 
							<section id="search" class="alt">
									<form method="post" action="#">
										<input type="text" name="query" id="query" placeholder="Search" />
									</form>
							-->
								
								

							<!-- Menu -->
								<nav id="menu">
									<header class="major">
										<h2>Menu</h2>
									</header>
									<ul>
										<li><a href="/main.do">Homepage</a></li>
        
										<li>
											<span class="opener">전자결재</span>
											<ul>
												<li><a href="/dailyListForm.do">일일 업무보고서 결재</a></li>
												<li><a href="/expenseListForm.do">지출보고서 결재</a></li>
												<li><a href="#">휴가 신청서</a></li>
											</ul>
										</li>
										<li><a href="/planList.do">일정관리</a></li>
										<li><a href="/meetingBoardList.do">회의실 예약</a></li>
										<li><a href="/boardList.do">공지사항</a></li>
										<li><a href="/mypageMain.do">마이페이지</a></li>
										<%													
		                               		if(emp_role != null ){
		                            	   		if(emp_role.equals("admin")){%>
										  		<li><a href="/empList.do">관리자페이지</a></li><%}}
										%>
                                        

									</ul>
									<br><br><br><br><br><br><br>
									<input type="button" value="로그아웃" class="logoutBtn">
									
								</nav>

							

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