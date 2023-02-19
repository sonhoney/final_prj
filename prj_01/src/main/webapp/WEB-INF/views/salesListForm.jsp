<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html>
<html>
	<head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
        <script src="/ckeditor/ckeditor.js"></script>
        <script src="/ckeditor/ko.js"></script>
        <title>영업보고서 화면</title>	
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
			
				$(".expenseListForm").click(function(){
					location.replace("/expenseListForm.do");
				})
				$(".dailyListForm").click(function(){
					location.replace("/dailyListForm.do");
				})
				$(".dashboard").click(function(){
					location.replace("/dashboard.do");
				})
				$(".salesListForm").click(function(){
					location.replace("/salesListForm.do");
				})
				$(".salesRegForm").click(function(){
					location.replace("/salesRegForm.do");
				})
				
				
				
				// 검색 조건 관련 입력양식에 흔적 남기기
				
				var formObj = $("[name='salesSearchForm']");
				
				
				// 결재날짜 흔적남기기
				<c:if test="${!empty param.sign_min_year}">
					formObj.find(".sign_min_year").val("${param.sign_min_year}");
				</c:if>
				
				<c:if test="${!empty param.sign_min_month}">
					formObj.find(".sign_min_month").val("${param.sign_min_month}");
				</c:if>
				
				<c:if test="${!empty param.sign_max_year}">
					formObj.find(".sign_max_year").val("${param.sign_max_year}");
				</c:if>

				<c:if test="${!empty param.sign_max_month}">
					formObj.find(".sign_max_month").val("${param.sign_max_month}");
				</c:if>
				
				// 업무날짜 흔적남기기  
				<c:if test="${!empty param.min_year}">
					formObj.find(".min_year").val("${param.min_year}");
				</c:if>
				
				<c:if test="${!empty param.min_month}">
					formObj.find(".min_month").val("${param.min_month}");
				</c:if>
				
				<c:if test="${!empty param.max_year}">
					formObj.find(".max_year").val("${param.max_year}");
				</c:if>

				<c:if test="${!empty param.max_month}">
					formObj.find(".max_month").val("${param.max_month}");
				</c:if>
				
				//키워드
				formObj.find(".keyword").val("${param.keyword}");
				

				//결재여부
				<c:forEach var="sign_code" items="${paramValues.sign_code}">
					formObj.find(".sign_code").filter("[value='${sign_code}']").prop("checked",true);
				</c:forEach>
				
				
				//방문목적
				<c:forEach var="sales_type" items="${paramValues.sales_type}">
					formObj.find(".sales_type").filter("[value='${sales_type}']").prop("checked",true);
				</c:forEach>
				
				
				// "rowCntPerPage" 라는  파라미터명의 파라미터값이 비어있지 않으면
				<c:if test="${!empty param.rowCntPerPage}">
					formObj.find(".rowCntPerPage").val("${param.rowCntPerPage}");
				</c:if>
					
				// "selectPageNo" 라는  파라미터명의 파라미터값이 비어있지 않으면
				<c:if test="${!empty param.selectPageNo}">
					formObj.find(".selectPageNo").val("${param.selectPageNo}");
				</c:if> 
				
				
				
				
				
			})
			
			
			
			//--------------------------------------------------------------------------------------------------------------------------------------------------
			//--------------------------------------------------------------------------------------------------------------------------------------------------
			//--------------------------------------------------------------------------------------------------------------------------------------------------
			//----------------------------------------------함수선언------------------------------------------------------------------------------------------
			//--------------------------------------------------------------------------------------------------------------------------------------------------
			//--------------------------------------------------------------------------------------------------------------------------------------------------
			//--------------------------------------------------------------------------------------------------------------------------------------------------
			
			// [검색 버튼] 클릭했을때 호출되는 함수 선언
			function salesSearch(){
				
				/* 
				// 시간 조합해서  min_hour_minute , max_hour_minute 에 넣어주기        
				var min_hour = $(".min_hour").val(); 
				var min_minute = $(".min_minute").val();
				var max_hour = $(".max_hour").val();
				var max_minute = $(".max_minute").val();

				if( min_hour!="" && min_minute!=""){
					$(".min_hour_minute").val( min_hour+""+min_minute);
				}

				if( max_hour!="" && max_minute!=""){
					$(".max_hour_minute").val( max_hour+""+max_minute );      
				} */

				
				// 결재(영업시간) 날짜 조합해서  sign_min_year_month , sign_max_year_month 에 넣어주기  
				var sign_min_year = $(".sign_min_year").val();
				var sign_min_month = $(".sign_min_month").val();
				var sign_max_year = $(".sign_max_year").val();
				var sign_max_month = $(".sign_max_month").val();


				if( sign_min_year!="" && sign_min_month!=""){
					$(".sign_min_year_month").val( sign_min_year+""+sign_min_month);
				}	

				if( sign_max_year!="" && sign_max_month!=""){
					$(".sign_max_year_month").val( sign_max_year+""+sign_max_month);
				}



				//  영업 날짜 조합해서  min_year_month , max_year_month 에 넣어주기  
				var min_year = $(".min_year").val();
				var min_month = $(".min_month").val();
				var max_year = $(".max_year").val();
				var max_month = $(".max_month").val();

				if( min_year!="" && min_month!=""){
					$(".min_year_month").val( min_year +"-"+ min_month + "-01");
				}

				if( max_year!="" && max_month!=""){
					$(".max_year_month").val( 
										 	max_year +"-"+ max_month +"-"+ new Date( parseInt(max_year,10) ,parseInt(max_month,10) ,0 ).getDate()  
										);
				}
				
				
				
				// 키워드 
				var keyword = $(".keyword").val();
				if(typeof(keyword)!="string"){ keyword = "";}
				keyword = $.trim(keyword); 
				$(".keyword").val(keyword);

				document.salesSearchForm.submit();
				
			}
			
			

			// [모두검색] 버튼 클릭했을때 호출되는 함수 선언
			function salesSearchAll(){

				$(".keyword").val("");

				$(".sign_min_year").val("");
				$(".sign_min_month").val("");
				$(".sign_max_year").val("");
				$(".sign_max_month").val("");
				
				$(".min_year").val("");
				$(".min_month").val("");
				$(".max_year").val("");
				$(".max_month").val("");


				
				$(".sales_type").prop("checked",false);
				$(".sign_code").prop("checked",false);
				
				$(".salesSearchBtn").click();
			}
			
			//-------------------------------------------------------
			// 결재(영업 시간으로 변경) 날짜 범위 관련 select 태그 4개의 유효성 체크하기
			function sign_checkYMRange(){
				var formObj = $("[name='salesSearchForm']");
				//---------------------------------------------
				var sign_min_yearObj = formObj.find(".sign_min_year");
				var sign_min_monthObj = formObj.find(".sign_min_month");
				var sign_max_yearObj = formObj.find(".sign_max_year");
				var sign_max_monthObj = formObj.find(".sign_max_month");
				//---------------------------------------------
				var sign_min_yearVal = sign_min_yearObj.val();
				var sign_min_monthVal = sign_min_monthObj.val();
				var sign_max_yearVal = sign_max_yearObj.val();
				var sign_max_monthVal = sign_max_monthObj.val();
				//---------------------------------------------
				if( sign_min_yearVal=="" && sign_min_monthVal!="" ){
					alert("시간을 먼저 선택해주세요");
					sign_min_monthObj.val("");
					return;
				}
				
				if( sign_max_yearVal=="" && sign_max_monthVal!="" ){
					alert("시간을 먼저 선택해주세요.");
					sign_max_monthObj.val("");
					return;
				}
				//---------------------------------------------
				if( sign_min_yearVal!="" && sign_min_monthVal!="" &&  sign_max_yearVal!="" && sign_max_monthVal!=""){
					if( sign_min_yearVal+sign_min_monthVal > sign_max_yearVal+sign_max_monthVal ){
						alert("최소 시간이 최대 시간보다 크면 안됩니다!!");
						sign_max_yearObj.val("");
						sign_max_monthObj.val("");
						return;
					}
				}
			}
			//-------------------------------------------------------
			// 영업 날짜 범위 관련 select 태그 4개의 유효성 체크하기
			function checkYMRange(){
				var formObj = $("[name='salesSearchForm']");
				//---------------------------------------------
				var min_yearObj = formObj.find(".min_year");
				var min_monthObj = formObj.find(".min_month");
				var max_yearObj = formObj.find(".max_year");
				var max_monthObj = formObj.find(".max_month");
				//---------------------------------------------
				var min_yearVal = min_yearObj.val();
				var min_monthVal = min_monthObj.val();
				var max_yearVal = max_yearObj.val();
				var max_monthVal = max_monthObj.val();
				//---------------------------------------------
				if( min_yearVal=="" && min_monthVal!="" ){
					alert("년도가 없으면 월을 선택할 수 없습니다.");
					min_monthObj.val("");
					return;
				}
				
				if( max_yearVal=="" && max_monthVal!="" ){
					alert("년도가 없으면 월을 선택할 수 없습니다.");
					max_monthObj.val("");
					return;
				}
				//---------------------------------------------
				if( min_yearVal!="" && min_monthVal=="" ){
					min_monthObj.val("01");
					min_monthVal = "01";
				}
				if( max_yearVal!="" && max_monthVal=="" ){
					max_monthObj.val("12");
					max_monthVal = "12";
				}
				//---------------------------------------------
				if( min_yearVal!="" && min_monthVal!="" &&  max_yearVal!="" && max_monthVal!=""){
					if( min_yearVal+min_monthVal > max_yearVal+max_monthVal ){
						alert("최소 년월이 최대 년월 보다 크면 안됩니다!");
						max_yearObj.val("");
						max_monthObj.val("");
						return;
					}
				}
			}

			//----------------------------------------------------
			// 결재 날짜비움
			function sign_emptyYMRange(){
				var formObj = $("[name='salesSearchForm']");
				//---------------------------------------------
				formObj.find(".sign_min_year").val("");
				formObj.find(".sign_min_month").val("");
				formObj.find(".sign_max_year").val("");
				formObj.find(".sign_max_month").val("");
				//---------------------------------------------
			}
			//----------------------------------------------------
			// 영업 날짜비움
			function emptyYMRange(){
				var formObj = $("[name='salesSearchForm']");
				//---------------------------------------------
				formObj.find(".min_year").val("");
				formObj.find(".min_month").val("");
				formObj.find(".max_year").val("");
				formObj.find(".max_month").val("");
				//---------------------------------------------
			}
			//----------------------------------------------------
			
			// 결재 [오늘로] 클릭하면 실행되는 함수
			function sign_now(){
				
				var now = new Date();

				var now_hour = now.getHours();
					if(now_hour<10){now_hour= "0"+now_hour}
				var now_min = now.getMinutes();
					if(now_min<10){now_min= "0"+now_min}

				
				var formObj = $("[name='salesSearchForm']");

				var sign_min_yearObj = formObj.find(".sign_min_year");
				var sign_min_monthObj = formObj.find(".sign_min_month");
				var sign_max_yearObj = formObj.find(".sign_max_year");
				var sign_max_monthObj = formObj.find(".sign_max_month");

				sign_min_yearObj.val(now_hour);
				sign_min_monthObj.val(now_min);
				sign_max_yearObj.val(now_hour);
				sign_max_monthObj.val(now_min);
				
			}
			//----------------------------------------------------
			// 영업 [오늘로] 클릭하면 실행되는 함수
			function now(){
				
				var now = new Date();
				
				var now_year = now.getFullYear();
				var now_month = now.getMonth()+1;
				if(now_month<10){now_month= "0"+now_month}

				
				var formObj = $("[name='salesSearchForm']");

				var min_yearObj = formObj.find(".min_year");
				var min_monthObj = formObj.find(".min_month");
				var max_yearObj = formObj.find(".max_year");
				var max_monthObj = formObj.find(".max_month");

				min_yearObj.val(now_year);
				min_monthObj.val(now_month);
				max_yearObj.val(now_year);
				max_monthObj.val(now_month);
				
			}

			//----------------------------------------------------
			// 방문목적 비움
			function emptySales_type(){
				$(".sales_type").prop("checked",false);			
			}
			//----------------------------------------------------
			// 결재여부 비움
			function emptySign_code(){
				$(".sign_code").prop("checked",false);				
			}
			
			//----------------------------------------------------
			// 키워드 비움
			function emptyKeyword(){
				$(".keyword").val("");		
			}
			//----------------------------------------------------
			
			
			
			// [페이지 번호]를 클릭하면 호출되는 함수 선언
			function pageNoBtn(pageNo){
				// class=selectPageNo 를 가진 입력양식에
				// 클릭한(선택한) 페이지 번호를 value 값으로 삽입하기
				// 왜?? 서버로 보낼려고
				$(".selectPageNo").val(pageNo);
				// boardSearch함수 호출하기
				salesSearch();
			}
			
			
			
			
			function goBoardDetailForm(report_no,report_code){
				var formObj = $("[name=boardDetailForm] [name=report_no]");
				var formObj2 = $("[name=boardDetailForm] [name=report_code]");
				var report_no = parseInt(report_no,10);
				var report_code = parseInt(report_code,10);
				formObj.val(report_no);
				formObj2.val(report_code);
				document.boardDetailForm.submit();
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
									<strong>영업보고서</strong>	
									<span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>									
								</header>

							<!-- Content -->
							<form name="salesSearchForm" method="post" action="/salesListForm.do">
								
									<table border=1 cellpadding="5" cellspacing="1" >
										
										<tr>
											<th>영업일</th>
											<td>
												 <select name="min_year" class="min_year" onChange="checkYMRange()">     
                                                <option value="">--선택--
												<option value="2022">2022
												<option value="2021">2021
												<option value="2020">2020
												<option value="2019">2019
												<option value="2018">2018
                                            </select>년
                                            <select name="min_month" class="min_month" onChange="checkYMRange()">
                                                <option value="">--선택--
												<option value="01">01
												<option value="02">02
												<option value="03">03
												<option value="04">04
												<option value="05">05
												<option value="06">06
												<option value="07">07
												<option value="08">08
												<option value="09">09
												<option value="10">10
												<option value="11">11
												<option value="12">12
                                            </select>월
                                            -
                                            <select name="max_year" class="max_year" onChange="checkYMRange()">
                                                <option value="">--선택--
												<option value="2022">2022
												<option value="2021">2021
												<option value="2020">2020
												<option value="2019">2019
												<option value="2018">2018
                                            </select>년
                                            <select name="max_month" class="max_month" onChange="checkYMRange()">
                                                <option value="">--선택--
												<option value="01">01
												<option value="02">02
												<option value="03">03
												<option value="04">04
												<option value="05">05
												<option value="06">06
												<option value="07">07
												<option value="08">08
												<option value="09">09
												<option value="10">10
												<option value="11">11
												<option value="12">12
                                            </select>월

											<span style="cursor:pointer" onClick="emptyYMRange()">[날짜비움]</span>
											<span style="cursor:pointer" onClick="now()">[오늘날]</span>
											</td>
										</tr>
										<tr>
											 <th>영업시간</th>
											<td>
												<select name="sign_min_year" class="sign_min_year" onChange="sign_checkYMRange()">     
                                                 <option value="">-선택-
												<%for( int i=1; i<25; i++) {%>
													<%if(i<10){ %>
														<option value="0<%= i %>">0<%= i %>
													<% } %>
													<% if(i>=10){ %>
														<option value="<%= i %>"><%= i %>
													<% } %>
															
												<% } %>	
                                            </select>시
                                            <select name="sign_min_month" class="sign_min_month" onChange="sign_checkYMRange()">
                                                <option value="">-선택-
												<%for( int i=0; i<60; i++) {%>
													<%if(i<10){ %>
														<option value="0<%= i %>">0<%= i %>
													<% } %>
													<% if(i>=10){ %>
														<option value="<%= i %>"><%= i %>
													<% } %>
															
												<% } %>		
                                            </select>분
                                            -
                                            <select name="sign_max_year" class="sign_max_year" onChange="sign_checkYMRange()">
                                                <option value="">-선택-
												<%for( int i=1; i<25; i++) {%>
													<%if(i<10){ %>
														<option value="0<%= i %>">0<%= i %>
													<% } %>
													<% if(i>=10){ %>
														<option value="<%= i %>"><%= i %>
													<% } %>
															
												<% } %>	
                                            </select>시
                                            <select name="sign_max_month" class="sign_max_month" onChange="sign_checkYMRange()">
                                                <option value="">-선택-
												<%for( int i=0; i<60; i++) {%>
													<%if(i<10){ %>
														<option value="0<%= i %>">0<%= i %>
													<% } %>
													<% if(i>=10){ %>
														<option value="<%= i %>"><%= i %>
													<% } %>
															
												<% } %>		
                                            </select>분
											<span style="cursor:pointer" onClick="sign_emptyYMRange()">[시간비움]</span>
											<span style="cursor:pointer" onClick="sign_now()">[오늘날]</span>
											</td>
										</tr>
											<input type="hidden" name="sign_min_year_month" class="sign_min_year_month"> 
											<input type="hidden" name="sign_max_year_month" class="sign_max_year_month">
											<input type="hidden" name="min_year_month" class="min_year_month"> 
											<input type="hidden" name="max_year_month" class="max_year_month">
										<tr>
											<th>결재여부</th>
											<td>
	                                            <input type="checkbox" name="sign_code" class="sign_code" value="0">결재완료
	                                            <input type="checkbox" name="sign_code" class="sign_code" value="-1">미결재(or 결재진행중)
	                                            <input type="checkbox" name="sign_code" class="sign_code" value="1">반려
												<span style="cursor:pointer" onClick="emptySign_code()">[비움]</span>
											</td>
										</tr>
										<tr>
											<th>방문목적</th>
											<td>
												<input type="checkbox" name="sales_type"  class="sales_type" value="10">영업자관리
												<input type="checkbox" name="sales_type"  class="sales_type" value="20">수급
												<input type="checkbox" name="sales_type"  class="sales_type" value="30">회의
												<input type="checkbox" name="sales_type"  class="sales_type" value="40">거래처확보
												<input type="checkbox" name="sales_type"  class="sales_type" value="50">기타
												<span style="cursor:pointer" onClick="emptySales_type()">[비움]</span>
											</td>
										</tr>
										<tr>
											<th>키워드</th>
											<td>
	                                            <input type="text" name="keyword" class="keyword" size="10" value="">
												<span style="cursor:pointer" onClick="emptyKeyword()">[비움]</span>
											</td>
										</tr>
										
									</table><br>
									<center>
                                    	<input type="button" value="검색" class="salesSearchBtn" onClick="salesSearch();">
                                    	<input type="button" value="모두검색" class="salesSerchAllBtn" onClick="salesSearchAll();" >
										<input type="reset" value="초기화">
									</center>
									<br><br>
								  <table border=1 cellpadding="5" cellspacing="1" >
                                        <tr>
                                            <td>
                                                <input type="button" value="업무보고서 등록" class="salesRegForm"> 
                                            <td align="right">
												<!-- 검색된 게시판의 개수가 0개 보다 크면, 즉 검색된 게시판이 존재하면 -->
												<c:if test="${ requestScope.salesTotCnt>0 }">
													
													
													<!-- [처음] 문자 출력 -->
													<span style="cursor:pointer" onclick="pageNoBtn(1);">[처음]</span>&nbsp;
													<!-- [이전] 문자 출력 -->
													<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo}-1);">[이전]</span>&nbsp;&nbsp;
													
													<!-- 선택한 페이지 대응하는 페이지 번호들을 출력 -->
													<c:forEach var="no" begin="${requestScope.pagingMap.begin_pageNo_perPage}" 
																		end="${requestScope.pagingMap.end_pageNo_perPage}" step="1">
														
														<!-- 만약에 선택한 페이지 번호와 출력되는 페이지번호가 다르면 -->
														<c:if test="${requestScope.pagingMap.selectPageNo !=no}">
															<span style="cursor:pointer" onclick="pageNoBtn(${no});">[${no}]</span>&nbsp;&nbsp;&nbsp;
														</c:if>
														
														
														<!-- 만약에 선택한 페이지 번호와 출력되는 페이지번호가 같으면 -->
														<c:if test="${requestScope.pagingMap.selectPageNo ==no}">
															<span>${no}</span>&nbsp;&nbsp;
														</c:if>
														
														
													</c:forEach>
												
													<!-- [다음] 문자 출력 -->
													<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo}+1);">[다음]</span>&nbsp;
													<!-- [마지막] 문자 출력 -->
													<span style="cursor:pointer" onclick="pageNoBtn(${requestScope.pagingMap.last_pageNo});">[마지막]</span>
												
												</c:if>	
												
											<td align="right">
												[검색 총개수] : ${requestScope.salesTotCnt}/${requestScope.salesAllTotCnt} &nbsp;&nbsp;&nbsp;&nbsp;
											
	                                               <select name="rowCntPerPage" class="rowCntPerPage" onChange="salesSearch()">
													<option value="10">10
													<option value="15">15
													<option value="20">20
													<option value="30">30
	                                               </select>행보기                                              	
	                                           </td>
                                        </tr>
                                    </table>
									<table>
										<tr>
											<td align="center"><b>번호</td>
											<td align="center"><b>작성자</td>
											<td align="center"><b>영업제목</td>
											<td align="center"><b>방문목적</td>
											<td align="center"><b>결재여부</td>
											<td align="center"><b>결재/반려일</td>
											<td align="center"><b>영업일</td>
										</tr>
										<c:forEach var="xxx" items="${requestScope.salesList}" varStatus="loopTagStatus">
													<tr 
														bgcolor="${loopTagStatus.index%2==0?'white':'lightgray'}"
														style="cursor:pointer"
														onClick="goBoardDetailForm(${xxx.report_no},${xxx.report_code})"
														class="trline"
													>
														<td align="center">${requestScope.pagingMap.serialNo_desc - loopTagStatus.index}
														<td align="center">${xxx.emp_name}					
														<td align="center">${xxx.report_name}
														<td align="center">${xxx.sales_type_name}
														<td align="center"><c:if test="${xxx.sign_code==-1 && xxx.emp_no==sessionScope.uid}"><span style="color:#66CDAA">결재 진행중</span></c:if>										
															<c:if test="${xxx.sign_code==1}"><span style="color:#DC143C">반려</span></c:if><c:if test="${xxx.sign_code==1 && xxx.emp_no==sessionScope.uid}"><span style="color:#DC143C">처리요망</span></c:if>													
															<c:if test="${xxx.sign_code==-1 && xxx.emp_no!=sessionScope.uid}"><span style="color:#FFD700">미결재</span></c:if>		
															<c:if test="${xxx.sign_code==0}"><span style="color:#6B8E23">
															결재<c:if test="${xxx.emp_no==sessionScope.uid||xxx.sign_code==xxx.last_sign_code}">최종</c:if>완료</span>
															</c:if>			
														<td align="center">${xxx.next_app_getSign_date}
															<c:if test="${xxx.last_emp_no==sessionScope.uid && xxx.sign_code!=-1}">${xxx.last_sign_date}</c:if>
															<c:if test="${(xxx.last_emp_no==sessionScope.uid && xxx.last_sign_date==null) || (xxx.last_sign_date==null && xxx.sign_code==1)}">
															<span style="color:#DC143C">반려 처리중</span></c:if>
														<td align="center">${xxx.sales_date_start}<br> ~ ${xxx.sales_date_end}
													</tr>
										</c:forEach>
									</table>	
									
						</div>
					</div>
				<input type="hidden" name="selectPageNo" class="selectPageNo" value="1"> 
				<input type="hidden" name="pageNoCntPerPage" class="pageNoCntPerPage" value="10">
		</form>
		
		
		 <form name="boardDetailForm" method="post" action="/SalesDetailForm.do">
			<input type="hidden" name="report_no"> 	
			<input type="hidden" name="report_code"> 									 	
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