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

    		
    		var xxx = $("[name=expense_price]");
            var xxxVal = xxx.val();

            xxx.val(xxxVal.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
    		
			//로그아웃
			$(".logoutBtn").click(
			function(){
				if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
				location.replace("/logout.do");
			});
			
			$(".dailyListForm").click(function(){
				location.replace("/dailyListForm.do");
			})
			$(".dashboard").click(function(){
				location.replace("/dashboard.do");
			})
			$(".salesListForm").click(function(){
				location.replace("/salesListForm.do");
			})
			$(".expenseListForm").click(function(){
				location.replace("/expenseListForm.do");
			})
			$(".RegFormBtn").click(function(){
				expenseRegFormCheck();
			})

   			var formObj = $("[name=expenseAppYesNoForm]");		    			
   			var approval_yesNo = formObj.find(".approval_yesNo_tr");
   			var next_app_yesOrNoObj = $(".next_app_No");


			//-----------------------------------------------------------------------------------------------------
			// 선택한 보고서와 작성자가 같으면
			//-----------------------------------------------------------------------------------------------------	
			if("${requestScope.expenseDTO.emp_no}"=="${sessionScope.uid}"){
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
                        document.getElementById('expense_price').disabled = false;
                        document.getElementById('receipt_no').disabled = false;
                        document.getElementById('remarks').disabled = false;
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
					url:"/expenseAlterProc.do"	
					,type:"post"
					,data:$("[name='expenseAppYesNoForm']").serialize()
					,success:function(regCnt){
						if(regCnt==1){
							alert("지출보고서 수정 성공");
							location.replace("/expenseListForm.do")
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
			if(("${requestScope.expenseDTO.emp_no}"!="${sessionScope.uid}") && ("${requestScope.expenseDTO.sign_code}"=="1"||"${requestScope.expenseDTO.sign_code}"=="0")){
    			document.getElementById('next_app_emp_no').disabled = true;
				approval_yesNo.remove();
				$(".approval_yesNoBtn").remove();
				if("${requestScope.expenseDTO.sign_code}"==1){
    				$(".next_app_emp_no").val("${requestScope.nextAppMan.next_emp_no}");
					$(".button_span").prepend("<h2>반려되어 결재할 수 없습니다.</h2>");
        			document.getElementById('next_app_No').disabled = true;
				}
				else if("${requestScope.expenseDTO.sign_code}"==0 && "${requestScope.expenseDTO.sign_code}"!="${requestScope.lastAppMan.last_sign_code}"){
    				$(".next_app_emp_no").val("${requestScope.nextAppMan.next_emp_no}");
					$(".button_span").prepend("<h2>결재한 보고서 입니다.</h2>");
        			document.getElementById('next_app_No').disabled = true;
				}
				else if("${requestScope.expenseDTO.sign_code}"==0 && "${requestScope.expenseDTO.sign_code}"=="${requestScope.lastAppMan.last_sign_code}"){
    				$(".next_app_emp_no").val("${requestScope.nextAppMan.next_emp_no}");
					$(".button_span").prepend("<h2>최종 결재 완료된 보고서입니다.</h2>");
        			document.getElementById('next_app_No').disabled = true;
				}
				
			}   
			//-----------------------------------------------------------------------------------------------------
            //===========================================================================================================================================================================
            if(("${requestScope.expenseDTO.emp_no}"!="${sessionScope.uid}") && ("${requestScope.expenseDTO.sign_code}"=="-1"&&"${requestScope.lastAppMan.last_sign_code}"=="1")){
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
		            if(("${requestScope.expenseDTO.emp_no}"!="${sessionScope.uid}") && ("${requestScope.expenseDTO.sign_code}"=="-1"&&"${requestScope.lastAppMan.last_sign_code}"=="1")){
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

			//------------------------------------------------------------------------------------------
			// 날짜처리
			//------------------------------------------------------------------------------------------
			var expense_dateObj = "${requestScope.expenseDTO.expense_date}";   
			var expense_year = expense_dateObj.substr(0,4);  
			var expense_month = expense_dateObj.substr(5,2); 
			var expense_day = expense_dateObj.substr(8,2);  

			
			formObj.find(".expense_year").val(expense_year);
			document.getElementById('expense_year').disabled = true;
			formObj.find(".expense_month").val(expense_month);
			document.getElementById('expense_month').disabled = true;
			formObj.find(".expense_day").val(expense_day);
			document.getElementById('expense_day').disabled = true;

			formObj.find(".expense_field_code").val("${requestScope.expenseDTO.expense_field_code}");
			document.getElementById('expense_field_code').disabled = true;
			
			formObj.find(".expense_method_code").val("${requestScope.expenseDTO.expense_method_code}");
			document.getElementById('expense_method_code').disabled = true;			
			//------------------------------------------------------------------------------------------
			//------------------------------------------------------------------------------------------
			
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
						url:"/expenseUpdelProc.do"	
						,type:"post"
						,data:$("[name='expenseAppYesNoForm']").serialize()
						,success:function(regCnt){
							if(regCnt==1){
								alert("지출일지 결재 성공");
								location.replace("/expenseListForm.do")
							}
						}
						,error:function(){
							alert("웹서버 접속 실패! 관리자에게 문의 바람");
						}
					
					})
					
				}
									
				if(approval_yesNo=="1"){	
					$.ajax({
						url:"/expenseUpdelProc.do"	
						,type:"post"
						,data:$("[name='expenseAppYesNoForm']").serialize()
						,success:function(regCnt){
							if(regCnt>0){
								alert("지출일지 반려 성공");
								location.replace("/expenseListForm.do")
							}
						}
						,error:function(){
							alert("웹서버 접속 실패! 관리자에게 문의 바람");
						}
					
					})
				}
				
				
			})    			
			
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
									<strong>지출보고서상세보기</strong>
									<span align="right"><strong> ${sessionScope.emp_name} ${sessionScope.jikup_name}님</strong></span>			
									
								</header>

							<!-- Content -->
							
                            <form  name="expenseAppYesNoForm">                                
                                <table border=1 cellpadding="5" cellspacing="1" >                      
									<tr>
										<th>지출 제목</th>
										<td>${requestScope.expenseDTO.report_name}</td>
									</tr>	                      
									<tr>
										<th>결재 내역</th>
										<td>
											<table>
												<tr>
													<th>분야</th>
													<th>수단</th>
													<th>비용</th>
													<th>영수증번호</th> 
												</tr>
												<tr>
													<td>
														<select name="expense_field_code" id="expense_field_code" class="expense_field_code">
															<option value="">
															<option value="10">식대
															<option value="15">회식비
															<option value="20">접대비
															<option value="25">비품
															<option value="30">기자재
															<option value="35">사무기구
															<option value="40">교통비
															<option value="45">경조사비
															<option value="50">숙박비
															<option value="55">의류비
															<option value="60">도서비
															<option value="65">홍보비
															<option value="70">기타
														</select>
													</td>
													<td>
														<select name="expense_method_code" id="expense_method_code" class="expense_method_code">
															<option value="">
															<option value="10">회사카드
															<option value="20">회사현금
															<option value="30">개인카드
															<option value="40">개인현금
														</select>
													</td>
													<td>
														<input type="text" style="border:solid;width:150px;" id="expense_price" name="expense_price" value="${requestScope.expenseDTO.expense_price}" disabled>&nbsp;원
													</td>
													<td>
														<input type="text" style="border:solid;width:200px;" id="receipt_no"  name="receipt_no" value="${requestScope.expenseDTO.receipt_no}" disabled>
													</td>
												<tr>
													<th colspan='2'>지출일</th>
													<th colspan='2'>비고</th>
												</tr>
													<td colspan='2'>
														<select class="expense_year" id="expense_year">
															<option value="">
															<option value="2022">2022
															<option value="2021">2021
															<option value="2020">2020
														</select>&nbsp;년 &nbsp;&nbsp;&nbsp;
														<select  class="expense_month" id="expense_month">
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
														</select>&nbsp;월&nbsp;&nbsp;&nbsp;
														<select  class="expense_day" id="expense_day">
															<option value="">
															<%for( int i=1; i<32; i++) {%>
																<%if(i<10){ %>
																	<option value="0<%= i %>">0<%= i %>
																<% } %>
																<% if(i>=10){ %>
																	<option value="<%= i %>"><%= i %>
																<% } %>
																		
															<% } %>		
														</select>&nbsp;일&nbsp;&nbsp;&nbsp;
														<input type="hidden" name="emp_no" value="${sessionScope.uid}">
														<input type="hidden" name="expense_date">
														<input type="hidden" name="report_code" value="3">
													</td>
													<td colspan='2'>
														<input type="text" style="border:solid;width:400px;" id="remarks"   name="remarks" value="${requestScope.expenseDTO.remarks}" disabled>
													</td>
												</tr>
											</table>
										</td>
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
													<option value=""></option>													
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
											<th> 결재 내역</th>
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
														<td>${requestScope.expenseDTO.emp_name}
														<td>${requestScope.expenseDTO.dep_name}
														<td>${requestScope.expenseDTO.jikup_name}
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
                            <center>
							<div align="center">
								<span class="button_span">
								<input type="button" value="결재/반려" class="approval_yesNoBtn">
								<input type="button" value="화면닫기" class="expenseListForm">
									<input type="hidden" value="${requestScope.expenseDTO.emp_no}" name="emp_no">
									<input type="hidden" value="${requestScope.expenseDTO.report_no}" name="report_no">
									<input type="hidden" value="${requestScope.expenseDTO.report_code}" name="report_code">
									<input type="hidden" name="nextAppNoPerson">
								</span>
							</div>                           
                            </form>
                            </body>


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