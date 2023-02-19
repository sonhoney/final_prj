<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        <title>메인화면</title>	
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
    			//*********************************************************************
    			// 클릭 부분
    			//*********************************************************************
				$(".expenseListForm").click(function(){
					location.replace("/expenseListForm.do");
				})
				$(".salesListForm").click(function(){
					location.replace("/salesListForm.do");
				})
				$(".dashboard").click(function(){
					location.replace("/dashboard.do");
				})
				$(".dailyListForm").click(function(){
					location.replace("/dailyListForm.do");
				})
    			//*********************************************************************
    			//*********************************************************************
    			  
    			var formObj = $("[name=salesAppYesNoForm]");		    			
    			var approval_yesNo = formObj.find(".approval_yesNo_tr");
    			var next_app_yesOrNoObj = $(".next_app_No");
    			

    			//-----------------------------------------------------------------------------------------------------
    			// 선택한 보고서와 작성자가 같으면
    			//-----------------------------------------------------------------------------------------------------
    			
    			if("${requestScope.salesDTO.emp_no}"=="${sessionScope.uid}"){
    				$(".approval_yesNoBtn").remove();
    				approval_yesNo.remove();
        			document.getElementById('next_app_emp_no').disabled = true;
        			document.getElementById('next_app_No').disabled = true;
        			if("${requestScope.lastAppMan.last_sign_code}"==0){
        				$(".next_app_emp_no").val("${requestScope.nextAppMan.next_emp_no}");
    					$(".button_span").prepend("<h2>최종 결재 완료된 보고서입니다.</h2>");
        			}
        			else if("${requestScope.lastAppMan.last_sign_code}"==-1){
        				$(".next_app_emp_no").val("${requestScope.nextAppMan.next_emp_no}");
    					$(".button_span").prepend("<h2>결재 진행중인 보고서입니다.</h2>");
        			}
        			else if("${requestScope.lastAppMan.last_sign_code}"==1){
        				if("${requestScope.nextAppMan.next_sign_code}"==1){
                            $(".button_span").prepend("<input type='button' value='수정' class='alterBtn' name='alterBtn'>");
                            document.getElementById('sales_content').disabled = false;
                            document.getElementById('sales_result').disabled = false;
                            $(".next_app_emp_no").val("${requestScope.nextAppMan.next_emp_no}");
                        }
                        else{
                            $(".button_span").prepend("<h2>결재 진행중인 보고서입니다.</h2>");
                        }
        			}
    			}
    			
    			
    			//-----------------------------------------------------------------------------------------------------
    			//생성된 수정버튼을 누르면	
    			//-----------------------------------------------------------------------------------------------------
    														
    			$(".alterBtn").click(function(){  
    				
					$(".button_span").prepend("<input type='hidden' value='${requestScope.nextAppMan.next_emp_no}' name='next_app_emp_no'>");
    				$(".next_app_emp_no").val("${requestScope.nextAppMan.next_emp_no}");
					$.ajax({
						url:"/salesAlterProc.do"	
						,type:"post"
						,data:$("[name='salesAppYesNoForm']").serialize()
						,success:function(regCnt){
							if(regCnt==1){
								alert("업무일지 수정 성공");
								location.replace("/salesListForm.do")
							}
						}
						,error:function(){
							alert("웹서버 접속 실패! 관리자에게 문의 바람");
						}					
					})
    				
    			})
    			
    			//-----------------------------------------------------------------------------------------------------
    			// 선택한 보고서와 작성자가 다르고 미결재가 아니면
    			//-----------------------------------------------------------------------------------------------------
    			if(("${requestScope.salesDTO.emp_no}"!="${sessionScope.uid}") && ("${requestScope.salesDTO.sign_code}"=="1"||"${requestScope.salesDTO.sign_code}"=="0")){
        			document.getElementById('next_app_emp_no').disabled = true;
    				approval_yesNo.remove();
    				$(".approval_yesNoBtn").remove();
    				if("${requestScope.salesDTO.sign_code}"==1){
        				$(".next_app_emp_no").val("${requestScope.nextAppMan.next_emp_no}");
    					$(".button_span").prepend("<h2>반려되어 결재할 수 없습니다.</h2>");
            			document.getElementById('next_app_No').disabled = true;
    				}
    				else if("${requestScope.salesDTO.sign_code}"==0 && "${requestScope.salesDTO.sign_code}"!="${requestScope.lastAppMan.last_sign_code}"){
        				$(".next_app_emp_no").val("${requestScope.nextAppMan.next_emp_no}");
    					$(".button_span").prepend("<h2>결재한 보고서 입니다.</h2>");
            			document.getElementById('next_app_No').disabled = true;
    				}
    				else if("${requestScope.salesDTO.sign_code}"==0 && "${requestScope.salesDTO.sign_code}"=="${requestScope.lastAppMan.last_sign_code}"){
        				$(".next_app_emp_no").val("${requestScope.nextAppMan.next_emp_no}");
    					$(".button_span").prepend("<h2>최종 결재 완료된 보고서입니다.</h2>");
            			document.getElementById('next_app_No').disabled = true;
    				}
    				
    			}   
    			//-----------------------------------------------------------------------------------------------------
    			//===========================================================================================================================================================================
                //===========================================================================================================================================================================
                if(("${requestScope.salesDTO.emp_no}"!="${sessionScope.uid}") && ("${requestScope.salesDTO.sign_code}"=="-1"&&"${requestScope.lastAppMan.last_sign_code}"=="1")){
                    //alert("${requestScope.nextAppManEmp_no}")
                     $(".next_app_emp_no").val("${requestScope.nextAppManEmp_no}");
                    $("select[name=next_app_emp_no]").attr('onFocus', 'this.initialSelect = this.selectedIndex;');
                    $("select[name=next_app_emp_no]").attr('onChange', 'this.selectedIndex = this.initialSelect;');
                    $("[name=next_app_emp_no]").change(function(){
                        alert("결재순서에 맞게 선택되어야 합니다.");
                        $(".next_app_emp_no").val("${requestScope.nextAppManEmp_no}");
                    }) 

                    
                    if("${requestScope.dailyBusiDTO.emp_no}"!="${requestScope.lastAppMan.emp_no}"){
                    	document.getElementById('next_app_No').disabled = true;	
                    }


                }
                //===========================================================================================================================================================================
                //===========================================================================================================================================================================
    			
    			//-----------------------------------------------------------------------------------------------------
    			// 결재/반려 클릭시 일어나는 일 
    			//-----------------------------------------------------------------------------------------------------
    			formObj.find("[name=approval_yesNo]").change(function(){
				    var approval_yesNo = $(":input:radio[name=approval_yesNo]:checked").val();	
				    
				    if(approval_yesNo==1){
	        			document.getElementById('next_app_emp_no').disabled = true;	
	        			next_app_yesOrNoObj.prop("checked",true);
	        			document.getElementById('next_app_No').disabled = true;	
	        			$(".next_app_emp_no").val("");
	        			$(".approval_yesNo_td").append("<textarea name='return_result' placeholder='반려사유작성'></textarea>");			    	
				    }
				    else if(approval_yesNo==0){ 
				    	 //===========================================================================================================================================================================
		                if(("${requestScope.salesDTO.emp_no}"!="${sessionScope.uid}") && ("${requestScope.salesDTO.sign_code}"=="-1"&&"${requestScope.lastAppMan.last_sign_code}"=="1")){
		                    //alert("${requestScope.nextAppManEmp_no}")
		                     $(".next_app_emp_no").val("${requestScope.nextAppManEmp_no}");
		                    $("select[name=next_app_emp_no]").attr('onFocus', 'this.initialSelect = this.selectedIndex;');
		                    $("select[name=next_app_emp_no]").attr('onChange', 'this.selectedIndex = this.initialSelect;');
		                    $("[name=next_app_emp_no]").change(function(){
		                        alert("결재순서에 맞게 선택되어야 합니다.");
		                        $(".next_app_emp_no").val("${requestScope.nextAppManEmp_no}");
		                    }) 


		                }
		                //===========================================================================================================================================================================
	        			document.getElementById('next_app_emp_no').disabled = false;
	        			next_app_yesOrNoObj.prop("checked",false);
	        			document.getElementById('next_app_No').disabled = false;	
	        			$(".approval_yesNo_td").find("[name=return_result]").remove();
	        			if("${sessionScope.uid}"!="${requestScope.lastAppMan.last_emp_no}"){
	                   		document.getElementById('next_app_No').disabled = true;	
	                   } 
				    }
    				
    			})
    			//-----------------------------------------------------------------------------------------------------
    			
    			//-----------------------------------------------------------------------------------------------------
    			// 다음결재자 없음을 누르면 벌어지는일
    			//-----------------------------------------------------------------------------------------------------
    			next_app_yesOrNoObj.change(function(){
				    
    				
    				if(next_app_yesOrNoObj.prop("checked")){
	        			document.getElementById('next_app_emp_no').disabled = true;	
	        			$(".next_app_emp_no").val("");
	        			
    				}
    				if(next_app_yesOrNoObj.prop("checked")==false){
	        			document.getElementById('next_app_emp_no').disabled = false;
    				}
    				
    			})
    			//-----------------------------------------------------------------------------------------------------
    			//-----------------------------------------------------------------------------------------------------


    			
    			//-----------------------------------------------------------------------------------------------------
    			// 날짜 처리
    			//-----------------------------------------------------------------------------------------------------
    			var sales_date_start = "${requestScope.salesDTO.sales_date_start}"; 
    			var sales_date_end = "${requestScope.salesDTO.sales_date_end}"; 
    			
    			
    			var min_year = sales_date_start.substr(0,4);  
    			var min_month = sales_date_start.substr(5,2); 
    			var min_date = sales_date_start.substr(8,2); 
    			var min_hour = sales_date_start.substr(11,2); 
    			var min_minute = sales_date_start.substr(14,2);  
    				
       			var max_year = sales_date_end.substr(0,4); 
       			var max_month = sales_date_end.substr(5,2);  
       			var max_date = sales_date_end.substr(8,2);  
       			var max_hour = sales_date_end.substr(11,2);  
       			var max_minute = sales_date_end.substr(14,2);  
       			
       			formObj.find(".min_year").val(min_year);
    			document.getElementById('min_year').disabled = true;
				formObj.find(".min_month").val(min_month);
    			document.getElementById('min_month').disabled = true;
				formObj.find(".min_date").val(min_date);
    			document.getElementById('min_date').disabled = true;
				formObj.find(".min_hour").val(min_hour);	
    			document.getElementById('min_hour').disabled = true;			
				formObj.find(".min_minute").val(min_minute);	
	    		document.getElementById('min_minute').disabled = true;	
				//-----------------------------------------------------
				formObj.find(".max_year").val(max_year);
    			document.getElementById('max_year').disabled = true;
				formObj.find(".max_month").val(max_month);
    			document.getElementById('max_month').disabled = true;
				formObj.find(".max_date").val(max_date);
    			document.getElementById('max_date').disabled = true;
				formObj.find(".max_hour").val(max_hour);	
    			document.getElementById('max_hour').disabled = true;			
				formObj.find(".max_minute").val(max_minute);	
    			document.getElementById('max_minute').disabled = true;
    			//-----------------------------------------------------------------------------------------------------
    			formObj.find(".sales_type_code").val("${requestScope.salesDTO.sales_type_code}");
    			document.getElementById('sales_type_code').disabled = true;
    			//-----------------------------------------------------------------------------------------------------
    			
    			//----------------------------------------------------------
    			// 결재/반려 결과
    			//----------------------------------------------------------
  			
    			$(".approval_yesNoBtn").click(function(){
				    var approval_yesNo = $(":input:radio[name=approval_yesNo]:checked").val();
				    
				    if(approval_yesNo==null){
				    	alert("결재/반려를 선택해주세요")
				    }
				    
				    var next_app_No = $(":input:checkbox[name=next_app_No]:checked").val();

				    var nextAppNo = $("[name=nextAppNoPerson]");
							    
				    if(next_app_No!=""){
				    	nextAppNo.val(next_app_No);
				    }
    					
				
					if(approval_yesNo=="0"){		
						
						if($(".next_app_emp_no").val()=="" && next_app_yesOrNoObj.prop("checked")==false){
                            alert("다음결재자를 선택하거나 다음결재자없음을 선택해주세요.");
                            return;
                        }
						
						$.ajax({
							url:"/salesUpdelProc.do"	
							,type:"post"
							,data:$("[name='salesAppYesNoForm']").serialize()
							,success:function(regCnt){
								if(regCnt==1){
									alert("업무일지 결재 성공");
									location.replace("/salesListForm.do")
								}
							}
							,error:function(){
								alert("웹서버 접속 실패! 관리자에게 문의 바람");
							}
						
						})
						
					}
										
					if(approval_yesNo=="1"){	
						$.ajax({
							url:"/salesUpdelProc.do"	
							,type:"post"
							,data:$("[name='salesAppYesNoForm']").serialize()
							,success:function(regCnt){
								if(regCnt>0){
									alert("업무일지 반려 성공");
									location.replace("/salesListForm.do")
								}
							}
							,error:function(){
								alert("웹서버 접속 실패! 관리자에게 문의 바람");
							}
						
						})
					}
					
					
    			})    			
    			//----------------------------------------------------------
    			// 결재/반려 결과
    			//----------------------------------------------------------
    			/*
	    		*/
    		})
    		
    		
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
									<strong>영업 보고서 </strong>
									<span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>	
									
								</header>

							<!-- Content -->
							<form name="salesAppYesNoForm">
							<table border=1 cellpadding="5" cellspacing="1" >
								<tr>
									<th>제목</th>
									<td>${requestScope.salesDTO.report_name}</td>
								</tr>
								<tr>
									<th>방문목적</th>
									<td>									
										<select name="sales_type_code" class="sales_type_code" id="sales_type_code" >
											<option value="">
											<option value="10">영업자관리
											<option value="20">수급
											<option value="30">회의
											<option value="40">거래처확보
											<option value="50">기타
										</select>
									</td>
								</tr>
								<tr>
									<th>만난사람</th>
									<td>
										<table border=1 cellpadding="5" cellspacing="1" >
											<tr>
												<td>회사이름</td>
												<td>이름</td>
												<td>직급</td>
												<td>전화번호</td>					
											</tr>
											<tr>
												<td><input type="text" style="border:solid" value="${requestScope.salesDTO.sales_company}"  name="sales_company" id="sales_company" disabled></td>
												<td><input type="text" style="border:solid" value="${requestScope.salesDTO.sales_name}"  name="sales_name" id="sales_name" disabled></td>
												<td><input type="text" style="border:solid" value="${requestScope.salesDTO.sales_jikup}"  name="sales_jikup" id="sales_jikup" disabled></td>
												<td><input type="text" style="border:solid" value="${requestScope.salesDTO.sales_phone}"  name="sales_phone" id="sales_phone" disabled></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<th>방문시간</th>
									<td>							
												<select class="min_year" id="min_year" onChange="checkYMRange()">
													<option value="">
													<option value="2022">2022
													<option value="2021">2021
													<option value="2020">2020
												</select>년
												<select  class="min_month" id="min_month" onChange="checkYMRange()">
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
												<select  class="min_date" id="min_date" onChange="checkYMRange()"> 
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
												<select  class="min_hour" id="min_hour" onChange="checkYMRange()">
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
												<select  class="min_minute"  id="min_minute" onChange="checkYMRange()">
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
																			
												<select  class="max_year" id="max_year" onChange="checkYMRange()">
													<option value="">
													<option value="2022">2022
													<option value="2021">2021
													<option value="2020">2020
												</select>년
												<select  class="max_month" id="max_month" onChange="checkYMRange()">
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
												<select  class="max_date" id="max_date" onChange="checkYMRange()">
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
												<select  class="max_hour"  id="max_hour" onChange="checkYMRange()">
													<option value="">
													<option value="01">01
													<%for( int i=1; i<25; i++) {%>
														<%if(i<10){ %>
															<option value="0<%= i %>">0<%= i %>
														<% } %>
														<% if(i>=10){ %>
															<option value="<%= i %>"><%= i %>
														<% } %>
																
													<% } %>		
												</select>시
												<select  class="max_minute" id="max_minute" onChange="checkYMRange()">
													<option value="">
													<%for( int i=0; i<60; i++) {%>
														<%if(i<10){ %>
															<option value="0<%= i %>">0<%= i %>
														<% } %>
														<% if(i>=10){ %>
															<option value="<%= i %>"><%= i %>
														<% } %>
																
													<% } %>		
												</select> 분 까지
											</td>													
								</tr>
								<tr>
									<th>영업내용</th>
									<td><textarea name="sales_content" id="sales_content" disabled>${requestScope.salesDTO.sales_content}</textarea></td>
								</tr>
								<tr>
									<th>영업성과</th>
									<td><textarea name="sales_result" id="sales_result" disabled>${requestScope.salesDTO.sales_result}</textarea></td>
								</tr>
											
									<tr class="approval_yesNo_tr">
										<th>결재/반려</th>
										<td class="approval_yesNo_td">
											<input type="radio" name="approval_yesNo" value="0">결재
											<input type="radio" name="approval_yesNo" value="1">반려
										</td>
									</tr>
								<tr>
									<th>다음 결재자</th>
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
										<input type="checkbox" class="next_app_No" id="next_app_No" name="next_app_No" value="No"> 다음결재자 없음
									</td>
								</tr>
								 <tr>
									<th>결재내역</th>
										<td>
										<table border=1 cellpadding=5 cellspacing=0>
												<tr>
													<th>결재순서</th>
													<th>결재자명</th>
													<th>부서명</th>
													<th>직책</th>
													<th>결재여부</th>
													<th>결재일</th>
													<th>반려사유</th>
												</tr>
												<tr>
													<td>1
													<td>${requestScope.salesDTO.emp_name}
													<td>${requestScope.salesDTO.dep_name}
													<td>${requestScope.salesDTO.jikup_name}
													<td><c:if test="${requestScope.lastAppMan.last_sign_code==0}">최종</c:if><c:if test="${requestScope.nextAppMan.next_sign_code==-1||requestScope.nextAppMan.next_sign_code==0}">결재</c:if><c:if test="${requestScope.lastAppMan.last_sign_code==0}">완료</c:if>
														<c:if test="${requestScope.nextAppMan.next_sign_code==1 && requestScope.lastAppMan.last_sign_code==1}">반려처리중</c:if>
													<td>${requestScope.nextAppMan.next_sign_date}
													<td>
												</tr>
												<c:forEach var="xxx" items="${requestScope.appList}" varStatus="loopTagStatus">
													<tr 
														bgcolor="${loopTagStatus.index%2==1?'white':'lightgray'}"
													>
														<td>${loopTagStatus.index+2}
														<td>${xxx.app_emp_name}
														<td>${xxx.app_dep_name}						
														<td>${xxx.app_jikup_name}
														<td><c:if test="${requestScope.lastAppMan.last_sign_code==0}">최종</c:if>${xxx.app_sign_name}<c:if test="${requestScope.lastAppMan.last_sign_code==0}">완료</c:if><c:if test="${xxx.app_sign_name=='반려'}"> 처리 대기중</c:if>
														<td>${xxx.next_app_date}			
														<td>${xxx.app_return_result}
													</tr>
												</c:forEach>
										</table>
									</td>
								</tr> 
							</table>
							<div align="center">
								<span class="button_span">
								<input type="button" value="결재/반려" class="approval_yesNoBtn">
								<input type="button" value="화면닫기" class="salesListForm">
									<input type="hidden" value="${requestScope.salesDTO.emp_no}" name="emp_no">
									<input type="hidden" value="${requestScope.salesDTO.report_no}" name="report_no">
									<input type="hidden" value="${requestScope.salesDTO.report_code}" name="report_code">
									<input type="hidden" name="nextAppNoPerson">
								</span>
							</div>	
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