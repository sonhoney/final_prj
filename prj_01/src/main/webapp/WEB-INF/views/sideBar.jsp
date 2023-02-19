<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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
                <li><a href="/salesListForm.do">영업 보고서 결재</a></li>
                <li><a href="/expenseListForm.do">지출 보고서 결재</a></li>
            </ul>
        </li>
        <li><a href="/planList.do">일정관리</a></li>
        <li><a href="/meetingBoardList.do">회의실 예약</a></li>
        <li><a href="/boardList.do">공지사항</a></li>
        <li><a href="/mypageMain.do">마이페이지</a></li>
        <%		
            String emp_role = (String)session.getAttribute("emp_role");
               if(emp_role != null ){
                   if(emp_role.equals("admin")){%>
                  <li><a href="/empList.do">관리자페이지</a></li><%}}
        %>			
        
    </ul>
    <br><br><br><br><br><br><br>
                                        
		<input type="button" value="로그아웃" class="logoutBtn">
</nav>