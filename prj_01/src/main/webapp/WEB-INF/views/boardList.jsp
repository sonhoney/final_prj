<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html><head>
<meta charset="UTF-8">
<script src="/js/jquery-1.11.0.min.js"></script>

<script>
//******************************************************** 
// body 태그 안의 모든 내용을 읽어들인 이후 호출할 자스 코딩 설정하기
//******************************************************** 

var formObj1, formObj2, formObj3;


$(function(){
		//로그아웃
		$(".logoutBtn").click(
		function(){
			if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
			location.replace("/logout.do");
		});
	
		formObj1 = $("[name=boardSearchForm]");
		formObj2 = $("[name=boardRegForm]");
		formObj3 = $("[name=boardDetailForm]");
		
		
		//------------------------------------------------------------------------
		// 새글쓰기 버튼을 클릭하면 웹서버에 "/boardRegFom.do" URL 주소로 접속하기
		//------------------------------------------------------------------------
		$(".newRegBtn").bind("click",function(){			
			document.boardRegForm.action="/boardRegForm.do"			
			document.boardRegForm.method="post"			
			document.boardRegForm.submit();
		});		
		
		//------------------------------------------------------------------------
		// class=sortHeader 를 가진 태그에 클릭이벤트가 발생하면 실행할 자스 코딩 설정하기
		// 즉 게시판 검색물 헤더를 클릭하면 실행할 자스 코딩 설정하기
		//------------------------------------------------------------------------
		$(".sortHeader").click(function(){    // ▲ ▼
			var thisObj = $(this);
			var text = thisObj.text().trim();
			if( text=="조회수") {
				$(".sort").val( "readcount asc" )
			}
			else if( text=="조회수▲") {
				$(".sort").val( "readcount desc" )
			}
			else if( text=="조회수▼") {
				$(".sort").val( "" )
			}
			else if( text=="작성일") {
				$(".sort").val( "reg_date asc" )
			}
			else if( text=="작성일▲") {
				$(".sort").val( "reg_date desc" )
			}
			else if( text=="작성일▼") {
				$(".sort").val( "" )
			}
			// class=boardSearchBtn  가진 태그에 클릭이벤트 발생시키기
			$(".boardSearchBtn").click();
		})
		//------------------------------------------------------------------------
		// 검색 조건 관련 입력 양식에 흔적 남기기
		//------------------------------------------------------------------------
		//---------------------------------
		// class=keyword1 를 가진 태그, 즉 첫번째 키워드 입력양식에
		// "keyword1" 이라는 파라미터명에 해당하는 파리미터값을 넣어주기
		//---------------------------------
		formObj1.find(".keyword1").val("${param.keyword1}");
		//---------------------------------
		// class=keyword2 를 가진 태그, 즉 두번째 키워드 입력양식에
		// "keyword2" 이라는 파라미터명에 해당하는 파리미터값을 넣어주기
		//---------------------------------
		formObj1.find(".keyword2").val("${param.keyword2}");
		
		//------------------------------------
		// "orAnd" 라는 파라미터명의 파라미터값이 비어 있지 않으면 
		//------------------------------------
		<c:if test="${!empty param.orAnd}">
			//---------------
			// class=orAnd 를 가진 태그 입력양식에
			// "orAnd" 라는 파라미터명의 파라미터값을 넣어주기
			//---------------
			formObj1.find(".orAnd").val("${param.orAnd}");
		</c:if>
		
		
		//------------------------------------
		// "rowCntPerPage" 라는 파라미터명의 파라미터값이 비어 있지 않으면 
		//------------------------------------
		<c:if test="${!empty param.rowCntPerPage}">
			//---------------
			// class=rowCntPerPage 를 가진 태그 입력양식에
			// "rowCntPerPage" 라는 파라미터명의 파라미터값을 넣어주기
			//---------------
			formObj1.find(".rowCntPerPage").val("${param.rowCntPerPage}");
		</c:if>
		//------------------------------------
		// "selectPageNo" 라는 파라미터명의 파라미터값이 비어 있지 않으면 
		//------------------------------------
		<c:if test="${!empty requestScope.selectPageNo}">
			//---------------
			// class=selectPageNo 를 가진 태그 입력양식에
			// "selectPageNo" 라는 파라미터명의 파라미터값을 넣어주기
			//---------------
			formObj1.find(".selectPageNo").val("${requestScope.selectPageNo}");
		</c:if>
		
		<c:forEach var="xxx" items="${paramValues.date}">
			formObj1.find(".date").filter("[value='${xxx}']").prop("checked",true);
		</c:forEach>
		
		//------------------------------------
		// 만약 sort 라는 파라미터명에 파라미터값이 존재하면,
		// "/boardList.do" 로 접속하면 들고온 sort 라는 파라미터명에 파라미터값이 존재하면,
		//------------------------------------
		
		<c:if test="${!empty param.sort}">
		// class=sort 를 가진 hidden 태그의 value 값을 sort 라는 파라미터명에 파라미터값을 넣어주기
		formObj1.find(".sort").val("${param.sort}");
		// class=sortHeader 를 가진 태그, 즉 헤더 들을 잡고 아래에 지정된 자스코드를 실행하기
		$(".sortHeader").each(function(){
			// class=sortHeader 를 가진 태그 중에 i 번째 태그를 관리하는 JQuery 객체 얻기
			var thisObj = $(this);
			// i 번째 태그가 안고 있는 문자 얻기
			var text = thisObj.text().trim();
			// i 번째 태그가 안고 있는 문자에서 "▲" 와 "▼"  모두 제거하기
			text = text.replace("▲","").replace("▼","");
			// i 번째 태그 안에 "▲" 와 "▼"  모두 제거하고 남은 헤더 문자를 삽입하기
			thisObj.text(text);

			// sort 라는 파라미터명에 파라미터값이 "readcount asc" 이고 i 번째 태그가 안고 있는 문자가 "조회수" 라면
			if( "${param.sort}"=="readcount asc" && text=="조회수") {
				// i 번째 태그가 안고 있는 문자 뒤에 "▲"  삽입하라
				thisObj.append("▲")
			}
			// sort 라는 파라미터명에 파라미터값이 "readcount desc" 이고 i 번째 태그가 안고 있는 문자가 "조회수" 라면
			else if( "${param.sort}"=="readcount desc" && text=="조회수") {
				// i 번째 태그가 안고 있는 문자 뒤에 "▼"  삽입하라
				thisObj.append("▼")
			}
			// sort 라는 파라미터명에 파라미터값이 "reg_date asc" 이고 i 번째 태그가 안고 있는 문자가 "작성일" 라면
			else if( "${param.sort}"=="reg_date asc" && text=="작성일") {
				// i 번째 태그가 안고 있는 문자 뒤에 "▲"  삽입하라
				thisObj.append("▲")
			}
			// sort 라는 파라미터명에 파라미터값이 "reg_date desc" 이고 i 번째 태그가 안고 있는 문자가 "작성일" 라면
			else if( "${param.sort}"=="reg_date desc" && text=="작성일") {
				// i 번째 태그가 안고 있는 문자 뒤에 "▼"  삽입하라
				thisObj.append("▼")
			}
		})
		</c:if>
	}) //$(function(){ 끝나는 지점
	//************************************************
	// 검색 조건 데이터를 name=boardRegForm 를 가진 
	// form 태그 내부의 입력양식으로 복사해서 붙이는 함수 선언
	//************************************************
	function searchForm_to_regfom(){
		clone( formObj2.find(".selectPageNo"), formObj1.find(".selectPageNo") )
		formObj2.find(".selectPageNo").val(
				formObj1.find(".selectPageNo").val()
		);
		formObj2.find(".rowCntPerPage").val(
				formObj1.find(".rowCntPerPage").val()
		);
		formObj2.find(".keyword1").val(
				formObj1.find(".keyword1").val()
		);
		formObj2.find(".keyword2").val(
				formObj1.find(".keyword2").val()
		);
	
		formObj2.find(".sort").val(
				formObj1.find(".sort").val()
		);
		//----------------------------------------------------
		formObj1.find(".date").each(function(i){
			formObj2.find(".date").eq(i).prop(
					"checked", $(this).is(":checked")
			)
		});
	}
	
		function goBoardDetailForm(
				b_no	//클릭한 행의 게시판 번호가 들어오는 매개변수
		){
		
			document.boardDetailForm.action = "/boardDetailForm.do";
			document.boardDetailForm.method = "post";
			//----------------------------------------------------
			formObj3.find(".selectPageNo").val(
					formObj1.find(".selectPageNo").val()
			);
			formObj3.find(".rowCntPerPage").val(
					formObj1.find(".rowCntPerPage").val()
			);
			
			formObj3.find(".keyword1").val(
					formObj1.find(".keyword1").val()
			);
			formObj3.find(".keyword2").val(
					formObj1.find(".keyword2").val()
			);
			
			formObj3.find(".sort").val(
					formObj1.find(".sort").val()
			);
			//----------------------------------------------------
			formObj1.find(".date").each(function(i){
				formObj3.find(".date").eq(i).prop(
						"checked", $(this).is(":checked")
				)
			});
			
			//-------------------------------------------------
			// name=boardDetailForm 를 가진 form 태그 내부에 
			// name=b_no 가진 태그에 매개변수로 들어온 게시판 번호를 삽입해라
			//-------------------------------------------------
			formObj3.find("[name=b_no]").val(b_no);
			document.boardDetailForm.submit();
		}
		//************************************************
		// [검색 버튼] 클릭했을 때 호출되는 함수 선언.
		//************************************************
		function boardSearch( ){
			
			//alert("검색버튼누름")
			//return;
		
			// 입력한 키워드 가져와서 변수 keyword1 에 저장하기
			var keyword1 = $(".keyword1").val();
			// keyword1 변수안에 문자가 아닌 데이터가 있으면 길이가 없는 문자로 대체하기
			if( typeof(keyword1)!="string"){ keyword1 = ""; }
			// keyword1 변수안에 문자에 앞뒤 공백 제거하기
			keyword1 = $.trim(keyword1);
			// 웹 화면의 키워드 입력란에 앞뒤 공백 제거한 문자 삽입하기
			$(".keyword1").val(keyword1);
				// 위 코드는 //keyword1 = keyword1.trim(); 도 대체 가능. 단 사망하신 익스플러9 이하에선 안됨.
			//--------------------------------------------------------
			// 입력한 키워드 가져와서 변수 keyword2 에 저장하기
			var keyword2 = $(".keyword2").val();
			// keyword2 변수안에 문자가 아닌 데이터가 있으면 길이가 없는 문자로 대체하기
			if( typeof(keyword2)!="string"){ keyword2 = ""; }
			// keyword2 변수안에 문자에 앞뒤 공백 제거하기
			keyword2 = $.trim(keyword2);
			// 웹 화면의 키워드 입력란에 앞뒤 공백 제거한 문자 삽입하기
			$(".keyword2").val(keyword2);
				// 위 코드는 //keyword2 = keyword1.trim(); 도 대체 가능. 단 사망하신 익스플러9 이하에선 안됨.
			//--------------------------------------------------------
			document.boardSearchForm.submit();
		}
	
		//************************************************
		// [모두 검색] 버튼 클릭했을 때 호출되는 함수 선언.
		//************************************************
		function boardSearchAll( ){
			
			//alert("모두검색")
			//return;
			
			document.boardSearchForm.reset();
			// 웹 화면의 키워드 입력란에 "" 삽입하기
			$(".keyword1").val("");
			
			// 웹 화면의 키워드2 입력란에 "" 삽입하기
			$(".keyword2").val("");
			$(".orAnd").val("or");
			$(".date").prop("checked",false);
			$(".sort").val("");
			// class=boardSearchBtn  가진 태그에 클릭이벤트 발생시키기
			$(".boardSearchBtn").click();
				//위 코드는 왼쪽 코드로 대체가 가능하다.  document.boardSearchForm.submit();
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
	
	
		<title>공지사항</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/css/main.css" />
	</head>
	<body class="is-preload">

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
							<br>
							<!-- Content -->	
								<center>
								<!--**********************************************************-->
								<!-- [게시판 검색 조건 입력 양식] 내포한 form 태그 선언 -->
								<!--********************************************************** -->
								<form name="boardSearchForm" method="post" action="/boardList.do">					                              
                                
                                
                                <!--  키워드 입력할 입력양식 -->
                                <input type="text" name="keyword1" class="keyword1" size="50" value="${param.keyword1}">
								<select name="orAnd">
									<option value="or" ${param.orAnd=='or'?'selected':''}>or
									<option value="and"  ${param.orAnd=='and'?'selected':''}>and
								</select>
								<input type="text" name="keyword2" class="keyword2"  size="50" value="${param.keyword2}">
								<!-- 텍스트상자 orand 텍스트상자 끝 -->
								
								
								
												
								<!-- 날짜 검색 -->
                                <input type="checkbox" name="date" class="date"  value="-0">오늘
								<input type="checkbox" name="date" class="date"  value="-1">어제
                                
                                <!-- 검색버튼 -->
                                <input type="button" class="boardSearchBtn" name="boardSearchBtn" onClick="boardSearch( );" value="검색" >
                                <input type="button" class="boardSearchAllBtn" name="boardSearchAllBtn" onClick="boardSearchAll( );" value="모두검색">
                                
                                <input type="hidden" name="sort" class="sort">
                                
                                <select name="rowCntPerPage" class="rowCntPerPage" onChange="boardSearch( );">
                                    <option value="10">10개</option>
                                    <option value="15">15개</option>
                                    <option value="20">20개</option>
                                </select>
                                
                                <!------------------------------------------------->
								<!--- 클릭한 페이지번호를 저장할 hidden 입력양식 선언.페이징 처리 관련 데이터이다.--->
								<!------------------------------------------------->
								<input type="hidden" name="selectPageNo" class="selectPageNo" value="1"> 
								<!------------------------------------------------->
								<!--- 한 화면에 보여지는 페이지 번호의 개수를 저장할 hidden 태그 선언.--->
								<!------------------------------------------------->
								<input type="hidden" name="pageNoCntPerPage" class="pageNoCntPerPage" value="10"> 
                               
                                <!-- =================================== -->
                                <!-- 검색화면 form -->
                                <!-- =================================== -->
                                
                                <br>
                                <br>
                                </center>
                                
                                <table border=1 cellpadding="5" cellspacing="1" >
                                
                                    <tr >
                                        <th>글번호</th>
                                        <th>제목</th>
                                        <th>글쓴이</th>
                                        <th><span style="cursor:pointer;" class="sortHeader">조회수</span> 
										<th><span style="cursor:pointer;" class="sortHeader">작성일</span>
                                    </tr>
                                    
					            <!--  sql에서 입력한 게시판 insert구문 getBoard 구문에 맞게 불러오기  -->                       
								<c:forEach var="board" items="${requestScope.boardList}" varStatus="loopTagStatus">
									<tr
									onClick="goBoardDetailForm(${board.b_no})" style="cursor:pointer" >
										<td> ${requestScope.pagingMap.serialNo_desc - loopTagStatus.index}  
										
										
										<td> 
										<!-- <c:forEach begin="1" end="${board.prnumber_level}">
												&nbsp;&nbsp;
											</c:forEach>
										
											<c:if test="${board.prnumber_level>0}">
												ㄴ
											</c:if> -->
											${board.subject}
										
										
										
										
										<td>관리자
										<td>${board.readcount}
										<td>${board.reg_date}
						</c:forEach>                                    
                                    
                                    
                                    
                                </table>
                                <!-- 테이블 끝 -->
                                
                                
                          
                           </form>
                           <center>
                        	<!----------------------------------------------------------->
							<!-- 검색된 게시판의 개수가 0개 보다 크면, 즉 검색된 게시판이 존재하면--->
							<!----------------------------------------------------------->
							<c:if test="${requestScope.boardTotCnt>0}">
									
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
								  
                                <form name="boardRegForm"> 
									<%@include file="/WEB-INF/views/moveData.jsp" %>
                                </form>
                                
                                <form name="boardDetailForm" method="post" action="/boardDetailForm.do">  
                                	<input type="hidden" name="b_no">
									<%@include file="/WEB-INF/views/moveData.jsp" %>
                               	</form>
								
                        
                             
                               	<%
                               		String emp_role = (String)session.getAttribute("emp_role");
                               		if(emp_role != null ){
                            	   		if(emp_role.equals("admin")){%>
								  		<input type="button" value="글쓰기" name="newRegBtn" class="newRegBtn" ><%}}
								%>
							</section>
						</div>
					</div>

				<!-- Sidebar -->
					<div id="sidebar">
						<div class="inner">

							

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
												<li><a href="/salesListForm.do">영업 업무보고서 결재</a></li>
												<li><a href="/expenseListForm.do">지출 업무보고서 결재</a></li>
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