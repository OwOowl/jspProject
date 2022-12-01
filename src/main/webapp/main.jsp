<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-01
  Time: 오후 12:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.Calendar"%>
<%@ page import="java.sql.*" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
    request.setCharacterEncoding("utf-8");

    Calendar cal = Calendar.getInstance();

    // 시스템 오늘날짜
    int ty = cal.get(Calendar.YEAR);
    int tm = cal.get(Calendar.MONTH)+1;
    int td = cal.get(Calendar.DATE);

    int year = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH)+1;
    if(month < 10) {
        String months = "0" + Integer.toString(month);

    }
    else {
        month = month;
    }

    // 파라미터 받기
    String sy = request.getParameter("year");
    String sm = request.getParameter("month");

    if(sy!=null) { // 넘어온 파라미터가 있으면
        year = Integer.parseInt(sy);
    }
    if(sm!=null) {
        month = Integer.parseInt(sm);
    }

    cal.set(year, month-1, 1);
    year = cal.get(Calendar.YEAR);
    month = cal.get(Calendar.MONTH)+1;

    int week = cal.get(Calendar.DAY_OF_WEEK); // 1(일)~7(토)
%>

<html>
<head>
    <title><%String userName = (String)session.getAttribute("userName");
    String userId = (String)session.getAttribute("userId");
    out.print(userName + "의 가계부");%></title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>

    <script>
        $(document).ready(function () {
            let don = $('#asset').text();
            don = don.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            console.log(don);
            $('#asset').text(don);
        })
    </script>

    <style>
        table td:nth-child(7n+1){
            color: red;
        }
        table td:nth-child(7n){
            color: blue;
        }
        table td.today{
            font-weight:700;
            background: #E6FFFF;
        }
    </style>
</head>
<body>
<%@ include file="dbconn.jsp"%>

<%
    userId = (String)session.getAttribute("userId");
    String text1 = "";
    String text2 = "";


    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String months = "";
    if(month < 10) {
        months = "0" + month;
    }
    try {
        String sql = "SELECT text, flow_si, history_date, LEFT(history_date, 10) AS his_date FROM tblhistory WHERE user_id = ? AND history_date LIKE ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        if(month < 10) {
            pstmt.setString(2, "%" + year + "-" + months + "%");
        }
        else {
            pstmt.setString(2, "%" + year + "-" + month + "%");
        }
        rs = pstmt.executeQuery();
        while(rs.next()) {
            if(rs.getString("flow_si").equals("S")) {
                text1 += rs.getString("his_date") + "." + rs.getString("text") + "/";
            }
            else if(rs.getString("flow_si").equals("I")) {
                text2 += rs.getString("his_date") + "." + rs.getString("text") + "/";
            }
        }
    }
    catch (Exception e) {
        out.println("SQLException : " + e.getMessage());
    }

%>
<input type="hidden" name="sqlStr" value="<%=text1%>" id="sqlStr">
<div class="container">
    <div class="d-flex justify-content-center my-2">
        <a href="main.jsp?year=<%=year%>&month=<%=month-1%>" class="fs-1 text-decoration-none ms-auto">&lt;</a>
        <label class="fs-1 mx-3"><%=year%>년 <%=month%>월</label>
        <a href="main.jsp?year=<%=year%>&month=<%=month+1%>" class="fs-1 text-decoration-none me-auto">&gt;</a>
    </div>

    <table class="table table-bordered table-striped-columns">
        <thead>
        <tr class="text-center">
            <th>일</th>
            <th>월</th>
            <th>화</th>
            <th>수</th>
            <th>목</th>
            <th>금</th>
            <th>토</th>
        </tr>
        </thead>
        <tbody>
        <%
            request.setCharacterEncoding("utf-8");

            String date = year + "-" + month;
            // 1일 앞 달
            Calendar preCal = (Calendar)cal.clone();
            preCal.add(Calendar.DATE, -(week-1));
            int preDate = preCal.get(Calendar.DATE);

            out.print("<tr style='height: 120px; width: 120px'>");
            // 1일 앞 부분
            for(int i=1; i<week; i++) {
                out.print("<td class='text-muted'>"+(preDate++)+"</td>");
            }

            // 1일부터 말일까지 출력
            int lastDay = cal.getActualMaximum(Calendar.DATE);
            String cls;
            for(int i=1; i<=lastDay; i++) {
                cls = year==ty && month==tm && i==td ? "today":"";

                out.print("<td class='"+cls+" fw-bold'>"+i+"<a href='write.jsp?year=" + year + "&month=" + month + "&day=" + i + "&" +userId+ "' " +
                        "class='ms-2 pb-1 px-1 text-decoration-none border'>+</a></td>");
                if(lastDay != i && (++week)%7 == 1) {
                    out.print("</tr><tr style='height: 120px; width: 120px'>");
                }
            }

            // 마지막 주 마지막 일자 다음 처리
            int n = 1;
            for(int i = (week-1)%7; i<6; i++) {
                // out.print("<td>&nbsp;</td>");
                out.print("<td class='text-muted'>"+(n++)+"</td>");
            }
            out.print("</tr>");
        %>
        </tbody>
    </table>

    <div class="d-flex justify-content-center">

        <%
            int asset = 0;


            pstmt = null;
            rs = null;

            try {
                String sql = "SELECT money, flow_si FROM tblhistory WHERE user_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userId);
                rs = pstmt.executeQuery();
                while(rs.next()) {
                    if(rs.getString("flow_si").equals("S")) {
                        asset -= rs.getInt("money");
                    }
                    else if(rs.getString("flow_si").equals("I")) {
                        asset += rs.getInt("money");
                    }
                }
                out.print("<p class='fs-4'>이번달 남은 예산 :&nbsp;</p><p class='fs-4' id='asset'>" + asset + "</p><p class='fs-4'>원</p>");
            }
            catch (Exception e) {
                out.println("SQLException : " + e.getMessage());
            }
            finally {
                if(rs != null) { rs.close(); }
                if(pstmt != null) { pstmt.close(); }
                if(conn != null) { conn.close(); }
            }

        %>

    </div>
    <div class="d-flex justify-content-end">
        <a href="logout.jsp" class="btn btn-secondary me-auto">로그아웃</a>
        <a href="main.jsp" class="btn btn-primary me-2">오늘날짜로</a>
        <a href="detail.jsp" class="btn btn-dark">상세 내역</a>
    </div>
</div>

<footer class="container-fluid mt-5 p-5 border-top">
    <p class="lead text-muted text-center">made by bitc java 505</p>
</footer>
</body>
</html>
