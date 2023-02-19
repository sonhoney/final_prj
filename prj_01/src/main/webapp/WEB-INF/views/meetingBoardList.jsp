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
	<title>회의실 예약페이지</title>	
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
                    
                    <c:if test="${!empty param.keyword}">
                        $("[name='boardSearchForm']").find(".keyword").val("${param.keyword}")
                    </c:if>

                    <c:if test="${param.dep_no eq '0'  }">
                        $("[name='boardSearchForm']").find(".dep_no").val("0")
                    </c:if>
                    <c:if test="${ !empty param.dep_no  }">
                        $("[name='boardSearchForm']").find(".dep_no").val("${param.dep_no}")
                    </c:if>

                    <c:if test="${param.jikup_code eq '0'  }">
                        $("[name='boardSearchForm']").find(".jikup_code").val("0")
                    </c:if>
                    <c:if test="${ !empty param.jikup_code  }">
                        $("[name='boardSearchForm']").find(".jikup_code").val("${param.jikup_code}")
                    </c:if>

                    <c:if test="${param.rowCntPerPage eq '10'  }">
                        $("[name='boardSearchForm']").find(".rowCntPerPage").val("10")
                    </c:if>
                    <c:if test="${ !empty param.rowCntPerPage  }">
                        $("[name='boardSearchForm']").find(".rowCntPerPage").val("${param.rowCntPerPage}")
                    </c:if>

                    
                    
                })

                function goBoardDetailForm(b_no){
                    
                    $(".b_no").val(b_no)
                    document.meetingDetailForm.submit()
                }


                function goResForm(){
                    location.replace("/meetingResForm.do")
                }
                     
                function boardSearch(){
                    document.boardSearchForm.submit();
                }

                function boardSearchAll(){
                     
                    document.boardSearchForm.reset();
                    $("[name='boardSearchForm']").find(".searchBtn").click() 
                    //document.boardSearchForm.submit();
                }

                //**********************************************
                // [페이지 번호]를 클릭하면 호출되는 함수 선언
                //**********************************************
                function pageNoBtn( pageNo ){
                    
                    //------------------------------------
                    // class=selectPageNo 를 가진 입력양식에 
                    // 클릭한(=선택한) 페이지 번호를 value 값으로 삽입하기
                    // 왜? 서버에로 보낼려고!
                    //------------------------------------
                    $(".selectPageNo").val(pageNo);
                    //------------------------------------
                    // boardSearch 함수 호출하기
                    //------------------------------------
                    boardSearch();
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
                                        <strong>회의실 예약</strong>	
                                        <span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>
                                    </header>
    
                                <!-- Content -->
                                    <section>
                                        <header class="main">
                                            
                                        </header>
                                        <h3>예약목록</h3>
    
                                    <form name="boardSearchForm" method="post" action="/meetingBoardList.do">
                                            
                                            <input type="text" name="keyword" class="keyword"  width="100px" height="300px" placeholder="예약자,제목으로 검색" value=""> 
                                            <select name="dep_no" class="dep_no">
                                                <option value="0">소속부서</option>
                                                <option value="10">사무</option>
                                                <option value="20">행정</option>
                                                <option value="30">구매</option>
                                                <option value="40">접대</option>
                                                <option value="50">회계</option>
                                                <option value="60">기타</option>
                                            </select>  
                                            <select name="jikup_code" class="jikup_code" >
                                                <option value="0">직급</option>
                                                <option value="1">사장</option>
                                                <option value="2">부장</option>
                                                <option value="3">차장</option>
                                                <option value="4">과장</option>
                                                <option value="5">대리</option>
                                                <option value="6">사원</option>
                                            </select>
                                                
                                            <input type="button" value="검색" class="searchBtn" onclick="boardSearch()">
                                            <input type="button" value="모두검색" onclick="boardSearchAll()"> 
                                            
                                            [검색 총개수] :  ${requestScope.meetingSearchCnt}/${requestScope.meetingBoardTotCnt}개 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                            <select name="rowCntPerPage" class="rowCntPerPage" onChange="boardSearch()">
                                                <option value="10">10
                                                <option value="15">15
                                                <option value="20">20
                                                <option value="30">30
                                            </select> 행보기
                                        
                                        <br><br>
                                        
                                        <div class="searchingResults">
                                            <table>
                                                <tr>
                                                    <th>번호</th>
                                                    <th>소속부서</th>
                                                    <th>예약자</th>
                                                    <th>회의제목</th>
                                                    <th>내용</th>
                                                    <th>시작 시간</th>
                                                    <th>종료 시간</th>
                                                <c:forEach var="board" items="${requestScope.mboardList}" varStatus="loopTagStatus">
                                                <tr onclick="goBoardDetailForm( ${board.b_no} )" style="cursor:pointer;">
                                                    <td> ${board.b_no}  
                                                    <td> ${board.dep_name}
                                                    <td> ${board.emp_name}
                                                    <td> ${board.subject}
                                                    <td> ${board.content}
                                                    <td> ${board.min_meeting_time}
                                                    <td> ${board.max_meeting_time}
                                                </c:forEach>
                                            </table>
                                        </div>
<!------------------------------------------------->
<!--- 클릭한 페이지번호를 저장할 hidden 입력양식 선언.페이징 처리 관련 데이터이다.--->
<!------------------------------------------------->
<input type="hidden" name="selectPageNo" class="selectPageNo" value="1"> 
<!------------------------------------------------->
<!--- 한 화면에 보여지는 페이지 번호의 개수를 저장할 hidden 태그 선언.--->
<!------------------------------------------------->
<input type="hidden" name="pageNoCntPerPage" class="pageNoCntPerPage" value="10">                                         
                                        
                                        <!--
                                        <center name="paging">
                                            <span>[1]</span>
                                            <span>[2]</span>
                                            <span>[3]</span>
                                        </center>
                                        -->
        <center>
		<!----------------------------------------------------------->
		<!-- 검색된 게시판의 개수가 0개 보다 크면, 즉 검색된 게시판이 존재하면--->
		<!----------------------------------------------------------->
		<c:if test="${requestScope.meetingSearchCnt>0}">
			
			<!----------------------------------------------------------->
			<!-- [처음] 문자 출력--->
			<!----------------------------------------------------------->
			<span style="cursor:pointer" onclick="pageNoBtn(1);">[처음]</span>
			<!----------------------------------------------------------->
			<!-- [이전] 문자 출력--->
			<!----------------------------------------------------------->
			<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo}-1);">[이전]</span>
			
			<!----------------------------------------------------------->
			<!-- 선택한 페이지 번호에 대응하는 페이지 번호들을 출력--->
			<!----------------------------------------------------------->
			<c:forEach  var="no"  begin="${requestScope.pagingMap.begin_pageNo_perPage}"  
									     end="${requestScope.pagingMap.end_pageNo_perPage}" step="1"> 
					<!----------------------------------------------------------->
					<!-- 만약에 선택한 페이지 번호와 출력되는 페이지번호 다르면--->
					<!----------------------------------------------------------->
					<c:if test="${requestScope.pagingMap.selectPageNo!=no}">				     
						<span style="cursor:pointer" onclick="pageNoBtn(${no});">[${no}]</span>&nbsp;
					</c:if>
					<!----------------------------------------------------------->
					<!-- 만약에 선택한 페이지 번호와 출력되는 페이지번호 같으면--->
					<!----------------------------------------------------------->
					<c:if test="${requestScope.pagingMap.selectPageNo==no}">				     
						${no}&nbsp;
					</c:if>
			</c:forEach>
			
			<!----------------------------------------------------------->
			<!-- [다음] 문자 출력--->
			<!----------------------------------------------------------->
			<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo}+1);">[다음]</span>
			<!----------------------------------------------------------->
			<!-- [마지막] 문자 출력--->
			<!----------------------------------------------------------->
			<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.last_pageNo});">[마지막]</span>
			
		</c:if>
        </center>                        
                     
                                        

                                    

                                            <div style="float:right" ><input type="button"  value="회의실 예약 페이지 이동" onclick="goResForm()"> </div>
                                    </form>


<form name="meetingDetailForm" method="post" action="/meetingDetailForm.do">  
    <input type="hidden" name="b_no" class="b_no" >
	<input type="hidden" name="keyword" class="keyword"  value="${param.keyword}">
    <input type="hidden" name="dep_no" class="dep_no"  value="${param.dep_no}">
    <input type="hidden" name="jikup_code" class="jikup_code"  value="${param.jikup_code}">
	<input type="hidden" name="selectPageNo" class="selectPageNo"  value="${param.selectPageNo}">

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