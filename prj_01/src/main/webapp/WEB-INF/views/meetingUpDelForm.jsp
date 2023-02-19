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
	<title>회의실 예약상세페이지</title>	
		<link rel="stylesheet" href="/css/main.css" />
	<!-- ******************************************************** -->
	<!--  JQuery 라이브러리 수입하기 -->
	<!-- ******************************************************** -->
	<script src="/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	
	
	<script>
            
        $(function(){
            //로그아웃
			$(".logoutBtn").click(
			function(){
				if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
				location.replace("/logout.do");
			});
            
        })    
        
                function goboardList(){
                    document.meetingBoardList.submit()
                }
                function meetingUpProc(){

                    if( confirm("정말 수정 하시겠습니까?")==false ) { return; }

                    $.ajax({
					
                        url : "/meetingUpProc.do"
                        , type : "post"
                        ,data: $("[name='meetingUpDelForm']").serialize()
                        , success : function( upCnt ){
                            if( upCnt==1 ){
                                alert("수정이 성공했습니다.");
                                document.meetingBoardList.submit();
                            }

                        }
                        //-----------------------------------------------------
                        // 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
                        //----------------------------------------------------------
                        , error : function(){
                            alert("서버 접속 실패");
                        }

			        })

                }

                function meetingDelProc(){

                    if( confirm("정말 삭제 하시겠습니까?")==false ) { return; }

                    $.ajax({
					
                        url : "/meetingDelProc.do"
                        , type : "post"
                        ,data: $("[name='meetingUpDelForm']").serialize()
                        , success : function( delCnt ){
                            if( delCnt==1 ){
                                alert("삭제 성공했습니다.");
                                document.meetingBoardList.submit();
                            }

                        }
                        //-----------------------------------------------------
                        // 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
                        //----------------------------------------------------------
                        , error : function(){
                            alert("서버 접속 실패");
                        }

			        })

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
                                        <strong>예약 상세화면</strong>
                                        <span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>
                                    </header>
    
                                <!-- Content -->     
                                 
                                                    
                                <form name="meetingUpDelForm" > 
                                    <table>
                                        <tr>
                                            <th>소속부서</th>
                                            <th name="dep_name">${requestScope.meetingDTO.dep_name}</th>
                                        </tr>
                                        <tr>
                                            <th>예약자</th>
                                            <td>${requestScope.meetingDTO.emp_name}</td>
                                        </tr>
                                        <tr>
                                            <th>예약회의실</th>
                                            <td>${requestScope.meetingDTO.room_name}</td>
                                        </tr>
                                        <tr>
                                            <th>제목</th>
                                            <td>
                                                <input type="text" name="subject" value="${requestScope.meetingDTO.subject}">
                                            </td>
                                        </tr>
    
                                        <tr>
                                            <th>내용</th>
                                            <td>
                                                <!--<textarea  cols="30" rows="10" maxlength="500"></textarea>-->
                                                <textarea  name="content" cols="30" rows="10" >${requestScope.meetingDTO.content}</textarea>
                                            </td>
                                        </tr>
                                    </table>
                                    <br>
                                    <br>
                                    <center>
                                    <input type="button" value="수정" onclick="meetingUpProc()">
                                    <input type="button" value="삭제" onclick="meetingDelProc()">
                                    <input type="button" value="목록" onclick="goboardList()" >
                                    <input type="hidden" name="b_no" value="${requestScope.meetingDTO.b_no}">

                                </form> 


                            </div>
                        </div>
                        
<form name ="meetingBoardList" method="post" action="/meetingBoardList.do">

</form>
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