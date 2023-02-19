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
        <title>메인화면</title>	
            <link rel="stylesheet" href="/css/main.css" />
        <!-- ******************************************************** -->
        <!--  JQuery 라이브러리 수입하기 -->
        <!-- ******************************************************** -->
        <script src="/js/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>	
		<% String emp_name = (String)session.getAttribute("emp_name");%>
		<!-- ★★★★★★★★★★★★★★★★★★★★★★★★★ -->	    
		<!-- 부서별 사원 수  -->
		<!-- ★★★★★★★★★★★★★★★★★★★★★★★★★ -->	
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript">
		
		   // Load the Visualization API and the corechart package.
		   google.charts.load('current', {'packages':['corechart']});
		
		   // Set a callback to run when the Google Visualization API is loaded.
		   google.charts.setOnLoadCallback(drawChart);
		
		   // Callback that creates and populates a data table,
		   // instantiates the pie chart, passes in the data and
		   // draws it.
		   function drawChart() {
		
		 	  /*
		 	  
		 	  	int getEmp10();	
		int getEmp20();
		int getEmp30();
		int getEmp40();
		int getEmp50();
		int getEmp60();
		 	  
		 	  */
		 	  
		 	var e1 = ${requestScope.emp10};
		 	var e2 = ${requestScope.emp20};
		 	var e3 = ${requestScope.emp30};
		 	var e4 = ${requestScope.emp40};
		 	var e5 = ${requestScope.emp50};
		 	var e6 = ${requestScope.emp60};  
		 	  
		     // Create the data table.
		     var data = new google.visualization.DataTable();
		     data.addColumn('string', 'Topping');
		     data.addColumn('number', 'Slices');
		     data.addRows([
		       ['사무', e1 ],
		       ['행정', e2 ],
		       ['접대', e3 ],
		       ['회계', e4 ],
		       ['구매', e5 ],
		       ['기타', e6 ]
		     ]);
		
		     // Set chart options
		     var options = { title:' '
			        ,width: 400
			        ,height: 325
		     		        ,chartArea : { width : "90%" , height : "90%" }
		                    };
		
		     // Instantiate and draw our chart, passing in some options.
		     var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
		     chart.draw(data, options);
		   }		   		 
		</script>
		<!-- ★★★★★★★★★★★★★★★★★★★★★★★★★ -->	    
		<!-- 내가 올린 보고서 분야별 개수 그래프  -->
		<!-- ★★★★★★★★★★★★★★★★★★★★★★★★★ -->	
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript">
                    
			  
			  
			  
			  /*
			  
			  
		    (select count(busi_type_code) from daily_report where busi_type_code=10 and emp_no =${uid})  as "hj"
		    ,(select count(busi_type_code) from daily_report where busi_type_code=20 and emp_no =${uid}) as "sm"
		    ,(select count(busi_type_code) from daily_report where busi_type_code=30 and emp_no =${uid}) as "gm"
		    ,(select count(busi_type_code) from daily_report where busi_type_code=40 and emp_no =${uid}) as "jd"
		    ,(select count(busi_type_code) from daily_report where busi_type_code=50 and emp_no =${uid}) as "hg"
		    ,(select count(busi_type_code) from daily_report where busi_type_code=60 and emp_no =${uid}) as "gt"
			  
		    
		    getRegDeailyBusiTypeCnt
			  */
			  
                     
					    google.charts.load("current", {packages:['corechart']});
					    google.charts.setOnLoadCallback(drawChart);
					    function drawChart() {
					    	
					    	
					       	<c:if test="${requestScope.DeailyCnt.d_report == 1}">
					    	  	var d1 = 0;
					    	  	var d2 = 0;
					    	  	var d3 = 0;
					    	  	var d4 = 0;
					    	  	var d5 = 0;
			    	  		</c:if>
			    	  		<c:if test="${requestScope.SaleCnt.s_report == 2}">	      
					    	  	var s1 = 0;
					    	  	var s2 = 0;
					    	  	var s3 = 0;
					    	  	var s4 = 0;
					    		var s5 = 0;
			    	  		</c:if>
			    	  		<c:if test="${requestScope.ExCnt.e_report == 3}">
					    	  	var e1 = 0;
					    	  	var e2 = 0;
					    	  	var e3 = 0;
					    	  	var e4 = 0;
			    	  		</c:if>
					    	
					    	
					    	
					    	<c:if test="${requestScope.DeailyCnt.d_report == 1}">
					    	  	var d1 = ${requestScope.DeailyCnt.d1};
					    	  	var d2 = ${requestScope.DeailyCnt.d2};
					    	  	var d3 = ${requestScope.DeailyCnt.d3};
					    	  	var d4 = ${requestScope.DeailyCnt.d4};
					    	  	var d5 = ${requestScope.DeailyCnt.d5};
				    	  	</c:if>
				    	  	<c:if test="${requestScope.SaleCnt.s_report == 2}">	      
					    	  	var s1 = ${requestScope.SaleCnt.s1};
					    	  	var s2 = ${requestScope.SaleCnt.s2};
					    	  	var s3 = ${requestScope.SaleCnt.s3};
					    	  	var s4 = ${requestScope.SaleCnt.s4};
					    	  	var s5 = ${requestScope.SaleCnt.s5};
				    	  	</c:if>
				    	  	<c:if test="${requestScope.ExCnt.e_report == 3}">
					    	  	var e1 = ${requestScope.ExCnt.e1};
					    	  	var e2 = ${requestScope.ExCnt.e2};
					    	  	var e3 = ${requestScope.ExCnt.e3};
					    	  	var e4 = ${requestScope.ExCnt.e4};
				    	  	</c:if>
					    	
					      var data = google.visualization.arrayToDataTable([
					    	  
					    	  
					   //    DeailyCnt  SaleCnt  ExCnt
					    	  
					    	  
					    	  <c:if test="${requestScope.DeailyCnt.d_report == 1}">
						    	  
					    	  
						    	    ["Element", "보고서 수", { role: "style" } ],
							        ["행정", d1 , "red"],
							        ["사무", d2 , "blue"],
							        ["구매", d3, "puple"],
							        ["접대", d4 , "orange"],
							        ["회계", d5 , "green"]
					    	  
					    	  </c:if>
					    	  
						      <c:if test="${requestScope.SaleCnt.s_report == 2}">
						     
							    	  
						    	    ["Element", "보고서 수", { role: "style" } ],
							        ["영업자관리", s1 , "red"],
							        ["수급", s2 , "blue"],
							        ["회의", s3 , "puple"],
							        ["거래처", s4 , "orange"],
							        ["기타", s5 , "green"]
					    	  
					    	  </c:if>
					        
						       <c:if test="${requestScope.ExCnt.e_report == 3}">
						       

						       
							    	  
						    	    ["Element", "보고서 수", { role: "style" } ],
							        ["회사카드", e1 , "red"],
							        ["회사현금", e2 , "blue"],
							        ["개인카드", e3, "puple"],
							        ["개인현금", e4 , "orange"]
					    	  
					    	  </c:if>
					        
					      ]);
					
					      var view = new google.visualization.DataView(data);
					      view.setColumns([0, 1,
					                       { calc: "stringify",
					                         sourceColumn: 1,
					                         type: "string",
					                         role: "annotation" },
					                       2]);
					
					      var options = {
					        width: 400,
					        height: 300,
					        bar: {groupWidth: "90%"},
					        legend: { position: "none" },
					        chartArea : { width : "90%" , height : "90%" }
					      };
					      var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
					      chart.draw(view, options);
					  }
 			</script>



			   
			        <script type="text/javascript">
			        
				      	var payment;
				        var notPayment; 
					    var returnCnt;
			        
			            <c:if test="${empty requestScope.getATCnt.payment}">
			            
			            	payment = 0;
			            
			            </c:if>
			        
                        <c:if test="${!empty requestScope.getATCnt.payment}">
			            
                        payment = ${requestScope.getATCnt.payment}
			            
			            </c:if>
			            
			            
			            
                        <c:if test="${empty requestScope.getATCnt.notPayment}">
			            
                        	notPayment = 0;
			            
			            </c:if>
			        
                        <c:if test="${!empty requestScope.getATCnt.notPayment}">
			            
                        notPayment = ${requestScope.getATCnt.notPayment}
			            
			            </c:if>
			        
			            
			            
                        <c:if test="${empty requestScope.getATCnt.returnCnt}">
			            
                        	returnCnt = 0;
			            
			            </c:if>
			        
                        <c:if test="${!empty requestScope.getATCnt.returnCnt}">
			            
                        returnCnt =  ${requestScope.getATCnt.returnCnt}
			            
			            </c:if>
			       
			      	  <!-- ★★★★★★★★★★★★★★★★★★★★★★★★★ -->	    
				 	  <!--  보고 결재 받은 그래프  -->
					  <!-- ★★★★★★★★★★★★★★★★★★★★★★★★★ -->	
			        
						    google.charts.load("current", {packages:["corechart"]});
						    google.charts.setOnLoadCallback(drawChart);
						    function drawChart() {
						      var data = google.visualization.arrayToDataTable([
						        ["Element", "보고서 수", { role: "style" } ],
						        ["결재", payment, "#228b22"],
						        ["미결재",notPayment , "yellow"], // #767969
						        ["반려", returnCnt , "red"] // #086154
						      ]);
						
						      var view = new google.visualization.DataView(data);
						      view.setColumns([0, 1,
						                       { calc: "stringify",
						                         sourceColumn: 1,
						                         type: "string",
						                         role: "annotation" },
						                       2]);
						        
						      var options = {
						        title: "",
						        width: 415,
						        height: 300,
						        bar: {groupWidth: "30%"},
						        legend: { position: "none" },
						        chartArea : { width : "90%" , height : "90%" }
						      }; 
						      
						      console.log( "무엇일까요 ->",options );
						      var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
						      chart.draw(view, options);
						  }
						    
						    
						 
						 
						 
				    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■	 
					// 바디 태그 읽고 난 후 실행할 자스 코딩	    
				    //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					$(function(){
						
						$(".report_num").change(function(){
							
							var thisVal = $(this).val();
							
							var r_num = $(".r_num");
							
							r_num.val( thisVal );
							
							document.goReportKind.submit();
							
							
							
						})
						
						
						<c:if test="${!empty param.report_num}">
						
							$(".report_num").val( ${param.report_num} );
							
						
						</c:if>
						
						
                            $(".report_type").change(function(){
							
							
							
							document.goReportKind.submit();
							
							
							
						   })
						
						// 맨밑 차트 흔적 남기기    
						<c:if test="${!empty param.report_type}">
    						
							$(".report_type").val( ${param.report_type} );
							
						
						</c:if>
						
						// 공지사항 tr 마우스 hover 이벤트 
						$(".xxx").hover(
								
								function(){
									$(this).addClass("mouseOnTrBgC");
								}
								,	
								function(){
									$(this).removeClass("mouseOnTrBgC");
								}
							)
						
					})	    
					
					
					
					
						    
			 	 </script>		
         <script>
            $(function(){
                //로그아웃
            		$(".logoutBtn").click(
            			function(){
            				if( confirm("로그아웃 하시겠습니까?")==false ) { return; }
            				location.replace("/logout.do");
            		});
            });
            function goBoardDetailForm(b_no){
    			
    			//location.replace("/boardDetailForm.do?b_no="+b_no)
    			//alert(b_no); return;
                $("[name=boardDetailForm]  [name=b_no]").val(b_no);
    			
    			document.boardDetailForm.submit();
    		}
    			
            </script>
            <style>
                .hidden-col{display: none;}
                
                 .mouseOnTrBgC{background-color:pink;}
            </style> 
        
     


        </head>
        <body class="is-preload">
    
            <!-- Wrapper -->
                <div id="wrapper">
    			
                    <!-- Main -->
                        <div id="main">
                            <div class="inner">
                                <!-- Header -->
                                    <header id="header">
                                        <strong>Homepage</strong><span align="right">
                                        
                                        <strong>
                                        
                                        	<c:if test="${sessionScope.emp_name =='관리자'}">
                                        		${sessionScope.emp_name} 님
                                        	</c:if>
                                        
                                        	<c:if test="${sessionScope.emp_name !='관리자'}">
                                        		${sessionScope.emp_name} ${sessionScope.jikup_name}님
                                        	</c:if>
                                         
                                         
                                         
                                         </strong></span>
                                         
                                    </header>
    
                                <!-- Content -->                            

                                    <article class="article_content">
									<form name="loginForm" class="loginForm" method="post" action="/loginForm.do" ></form> 
									
                                    <article class="article1">
                                    <article class="box1">
                                    <b>공지사항</b> 
                                    <div style="height:10px;"></div>                                   
                                    <table class="boardList" name="boardList">
                                    	<tr style="background-color:#f56a6a">
                                       <th align="center">제목<th width="140" align="center">등록일
                                    	</tr>
                                    	<c:forEach var="board2" items="${requestScope.boardList}" varStatus="loopTagStatus">
													<tr style="cursor:pointer"
							                        onClick="goBoardDetailForm(${board2.b_no})"
													class="trline">
							                            <td class="hidden-col">${board2.b_no}
														<td>[공지] ${board2.subject}							
														<td>${board2.reg_date}
										</c:forEach>
                                    	
                                    	
                                    </table>
                                    
                                    <form name="boardDetailForm" method="post" action="/boardDetailForm.do">  
                                        <input type="hidden" name="selectPageNo"  class="selectPageNo" value="1">
                                        <input type="hidden" name="rowCntPerPage"  class="rowCntPerPage" value="10">
										<input type="hidden" name="b_no"  class="b_no">
									</form>
                             </article>	
                                    
                                    
                                    <!-- ------------------------------------------------------------------------------------ -->
                             <article class="box2">   
                             <b>부서별 사원 수</b> 
                             <div style="height:10px;"></div>   
                                 <div id="chart_div"  style="z-index:11;"></div>
								  </article>
								  </article>
								  
								  
								       
								  <article class="article2">
								  <article class="box3">
								  
								  
								  <form name="goReportKind" method="post" action="/main.do">
								  <b>보고 받은 결재 처리현황</b>
								  <select name="report_num" class="report_num">
								  		
								  		<option value="1" />일일
								  		<option value="2" />영업
								  		<option value="3" />지출
								  		
								  </select>
								   
							
								
								  
								  <input type="hidden" name="r_num"  class="r_num">
								  
						  		<div style="height:10px;"></div> 
						     
						     
						          <!-- 보고서 결재 수  -->
								  <div id="barchart_values"   style="z-index:11;"></div> 
								       
								        
								  	</article>	
								  		
								        
								       <article class="box4">
								       
								       
								       <c:if test="${requestScope.DeailyCnt.d_report == 1}"> 

                                      		<b>등록한 보고서 분야별 개수 그래프</b>

                                 		 </c:if>
                                  		<c:if test="${requestScope.SaleCnt.s_report == 2}"> 

                                     		 <b>등록한 보고서 방문 목적별 개수 그래프</b>

                                 		 </c:if>
                                  		<c:if test="${requestScope.ExCnt.e_report == 3}"> 

                                         	<b>등록한 보고서 지출 수단별 개수 그래프</b>

                                  		</c:if>
								       
								    

								      		
								      
								       <select name="report_type" class="report_type">
								  		
								  		<option value="1" />일일
								  		<option value="2" />영업
								  		<option value="3" />지출
								  		
								       </select>
								       
								        <div style="height:10px;"></div> 
								       
								       <div id="columnchart_values" style="width: 900px; height: 300px;"></div>
								       </article>
								       </article>
								       
								      
								       
							 </form>	
								</article>
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
  