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
	<title>직원관리 상세페이지</title>	
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
			//로그아웃
			$(".logoutBtn").click(
			function(){
				if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
				location.replace("/logout.do");
			});			
			//alert(${requestScope.employeeDTO.emp_pwd_confirm});
			//return;
			

			
			//  empList_beforeAllowBtn 리스트 / empUpBtn 수정
			//----------------------------------------------
			// 수정/삭제 버튼에 클릭 이벤트가 발생하면 goBoardUpDelForm 함수 호출하기
			//----------------------------------------------
			$(".empUpBtn").bind("click",function(){
				goEmpUpForm();
			});
			//----------------------------------------------
			// 목록보기 버튼에 클릭 이벤트가 발생하면 
			// name=boardListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
			//----------------------------------------------
			$(".empListBtn").bind("click",function(){
				// name=boardListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
				document.empListForm.submit();
			});
			
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			// 게시판 수정/삭제 화면으로 이동하는 함수 선언
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			function goEmpUpForm(){
				//alert("수정버튼누름")
				//return;
				//---------------------------------
				// name=empdUpDelForm 을 가진 form 태그의 action 값의 URL 주소로 서버에 접속하라
				// form 태그 내부의 입력양식들의 입력된 데이터도 서버로 전송된다.
				// 현재는 hidden 태그에 입려독된 게시판 번호가 전송된다.
				//---------------------------------
				document.empUpDelForm.submit();
			}
			
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

        	$("[name=empDetailForm]").find(".emp_pwd_confirm").val("${requestScope.employeeDTO.emp_pwd_confirm}");
			
			
			
			
		}) // 	$(function(){ 끝

		
			
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
							<form name="empDetailForm" class="empDetailForm">
							<!--===========================================================-->                                                   
                                <table border=1 cellpadding="5" cellspacing="1" >
                                    <tr>
                                        <th>이름</th>
                                        <th>변경할 사번</th>
                                    </tr>
                                    <tr>
                                        <td>
                                            ${requestScope.employeeDTO.emp_name}
                                        </td>
                                        <td>
                                            ${requestScope.employeeDTO.emp_no}
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <th>주민등록번호</th>
                                        <th>이메일</th>
                                    </tr>
                                    <tr>
                                        <td>
                                            ${requestScope.employeeDTO.jumin_num}
                                        </td>
                                        <td>
                                        	${requestScope.employeeDTO.email}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>권한설정</th>
                                        <th>소속부서</th>
                                    </tr>
                                    <tr>
                                        <td>
                                        	<select name="emp_role" class="emp_role" disabled>
                                                <option value="user">일반계정</option>
                                                <option value="admin">관리자계정</option>
                                            </select>
                                           
                                        <!-- <select name="emp_role">
                                                 <option value="user">일반계정</option>
                                                <option value="admin">관리자계정</option>
                                            </select> -->
                                            
                                           
                                        </td>
                                        <td>
                                      	  <select name="dep_no" name="dep_no" disabled>
                                                <option value="10">행정</option>
	                                            <option value="20">사무</option>
	                                            <option value="30">구매</option>
	                                            <option value="40">접대</option>
	                                            <option value="50">회계</option>
	                                            <option value="60">기타</option>
                                            </select>
                                        	
                                        	<!--  <select name="dep_no" name="dep_no">
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
                                        <select name="jikup_code" class="jikup_code" disabled>
                                                <option value="1">사장</option>
	                                            <option value="2">부장</option>
	                                            <option value="3">차장</option>
	                                            <option value="4">과장</option>
	                                            <option value="5">대리</option>
	                                            <option value="6">사원</option>
                                            </select>
                                       
                                        	<!-- <select name="jikup_code" class="jikup_code">
                                                <option value="11">사원</option>
                                                <option value="22">주임</option>
                                                <option value="33">대리</option>
                                                <option value="44">과장</option>
                                                <option value="55">차장</option>
                                                <option value="66">팀장</option>
                                            </select> -->
                                            
                                        </td>
                                        <td>
                                        <select disabled>
                                                <option value="${requestScope.employeeDTO.mgr_emp_no}">${requestScope.employeeDTO.dep_name} ${requestScope.employeeDTO.emp_name2}</option>
                                            </select>
                                        <!-- <select >
                                                <option value="">-</option>
                                            </select> -->
                                           
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>전화번호</th>
                                        <th>가입상태</th>
                                    </tr>
                                    <tr>
                                        <td>
                                        	
                                            ${requestScope.employeeDTO.phone_num}
                                        </td>
                                        <td>
                                        <select name="allow_code" class="allow_code" value="${requestScope.employeeDTO.allow_code}" disabled>
                                                <option value="1">가입대기</option>
                                                <option value="2">승인대기</option>
                                            </select>
                                        	<!-- <select name="code_allow" class="code_allow">
                                                <option value="0">승인대기</option>
                                                <option value="100">가입승인</option>
                                            </select> -->
                                            
                                        </td>
                                    </tr>
                                </table>
                                <center>
                                <br>
                                <input type="button" class="empUpBtn" name="empUpBtn" value="수정하기">
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
		</form>
		<!--===========================================================-->
		<!-- 이게 boardList랑 같은 기능 -->
		<form name="empListForm" method="post" action="/empList.do"> 
			<%@include file="/WEB-INF/views/moveData_emp.jsp" %>
		</form>
		
		<!-- 수정할 때 들어갈 곳 -->
		<form name="empUpDelForm" method="post" action="/empUpDelForm.do"> 
			<input type="hidden" name="emp_no" class="emp_no" value="${requestScope.employeeDTO.emp_no}">
			<%@include file="/WEB-INF/views/moveData_emp.jsp" %>
		</form>
		
		
		
	</body>
</html>