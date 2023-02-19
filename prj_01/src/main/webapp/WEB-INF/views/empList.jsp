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
	<title>직원관리 페이지</title>	
		<link rel="stylesheet" href="/css/main.css" />
	<!-- ******************************************************** -->
	<!--  JQuery 라이브러리 수입하기 -->
	<!-- ******************************************************** -->
	<script src="/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>	
	<script>
	
		var empSearchForm, empRegForm, empDetailForm
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

			

			empSearchForm = $("[name=empSearchForm]");
			empRegForm =  $("[name=empRegForm]");
			empDetailForm = $("[name=empDetailForm]");
			
			
			//----------------------------------------------
			// 직원관리 페이지 이동 버튼에 클릭 이벤트가 발생하면 
			// name=empListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
			//----------------------------------------------
			$(".empListBtn").bind("click",function(){
				
				
				// name=empListForm  을 가지 form 태그의 action 값의 URL 주소로 웹서버에 접속하기
				document.empListForm.submit();
			});
			
			//----------------------------------------------
			// 등록 버튼 누르기
			//----------------------------------------------
			$(".newEmpBtn").bind("click",function(){
				//alert("버튼누름"); return;
				goEmpRegForm();
				//alert("등록 버튼 누름")
				//return;
				
				//searchForm_to_regfom();
				//alert("왜 안 되지?"); return;
				
					
				// name=empRegForm  를 가진 form 태그의 action 값 설정하기
				//document.empRegForm.action="/empRegForm.do";
				// name=empRegForm  를 가진 form 태그의 method 값 설정하기
				//document.empRegForm.method="post";
				// name=empRegForm  를 가진 form 태그의 action 값에 해당한 URL 주소로 웹서버 접속하기
				//document.empRegForm.submit();
			});
			
			//------------------------------------------------------------------------
			// class=sortHeader 를 가진 태그(글번호, 직원번호 <th>)에 클릭이벤트가 발생하면 실행할 자스 코딩 설정하기
			// 즉 게시판 검색물 헤더를 클릭하면 실행할 자스 코딩 설정하기
			//------------------------------------------------------------------------
			$(".sortHeader").click(function(){
				//alert("헤더 클릭함"); return;
			
				var thisObj = $(this);
				var text = thisObj.text().trim();
				
				if( text=="사번") {
					$(".sort").val( "e1.emp_no asc" )
				}
				else if( text=="사번▲") {
					$(".sort").val( "e1.emp_no desc" )
				}
				else if( text=="사번▼") {
					$(".sort").val( "" )
				}
				
				
				else if( text=="이름") {
					$(".sort").val( "e1.emp_name asc" )
				}
				else if( text=="이름▲") {
					$(".sort").val( "e1.emp_name desc" )
				}
				else if( text=="이름▼") {
					$(".sort").val( "" )
				}
				
				
				else if( text=="직급") {
					$(".sort").val( "e1.jikup_code asc" )
				}
				else if( text=="직급▲") {
					$(".sort").val( "e1.jikup_code desc" )
				}
				else if( text=="직급▼") {
					$(".sort").val( "" )
				}
				
				
				else if( text=="부서") {
					$(".sort").val( "d.dep_name asc" )
				}
				else if( text=="부서▲") {
					$(".sort").val( "d.dep_name desc" )
				}
				else if( text=="부서▼") {
					$(".sort").val( "" )
				}
				
				
				else if( text=="직속상관사번") {
					$(".sort").val( "e1.mgr_emp_no asc" )
				}
				else if( text=="직속상관사번▲") {
					$(".sort").val( "e1.mgr_emp_no desc" )
				}
				else if( text=="직속상관사번▼") {
					$(".sort").val( "" )
				}
				
				
				else if( text=="직속상관이름") {
					$(".sort").val( "e2.emp_name asc" )
				}
				else if( text=="직속상관이름▲") {
					$(".sort").val( "e2.emp_name desc" )
				}
				else if( text=="직속상관이름▼") {
					$(".sort").val( "" )
				}
				
				
				else if( text=="전화번호") {
					$(".sort").val( "e1.phone_num asc" )
				}
				else if( text=="전화번호▲") {
					$(".sort").val( "e1.phone_num desc" )
				}
				else if( text=="전화번호▼") {
					$(".sort").val( "" )
				}
				
				
				else if( text=="가입상태") {
					$(".sort").val( "a.allow_name asc" )
				}
				else if( text=="가입상태▲") {
					$(".sort").val( "a.allow_name desc" )
				}
				else if( text=="가입상태▼") {
					$(".sort").val( "" )
				}
				
				

				
				
		
				$(".empSearchBtn").click();
				
			}) //$(".sortHeader").click(function(){ 끝
			
		
			//----------------------------------------------
			// 검색화면 흔적남기기
			//----------------------------------------------
			empSearchForm.find(".keyword").val("${param.keyword}");
			
			empSearchForm.find(".depSearch").val("${param.depSearch}");
			
			empSearchForm.find(".jikupSearch").val("${param.jikupSearch}");
			
			//------------------------------------
			// "rowCntPerPage" 라는 파라미터명의 파라미터값이 비어 있지 않으면 
			//------------------------------------
			<c:if test="${!empty param.rowCntPerPage}">
				//---------------
				// class=rowCntPerPage 를 가진 태그 입력양식에
				// "rowCntPerPage" 라는 파라미터명의 파라미터값을 넣어주기
				//---------------
				empSearchForm.find(".rowCntPerPage").val("${param.rowCntPerPage}");
			</c:if>
			//------------------------------------
			// "selectPageNo" 라는 파라미터명의 파라미터값이 비어 있지 않으면 
			//------------------------------------
			<c:if test="${!empty requestScope.selectPageNo}">
				//---------------
				// class=selectPageNo 를 가진 태그 입력양식에
				// "selectPageNo" 라는 파라미터명의 파라미터값을 넣어주기
				//---------------
				empSearchForm.find(".selectPageNo").val("${requestScope.selectPageNo}");
			</c:if>
			
			//==================================
			// 사원리스트 <th>눌렀을 때 정렬 관련!
			// 만약 sort 라는 파라미터명에 파라미터값이 존재하면,
			// "/empList.do" 로 접속하면 들고온 sort 라는 파라미터명에 파라미터값이 존재하면,
			//==================================
			
			<c:if test="${!empty param.sort}">
				// class=sort 를 가진 hidden 태그의 value 값을 sort 라는 파라미터명에 파라미터값을 넣어주기
				empSearchForm.find(".sort").val("${param.sort}");
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
					if( "${param.sort}"=="e1.emp_no asc" && text=="사번") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▲"  삽입하라
						thisObj.append("▲")
					}
					// sort 라는 파라미터명에 파라미터값이 "reg_date desc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="e1.emp_no desc" && text=="사번") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▼"  삽입하라
						thisObj.append("▼")
					}
					
					
					// sort 라는 파라미터명에 파라미터값이 "reg_date asc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="e1.emp_name asc" && text=="이름") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▲"  삽입하라
						thisObj.append("▲")
					}
					// sort 라는 파라미터명에 파라미터값이 "reg_date desc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="e1.emp_name desc" && text=="이름") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▼"  삽입하라
						thisObj.append("▼")
					}
					
					
					// sort 라는 파라미터명에 파라미터값이 "reg_date asc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="e1.jikup_code asc" && text=="직급") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▲"  삽입하라
						thisObj.append("▲")
					}
					// sort 라는 파라미터명에 파라미터값이 "reg_date desc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="e1.jikup_code desc" && text=="직급") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▼"  삽입하라
						thisObj.append("▼")
					}
					
					
					// sort 라는 파라미터명에 파라미터값이 "reg_date asc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="d.dep_name asc" && text=="부서") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▲"  삽입하라
						thisObj.append("▲")
					}
					// sort 라는 파라미터명에 파라미터값이 "reg_date desc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="d.dep_name desc" && text=="부서") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▼"  삽입하라
						thisObj.append("▼")
					}
					
					
					// sort 라는 파라미터명에 파라미터값이 "reg_date asc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="e1.mgr_emp_no asc" && text=="직속상관사번") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▲"  삽입하라
						thisObj.append("▲")
					}
					// sort 라는 파라미터명에 파라미터값이 "reg_date desc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="e1.mgr_emp_no desc" && text=="직속상관사번") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▼"  삽입하라
						thisObj.append("▼")
					}
					
					
					// sort 라는 파라미터명에 파라미터값이 "reg_date asc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="e2.emp_name asc" && text=="직속상관이름") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▲"  삽입하라
						thisObj.append("▲")
					}
					// sort 라는 파라미터명에 파라미터값이 "reg_date desc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="e2.emp_name desc" && text=="직속상관이름") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▼"  삽입하라
						thisObj.append("▼")
					}
					
					
					// sort 라는 파라미터명에 파라미터값이 "reg_date asc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="e1.phone_num asc" && text=="전화번호") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▲"  삽입하라
						thisObj.append("▲")
					}
					// sort 라는 파라미터명에 파라미터값이 "reg_date desc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="e1.phone_num desc" && text=="전화번호") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▼"  삽입하라
						thisObj.append("▼")
					}
					
					
					// sort 라는 파라미터명에 파라미터값이 "reg_date asc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="a.allow_name asc" && text=="가입상태") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▲"  삽입하라
						thisObj.append("▲")
					}
					// sort 라는 파라미터명에 파라미터값이 "reg_date desc" 이고 i 번째 태그가 안고 있는 문자가 "등록일" 라면
					else if( "${param.sort}"=="a.allow_name desc" && text=="가입상태") {
						// i 번째 태그가 안고 있는 문자 뒤에 "▼"  삽입하라
						thisObj.append("▼")
					}
					 
					
					
				})
			</c:if>
			
		}) // $(function(){ 끝
		
		function searchForm_to_regfom(){
			//alert( empSearchForm.find(".keyword").val()	)
		
			//clone( empDetailForm.find(".selectPageNo"), empSearchForm.find(".selectPageNo") )
			
			empRegForm.find(".selectPageNo").val(
					empSearchForm.find(".selectPageNo").val()	
			);
			empRegForm.find(".rowCntPerPage").val(
					empSearchForm.find(".rowCntPerPage").val()	
			);
			empRegForm.find(".keyword").val(
					empSearchForm.find(".keyword").val()	
			);
			empRegForm.find(".keyword").val(
					empSearchForm.find(".keyword").val()	
			);
			empRegForm.find(".depSearch").val(
					empSearchForm.find(".depSearch").val()	
			);
			empRegForm.find(".jikupSearch").val(
					empSearchForm.find(".jikupSearch").val()	
			);

		}
			
		//----------------------------------------------
		// 직원 <tr> 누르면 직원번호 가져가기
		//----------------------------------------------
		function goEmpDetailForm(emp_no){
			//alert(emp_no)
			
			document.empDetailForm.action = "/empDetailForm.do";
			document.empDetailForm.method = "post";
			//-----------------------------------------
			empDetailForm.find(".selectPageNo").val(
					empSearchForm.find(".selectPageNo").val()	
			);
			empDetailForm.find(".rowCntPerPage").val(
					empSearchForm.find(".rowCntPerPage").val()	
			);
			empDetailForm.find(".keyword").val(
					empSearchForm.find(".keyword").val()	
			);
			empDetailForm.find(".depSearch").val(
					empSearchForm.find(".depSearch").val()	
			);
			empDetailForm.find(".jikupSearch").val(
					empSearchForm.find(".jikupSearch").val()	
			);
			//-----------------------------------------
			
			//location.replace("/empDetailForm.do?b_no="+emp_no)
			$("[name=empDetailForm]  [name=emp_no]").val(emp_no);
			
			// name=empDetailForm  를 가진 form 태그의 action 값에 해당한 URL 주소로 웹서버 접속하기
			document.empDetailForm.submit();
		} //function empDetailForm(emp_no){ 끝
		
		//----------------------------------------------
		// 검색 누르기
		//----------------------------------------------
		function empSearch( ){
			//alert("검색버튼")
			//return;
			
			//--------------------------------------
			// "/empList.do" 로 접속해 name=empSearch 안에 있는 입력양식 폼태그들을 가져가 action에 있는 웹서버로 접근한다.
			// 웹서버에 URL주소로 접근
			// 입력한 키워드 가져와서 변수 keyword에 저장하기
			//--------------------------------------
			var keyword = $(".keyword").val();
			// keyword1변수 안에 문자가 아닌 데이터가 있으면 길이가 없는 문자로 대체하기
			if(  typeof(keyword)!="string"  ){ keyword=""; }
			
			// 아래 코드는 keyword1 = keyword1.trim();로도 대체가 가능하다.
			// 단, 익스플로러9 이하 버전에선 안 된다.
			// keyword1 변수 안 문자에 앞뒤 공백 제거하기
			keyword = $.trim(keyword);	
			// 웹 화면의 키워드 입력란에 앞뒤 공백 제거한 문자 삽입하기
			$(".keyword").val(keyword);
			
			//--------------------------------------
			
			var depSearch = $(".depSearch").val();
			if(  typeof(depSearch)!="string"  ){ depSearch=""; }
			depSearch = $.trim(depSearch);	
			$(".depSearch").val(depSearch);
			//alert(  keyword  );
			//return; 
			//alert(  depSearch  );
			//return;
			
			//--------------------------------------
			
			var jikupSearch = $(".jikupSearch").val();
			if(  typeof(jikupSearch)!="string"  ){ jikupSearch=""; }
			jikupSearch = $.trim(jikupSearch);	
			$(".jikupSearch").val(jikupSearch);
			
			//--------------------------------------
			
			document.empSearchForm.submit();
		}

		//----------------------------------------------
		// 모두 검색 누르기
		//----------------------------------------------
		function empSearchAll( ){

			//alert("모두검색버튼")
			//return;
			$(".keyword").val("");
			$(".depSearch").val("");
			$(".jikupSearch").val("");
			
			
			
			// 검색버튼누르기 = searchForm으로 가기
			$(".empSearchBtn").click();

		}
		
		//************************************************
		// 새글쓰기 버튼 누르면 호출되는 함수 선언.
		//************************************************
		function goEmpRegForm( ){
			
			//alert("들어왔니?" ); return;
			
			
			searchForm_to_regfom();
			// name=empRegForm  를 가진 form 태그의 action 값 설정하기
			document.empRegForm.action="/empRegForm.do";
			// name=empRegForm  를 가진 form 태그의 method 값 설정하기
			document.empRegForm.method="post";
			// name=empRegForm  를 가진 form 태그의 action 값에 해당한 URL 주소로 웹서버 접속하기
			document.empRegForm.submit();
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
			// empSearch 함수 호출하기
			//------------------------------------
			empSearch();
		}
		
			
		/*
		//----------------------------------------------
		// 직원 <tr> 누르면 리스트번호 가져가기
		//----------------------------------------------
		function goEmpDetailForm(emp_no){
			//alert(emp_no)

			//location.replace("/boardDetailForm.do?b_no="+b_no)
			$("[name=empDetailForm]  [name=emp_no]").val(emp_no);
			
			// name=empDetailForm  를 가진 form 태그의 action 값에 해당한 URL 주소로 웹서버 접속하기
			document.empDetailForm.submit();
		} //function goBoardDetailForm(b_no){ 끝
		*/	
			
			
			
			
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
									<strong>관리자 페이지</strong>	
									<span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>
								</header>

							<!-- Content -->
								<section>
									<header class="main">
										<h2></h2>
									</header>
                                    <h3>가입관리</h3>
								<!-- <form name="" method="post" action="">
								 -->
                                        <!--**********************************************************-->
										<!-- [직원 검색 조건 입력 양식] 내포한 form 태그 선언 -->
										<!--********************************************************** -->
										<form name="empSearchForm" method="post" action="/empList.do">
                                       
										
                                       
                  
                                       
                                       
                                        <input type="text" name="keyword" class="keyword"  width="100px" height="300px" value="${param.keyword}"> 
                                        <select name="depSearch" class="depSearch">
                                            <option value="">소속부서</option>
                                            <option value="10">행정</option>
                                            <option value="20">사무</option>
                                            <option value="30">구매</option>
                                            <option value="40">접대</option>
                                            <option value="50">회계</option>
                                            <option value="60">기타</option>
                                        </select>
                                        
                                        <select name="jikupSearch" class="jikupSearch">
                                            <option value="">직급</option>
                                            <option value="1">사장</option>
                                            <option value="2">부장</option>
                                            <option value="3">차장</option>
                                            <option value="4">과장</option>
                                            <option value="5">대리</option>
                                            <option value="6">사원</option>
                                        </select>
                                            
                                        <input type="button" value="검색" class="empSearchBtn" onClick="empSearch( );">
                                        <input type="button" value="모두검색" class="empSearchAllBtn" onClick="empSearchAll( );"> 
                                        <input type="button" name="newEmpBtn" class="newEmpBtn" value="등록" > 
                                        [검색 총개수] :  ${requestScope.empTotCnt}개 &nbsp; &nbsp; &nbsp;
                                        <select name="rowCntPerPage" class="rowCntPerPage" onChange="empSearch();">
                                            <option value="10">10
                                            <option value="15">15
                                            <option value="20">20
                                            <option value="30">30
                                        </select> 행보기
                                        
                                        <input type="hidden" name="sort" class="sort">
                                   		<!------------------------------------------------->
										<!--- 클릭한 페이지번호를 저장할 hidden 입력양식 선언.페이징 처리 관련 데이터이다.--->
										<!------------------------------------------------->
										<input type="hidden" name="selectPageNo" class="selectPageNo" value="1"> 
										
										<!------------------------------------------------->
										<!--- 한 화면에 보여지는 페이지 번호의 개수를 저장할 hidden 태그 선언.--->
										<!------------------------------------------------->
										<input type="hidden" name="pageNoCntPerPage" class="pageNoCntPerPage" value="10">
                                    </center>
                                    <br><br>
                                   									
                                  	<div class="searchingResults">
                                     </form>
                                    <!--**********************************************************-->
									<!-- empSearchForm 태그 끝 -->
									<!--********************************************************** -->    
                                        
                                        
                                        <!--==<form name="empList">=========================================================-->
										
										<!--===========================================================-->
                                        <table border=1 cellpadding="5" cellspacing="1" >
                                            <tr>
                                                <th class="sortHeader">번호
                                                <th class="sortHeader">사번
                                                <th class="sortHeader">이름
                                                <th class="sortHeader">직급
                                                <th class="sortHeader">부서
                                                <th class="sortHeader">직속상관사번
                                                <th class="sortHeader">직속상관이름
                                                <th class="sortHeader">전화번호
                                                <th class="sortHeader">가입상태
                                            </th>
                                            <!-- <tr>
                                                <td>1</td>
                                                <td>1004</td>
                                                <td>강아지</td>
                                                <td>사원</td>
                                                <td>사업부</td>
                                                <td>1003</td>
                                                <td>개</td>
                                                <td>01012345678</td>
                                                <td>가입대기</td>
                                            </tr -->
                                            	<div class="RNUMsort">
                                             <c:forEach var="employee2" items="${requestScope.empList}" varStatus="loopTagStatus">
													<tr
													
													onClick="goEmpDetailForm(${employee2.emp_no})"
													style="cursor:pointer">
														<td>${requestScope.pagingMap.serialNo_desc - loopTagStatus.index}
														
														<td>${employee2.emp_no}
														<td>${employee2.emp_name}
														<td>${employee2.jikup_name}
														<td>${employee2.dep_name}
														<td>${employee2.mgr_emp_no}
														<td>${employee2.emp_name2}
														<td>${employee2.phone_num}
														<td>${employee2.allow_name}
										   </c:forEach>
										   </div>
										   
                                        </table>
                                        
                                    </div>
                                    <center>
                                        <!----------------------------------------------------------->
										<!-- 검색된 게시판의 개수가 0개 보다 크면, 즉 검색된 게시판이 존재하면--->
										<!----------------------------------------------------------->
										<c:if test="${requestScope.empTotCnt>0}">
												
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
                              		
                             <!-- <center>
                                   
                                        <span>[1]</span>
                                        <span>[2]</span>
                                        <span>[3]</span>
                                    </center> -->
                                    <!-- <div style="float:left" ><input type="button" name="empListBtn" class="empListBtn" value="직원관리 페이지 이동"> </div> -->
                                    
									
									
								</section>
									<!--======</form>=====================================================-->
	
									<!--===========================================================-->
									 <!-- 직원관리 눌렀을 때 직원목록 검색화면 나오게 하는 form  -->
									
									<form name="empListForm" class="empListForm" method="post" action="/empList.do"> 
										<%@include file="/WEB-INF/views/moveData_emp.jsp" %>
									</form>
									
									
									<form name="empDetailForm" class="empDetailForm" method="post" action="/empDetailForm.do">  
										<input type="hidden" name="emp_no" class="emp_no">
										<input type="hidden" name="emp_pwd_confirm" class="emp_pwd_confirm" value="${requestScope.employeeDTO.emp_pwd_confirm}">
										<%@include file="/WEB-INF/views/moveData_emp.jsp" %>
									</form>
									
									
									<form name="empUpDelForm">
										<input type="hidden" name="emp_pwd_confirm" class="emp_pwd_confirm" value="${requestScope.employeeDTO.emp_pwd_confirm}">
									</form>
									
									<form name="empRegForm" class="empRegForm" method="post" action="/empRegForm.do"> 
										<%@include file="/WEB-INF/views/moveData_emp.jsp" %>
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