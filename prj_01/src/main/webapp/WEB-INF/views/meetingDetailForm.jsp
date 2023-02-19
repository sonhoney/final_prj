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
            function goUpdelform(){
                document.meetingUpDelForm.submit()
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
                                
                                <table border=1 cellpadding="5" cellspacing="1" >
                                    <tr>
                                        <th>소속부서</th>
                                        <th>${requestScope.meetingDTO.dep_name}</th>
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
                                            ${requestScope.meetingDTO.subject}
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>내용</th>
                                        <td>
                                            <!--<textarea  cols="30" rows="10" maxlength="500"></textarea>-->
                                            ${requestScope.meetingDTO.content}
                                            
                                        </td>
                                    </tr>
                                </table>
                                <br>
                                <br>
                                <center>
                                <!--
                                <input type="text" name="uid" class="uid" value="${sessionScope.uid}">
                                <input type="text" name="emp_no" class="emp_no" value="${requestScope.meetingDTO.emp_no}">
                                -->
                                <c:if test="${ requestScope.meetingDTO.emp_no eq sessionScope.uid }">
                                    <input type="button" value="수정" onclick="goUpdelform()">
                                </c:if> 
                                
                                <input type="button" value="목록" onclick="goboardList()" >
                                

<form name="meetingUpDelForm" method="post" action="/meetingUpDelForm.do">  
    <input type="hidden" name="b_no" class="b_no" value="${requestScope.meetingDTO.b_no}">
</form>   




<form name="meetingBoardList" method="post" action="/meetingBoardList.do">  
    <!--
    <input type="hidden" name="b_no" class="b_no" value="${requestScope.meetingDTO.b_no}">
    -->
    <!--
    <input type="text" name="keyword" class="keyword"  value="${param.keyword}">
    <input type="text" name="dep_no" class="dep_no"  value="${param.dep_no}">
    <input type="text" name="jikup_code" class="jikup_code"  value="${param.jikup_code}">
	<input type="text" name="selectPageNo" class="selectPageNo"  value="${param.selectPageNo}">
    -->
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