

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ page import="com.naver.erp.Next_App_Emp_List" %>    
<%@ page import="java.util.*" %>    


<%ArrayList<Next_App_Emp_List> next_app_list = (ArrayList<Next_App_Emp_List>)request.getAttribute("next_app_list"); %>



<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
		<script src="/ckeditor/ckeditor.js"></script>
		<script src="/ckeditor/ko.js"></script>
		<title>일일업무보고서 등록</title>	
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
				$(".salesListForm").click(function(){
					location.replace("/salesListForm.do");
				})
				$(".dailyListForm").click(function(){
					location.replace("/dailyListForm.do");
				})
				$(".dashboard").click(function(){
					location.replace("/dashboard.do");
				})
				$(".dailybusinessRegForm").click(function(){
					location.replace("/dailybusinessRegForm.do");
				})
				$(".RegFormBtn").click(function(){
					dailyBusiRegFormCheck();
				})
				
				
				
  
				
				
			})
			
			
			//--------------------------------------------------------------------------------함수 시작--------------------------------------------------------------
			function dailyBusiRegFormCheck(){
				
				var formObj = $("[name=dailyBusiReg]");
				
				var startDateObj = formObj.find("[name=busi_start_date]"); // 시작날짜
				var endDateObj = formObj.find("[name=busi_end_date]"); // 끝날짜
				var emp_no = formObj.find("[name=emp_no]");		// 세셔에서 가져온 로그인한 사원번호
				var busiType = formObj.find("[name=busi_type_code]"); // 업무분야 코드 
				var busi_content = formObj.find("[name=busi_content]"); // 업무내용 
				var next_app_emp_no = formObj.find("[name=next_app_emp_no]"); // 다음 결재자
				
				
				//-------------------------------------------------------------
				// 업무분야 유효성 검사
				var busiTypeVal = busiType.val();
				if( busiTypeVal == "" ){
					alert("업문분야를 선택해야 합니다.");
					busiType.focus();
					return;
				}
				//-------------------------------------------------------------
				// 업무내용 유효성 검사
				var busi_contentVal = busi_content.val();
				if( typeof(busi_contentVal)!="string" ){busi_contentVal="";}
				busi_contentVal = busi_contentVal.trim();
				busi_content.val(busi_contentVal);
				
				if( busi_contentVal.length==0 ){
					alert("내용을 입력해야 합니다.");
					busi_content.val("");
					busi_content.focus();
					return;
				}
				//-------------------------------------------------------------
				// 날짜 유효성 검사
				var formObj = $("[name='dailyBusiReg']");
				//-------------------------------------------------------------
				var min_yearVal = formObj.find(".min_year").val();
				var min_monthVal = formObj.find(".min_month").val();
				var min_dateVal = formObj.find(".min_date").val();
				var min_hourVal = formObj.find(".min_hour").val();				
				var min_minuteVal = formObj.find(".min_minute").val();				
				//-----------------------------------------------------
				var max_yearVal = formObj.find(".max_year").val();
				var max_monthVal = formObj.find(".max_month").val();
				var max_dateVal = formObj.find(".max_date").val();
				var max_hourVal = formObj.find(".max_hour").val();				
				var max_minuteVal = formObj.find(".max_minute").val();	
				//-----------------------------------------------------
				if( min_yearVal=="" || min_monthVal=="" || min_dateVal=="" || min_hourVal=="" || min_minuteVal=="" ||
						max_yearVal=="" || max_monthVal=="" || max_dateVal=="" || max_hourVal=="" || max_minuteVal=="" ){
					alert("업무시간을 모두 작성해주십시오.");
					return;
				}
			
				
				
				
				
				
				
			    
				//-------------------------------------------------------------
				//??????????????????????????????????????
				var reportType 
				busiType.val(parseInt(busiType.val(),10));
				//??????????????????????????????????????
				
				//-----------------------------------------------------
				// 선택된 날짜들 하나로 병합
				if( min_yearVal!="" && min_monthVal!="" ){
					startDateObj.val( min_yearVal + "-" + min_monthVal + "-"  + min_dateVal + "-" + min_hourVal + "-" + min_minuteVal);
				}
				if( max_yearVal!="" && max_monthVal!="" ){
					endDateObj.val( max_yearVal + "-" + max_monthVal + "-" + max_dateVal+ "-" + max_hourVal+ "-" + max_minuteVal);
				}
				//-----------------------------------------------------


				//-------------------------------------------------------------
				// 결재자 유효성 검사
				var next_app_emp_noVal = next_app_emp_no.val();
				if( next_app_emp_noVal == "" ){
					alert("다음결재자를 선택해야 합니다.");
					next_app_emp_no.focus();
					return;
				}
				//-------------------------------------------------------------
				
				
				
				
				
				
				
				$.ajax({
					url:"/dailyBusiRegProc.do"	
					,type:"post"
					,data:$("[name='dailyBusiReg']").serialize()
					,success:function(regCnt){
						if(regCnt==1){
							alert("업무일지 등록 성공");
							location.replace("/dailyListForm.do")
						}
					}
					,error:function(){
						alert("웹서버 접속 실패! 관리자에게 문의 바람");
					}
				})
				
				
			}

			//-------------------------------------------------------------
			// 유효한 날짜 세팅 함수
			 function setYMD( formName,yearName,monthName,dateName){
	                try{
	                    var formObj = $("[name='"+formName+"']");
	                    if(formObj.length==0){
	                        alert("setYMD 함수 호출 시 1번째 매개변수로 들어온 form 태그의 name 값이 없습니다.");
	                        return;
	                    }
	                    var yearObj = formObj.find("[name='"+yearName+"']");
	                    var monthObj = formObj.find("[name='"+monthName+"']");
	                    var dateObj = formObj.find("[name='"+dateName+"']");

	                    var year = yearObj.val();
	                    var month = monthObj.val();
	                    var date = dateObj.val();

	                    if( year!="" && month!=""){
	                        year = parseInt(year,10);
	                        month = parseInt(month,10);

	                        var last_date = new Date(year,month,0).getDate();

	                        dateObj.empty();
	                        dateObj.append("<option value=''>");
	                        for(var i=1; i<=last_date; i++){
	                            if(i<10){
	                                dateObj.append("<option value='0"+i+"'>0"+i);
	                            }
	                            else{
	                                dateObj.append("<option value='"+i+"'>"+i);
	                            }
	                        }
	                        if(date!=""){
	                            dateObj.val(date);
	                        }
	                    }
	                }
	                catch(e){
	                    alert("setYMD 함수 호출 시 예외발생!!"+e.message);
	                }
	            }
			//-------------------------------------------------------------
			// 날짜가 변경되는 실행되는 함수 
			function checkYMRange(){
				setYMD( "dailyBusiReg","min_year","min_month","min_date");
				setYMD( "dailyBusiReg","max_year","max_month","max_date");
				
				var now = new Date();

				var now_year = now.getFullYear();
				var now_month = now.getMonth()+1;
				if(now_month<10){now_month= "0"+now_month}
				var now_day = now.getDate();
				if(now_day<10){now_day= "0"+now_day}
				var now_hour = now.getHours();
				if(now_hour<10){now_hour= "0"+now_hour}
				var now_min = now.getMinutes();
				if(now_min<10){now_min= "0"+now_min}
				

				
				var formObj = $("[name='dailyBusiReg']");
				//---------------------------------------------
				var min_yearObj = formObj.find(".min_year");
				var min_monthObj = formObj.find(".min_month");
				var min_dateObj = formObj.find(".min_date");
				var min_hourObj = formObj.find(".min_hour");
				var min_minuteObj = formObj.find(".min_minute");
				
				var max_yearObj = formObj.find(".max_year");
				var max_monthObj = formObj.find(".max_month");
				var max_dateObj = formObj.find(".max_date");
				var max_hourObj = formObj.find(".max_hour");
				var max_minuteObj = formObj.find(".max_minute");
				//---------------------------------------------
				var min_yearVal = min_yearObj.val();
				var min_monthVal = min_monthObj.val();
				var min_dateVal = min_dateObj.val();
				var min_hourVal = min_hourObj.val();
				var min_minuteVal = min_minuteObj.val();
				
				var max_yearVal = max_yearObj.val();
				var max_monthVal = max_monthObj.val();
				var max_dateVal = max_dateObj.val();
				var max_hourVal = max_hourObj.val();
				var max_minuteVal = max_minuteObj.val();
				//-------------------------------------------------
				if( min_yearVal=="" && min_monthVal!="" ){
					alert("년도가 없으면 월을 선택할 수 없습니다.");
					min_monthObj.val("");
					return;
				}
				if( min_monthVal=="" && min_dateVal!="" ){
					alert("월이 없으면 일을 선택할 수 없습니다.");
					min_dateObj.val("");
					return;
				}
				if( min_dateVal=="" && min_hourVal!="" ){
					alert("일이 없으면 시간을 선택할 수 없습니다.");
					min_hourObj.val("");
					return;
				}
				if( min_hourVal=="" && min_minuteVal!="" ){
					alert("시간이 없으면 분을 선택할 수 없습니다.");
					min_minuteObj.val("");
					return;
				}
				
				//-------------------------------------------------
				
				if( max_yearVal=="" && max_monthVal!="" ){
					alert("년도가 없으면 월을 선택할 수 없습니다.");
					max_monthObj.val("");
					return;
				}
				if( max_monthVal=="" && max_dateVal!="" ){
					alert("월이 없으면 일을 선택할 수 없습니다.");
					max_dateObj.val("");
					return;
				}
				if( max_dateVal=="" && max_hourVal!="" ){
					alert("일이 없으면 시간을 선택할 수 없습니다.");
					max_hourObj.val("");
					return;
				}
				if( max_hourVal=="" && max_minuteVal!="" ){
					alert("시간이 없으면 분을 선택할 수 없습니다.");
					max_minuteObj.val("");
					return;
				}
				if( min_yearVal!="" && min_monthVal!=""	&& min_dateVal!=""	&& min_hourVal!=""	&& min_minuteVal!="" 
						&&  max_yearVal!="" && max_monthVal!="" && max_dateVal!="" && max_hourVal!="" && max_minuteVal!=""){
					
					if( min_yearVal+min_monthVal+min_dateVal+min_hourVal+min_minuteVal > max_yearVal+max_monthVal+max_dateVal+max_hourVal+max_minuteVal ){
						alert("업무 시작 날짜가 끝나는 날짜보다 크면 안 됩니다!");
						max_yearObj.val("");
						max_monthObj.val("");
						max_dateObj.val("");
						max_hourObj.val("");
						max_minuteObj.val("");
						return;
					}
					if( min_yearVal+min_monthVal+min_dateVal+min_hourVal+min_minuteVal > now_year+""+now_month+""+now_day+""+now_hour+""+now_min){
						alert("업무 시작 날짜가 현재 날짜보다 크면 안 됩니다!");
						min_yearObj.val("");
						min_monthObj.val("");
						min_dateObj.val("");
						min_hourObj.val("");
						min_minuteObj.val("");
						return;
					}
					if( max_yearVal+max_monthVal+max_dateVal+max_hourVal+max_minuteVal > now_year+""+now_month+""+now_day+""+now_hour+""+now_min){
						alert("업무 끝나는 날짜가 현재 날짜보다 크면 안 됩니다!");
						max_yearObj.val("");
						max_monthObj.val("");
						max_dateObj.val("");
						max_hourObj.val("");
						max_minuteObj.val("");
						return;
					}
				}
			}

			//-------------------------------------------------------------
			// [오늘로] 클릭하면 실행되는 함수
			function now(){
				
				var now = new Date();
				
				var now_year = now.getFullYear();
				
				var now_month = now.getMonth()+1;
				if(now_month<10){now_month= "0"+now_month}
				
				var now_day = now.getDate();
				if(now_day<10){now_day= "0"+now_day}
				
				var now_hour = now.getHours();
				if(now_hour<10){now_hour= "0"+now_hour}
				
				var now_min = now.getMinutes();
				if(now_min<10){now_min= "0"+now_min}
				
				var formObj = $("[name='dailyBusiReg']");
				
				var max_yearObj = formObj.find(".max_year");
				var max_monthObj = formObj.find(".max_month");
				var max_dateObj = formObj.find(".max_date");
				var max_hourObj = formObj.find(".max_hour");
				var max_minuteObj = formObj.find(".max_minute");
				
				max_yearObj.val(now_year);
				max_monthObj.val(now_month);
				max_dateObj.val(now_day);
				max_hourObj.val(now_hour);
				max_minuteObj.val(now_min);
				
			}
			//-------------------------------------------------------------
			// [비움] 클릭하면 실행되는 함수
			function date_remove(){

				var formObj = $("[name='dailyBusiReg']");
				//---------------------------------------------
				var min_yearObj = formObj.find(".min_year");
				var min_monthObj = formObj.find(".min_month");
				var min_dateObj = formObj.find(".min_date");
				var min_hourObj = formObj.find(".min_hour");
				var min_minuteObj = formObj.find(".min_minute");
				
				var max_yearObj = formObj.find(".max_year");
				var max_monthObj = formObj.find(".max_month");
				var max_dateObj = formObj.find(".max_date");
				var max_hourObj = formObj.find(".max_hour");
				var max_minuteObj = formObj.find(".max_minute");
				//---------------------------------------------

				min_yearObj.val("");
				min_monthObj.val("");
				min_dateObj.val("");
				min_hourObj.val("");
				min_minuteObj.val("");

				max_yearObj.val("");
				max_monthObj.val("");
				max_dateObj.val("");
				max_hourObj.val("");
				max_minuteObj.val("");
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
									<strong>일일업무보고서 등록</strong>	
									<span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>								
								</header>

							<!-- Content -->
							<form name="dailyBusiReg" action="/dailyBusiRegProc.do" method="post">
								<table border=1 cellpadding="5" cellspacing="1" >
									<tr>
										<th>작성자</th>
										<td>&nbsp;&nbsp;${sessionScope.emp_name}</td>
									</tr>
									<tr>
										<th>업무분야</th>
										<td>									
											<select name="busi_type_code">
												<option value="">
												<option value="10">행정
												<option value="20">사무
												<option value="30">구매
												<option value="40">접대
												<option value="50">회계
												<option value="60">기타
											</select>
										</td>
									</tr>
									<tr>
										<th>업무내용</th>
										<td>
											<textarea name="busi_content"></textarea> 
										</td>
									</tr>
									<tr>
										<th>시간</th>
										<td>							
											<select name="min_year" class="min_year" onChange="checkYMRange()">
												<option value="">
												<option value="2022">2022
												<option value="2021">2021
												<option value="2020">2020
											</select>년
											<select  name="min_month" class="min_month" onChange="checkYMRange()">
												<option value="">
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
											<select  name="min_date" class="min_date" onChange="checkYMRange()"> 
												<option value="">
												<%for( int i=1; i<32; i++) {%>
													<%if(i<10){ %>
														<option value="0<%= i %>">0<%= i %>
													<% } %>
													<% if(i>=10){ %>
														<option value="<%= i %>"><%= i %>
													<% } %>
															
												<% } %>		
											</select>일
											<select  name="min_hour" class="min_hour" onChange="checkYMRange()">
												<option value="">
												<%for( int i=1; i<25; i++) {%>
													<%if(i<10){ %>
														<option value="0<%= i %>">0<%= i %>
													<% } %>
													<% if(i>=10){ %>
														<option value="<%= i %>"><%= i %>
													<% } %>
															
												<% } %>		
											</select>시
											<select  name="min_minute" class="min_minute" onChange="checkYMRange()">
												<option value="">
												<%for( int i=0; i<60; i++) {%>
													<%if(i<10){ %>
														<option value="0<%= i %>">0<%= i %>
													<% } %>
													<% if(i>=10){ %>
														<option value="<%= i %>"><%= i %>
													<% } %>
															
												<% } %>		
											</select>
											
											분 부터<div style="height:10px"></div>		
																		
											<select name="max_year" class="max_year" onChange="checkYMRange()">
												<option value="">
												<option value="2022">2022
												<option value="2021">2021
												<option value="2020">2020
											</select>년
											<select  name="max_month" class="max_month" onChange="checkYMRange()">
												<option value="">
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
											<select  name="max_date" class="max_date" onChange="checkYMRange()">
												<option value="">
												<%for( int i=1; i<32; i++) {%>
													<%if(i<10){ %>
														<option value="0<%= i %>">0<%= i %>
													<% } %>
													<% if(i>=10){ %>
														<option value="<%= i %>"><%= i %>
													<% } %>
															
												<% } %>		
											</select>일
											<select  name="max_hour" class="max_hour" onChange="checkYMRange()">
												<option value="">
												<%for( int i=1; i<25; i++) {%>
													<%if(i<10){ %>
														<option value="0<%= i %>">0<%= i %>
													<% } %>
													<% if(i>=10){ %>
														<option value="<%= i %>"><%= i %>
													<% } %>
															
												<% } %>		
											</select>시
											<select  name="max_minute" class="max_minute" onChange="checkYMRange()">
												<option value="">
												<%for( int i=0; i<60; i++) {%>
													<%if(i<10){ %>
														<option value="0<%= i %>">0<%= i %>
													<% } %>
													<% if(i>=10){ %>
														<option value="<%= i %>"><%= i %>
													<% } %>
															
												<% } %>		
											</select> 분 까지 &nbsp;&nbsp;&nbsp;
											<span style="cursor:pointer" onClick="now()">[오늘로]</span>
											<span style="cursor:pointer" onClick="date_remove()">[비움]</span>
		
											<input type="hidden" name="emp_no" value="${sessionScope.uid}">
											<input type="hidden" name="busi_start_date">
											<input type="hidden" name="busi_end_date">
											<input type="hidden" name="report_code" value="1">
										</td>
									</tr>
									<tr>
										<th>다음결재자</th>
										<td>		
												
											<select name="next_app_emp_no" class="next_app_emp_no" id="next_app_emp_no">
												<option value="">
												<% for (int i=0; i<next_app_list.size(); i++){ %>	
														<option value="<%= next_app_list.get(i).getEmp_no()  %>">
														
												   <%= next_app_list.get(i).getDep_name()%>부
												   <%= next_app_list.get(i).getEmp_name()%>
												   <%= next_app_list.get(i).getJikup_name()%>
												<% } %>											
											</select>
									</tr>
								</table>
								<br>
								<div align="center">
								<input type="button"value="등록" class="RegFormBtn">
								<input type="button"value="화면닫기" class="dailyListForm">
								<input type="reset" value="초기화">
								</div>
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