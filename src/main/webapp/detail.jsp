<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-01
  Time: 오후 8:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
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
            let date = new Date();
            let month = date.getMonth() + 1;
            let year = date.getFullYear();

            $('#year1').attr('value', year);
            $('#year2').attr('value', year);
            $('#year3').attr('value', year);
            $('#month1').attr('value', month);
            $('#month2').attr('value', month);
            $('#month3').attr('value', month);

            let td = $('tbody tr').find('td:last').length;
            console.log(td);

            for(let i = 0; i < td; i++) {
                let money = $('tbody tr').find('td:last').eq(i).text();
                money = money.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                $('tbody tr').find('td:last').eq(i).text(money + '\t원');
                console.log(money);
            }

        })
    </script>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<header>
    <div class="p-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-4">
            <h1 class="text-center">수입/지출 내역 페이지</h1>
        </div>
    </div>
</header>

<main class="container mt-4">
    <form action="detail_spending.jsp" method="post" class="row">
        <div class="d-flex justify-content-center my-2">
            <h5>지출 내역</h5>
        </div>
        <div class="col-sm">
            <table class="table table-hover table-striped">
                <thead class="text-center">
                <tr>
                    <th>수입/지출</th>
                    <th>지출일</th>
                    <th>내역</th>
                    <th>금액</th>
                </tr>
                </thead>
                <tbody class="text-center">
                <%
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        String sql = "select flow_si, history_date, text, money from tblhistory where user_id = ? AND flow_si = 'S' " +
                                "ORDER BY history_date DESC LIMIT 10;";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, userId);
                        rs = pstmt.executeQuery();

                        while(rs.next()) {
                            String flow = rs.getString("flow_si");
                            if (flow.equals("S")) {
                                flow = "지출";
                            }
                            else if (flow.equals("I")) {
                                flow = "수입";
                            }
                            String historyDate = rs.getString("history_date");
                            historyDate = historyDate.substring(0, 10);
                            String text = rs.getString("text");
                            int money = rs.getInt("money");
                %>
                <tr>
                    <td><%=flow%></td>
                    <td><%=historyDate%></td>
                    <td><%=text%></td>
                    <td><%=money%></td>
                </tr>
                <%
                        }
                    }
                    catch (SQLException e) {
                        out.println("SQLException : " + e.getMessage());
                    }
                %>
                </tbody>
            </table>
            <div class="d-flex justify-content-end">
                <input type="hidden" name="year" value="" id="year1">
                <input type="hidden" name="month" value="" id="month1">
                <button class="btn btn-outline-primary" type="submit">지출 내역 더보기</button>
            </div>
        </div>
    </form>

    <form action="detail_income.jsp" method="post" class="row mt-5" id="frm">
        <div class="d-flex justify-content-center my-2">
            <h5>수입 내역</h5>
        </div>
        <div class="col-sm">
            <table class="table table-hover table-striped">
                <thead class="text-center">
                <tr>
                    <th>수입/지출</th>
                    <th>입금일</th>
                    <th>내역</th>
                    <th>금액</th>
                </tr>
                </thead>
                <tbody class="text-center">

                <%
                    pstmt = null;
                    rs = null;
                    try {
                        String sql = "select flow_si, history_date, text, money from tblhistory where user_id = ? AND flow_si = 'I' " +
                                "ORDER BY history_date DESC LIMIT 10;";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, userId);
                        rs = pstmt.executeQuery();

                        while(rs.next()) {
                            String flow = rs.getString("flow_si");
                            if (flow.equals("S")) {
                                flow = "지출";
                            }
                            else if (flow.equals("I")) {
                                flow = "수입";
                            }
                            String historyDate = rs.getString("history_date");
                            historyDate = historyDate.substring(0, 10);
                            String text = rs.getString("text");
                            int money = rs.getInt("money");
                %>
                <tr>
                    <td><%=flow%></td>
                    <td><%=historyDate%></td>
                    <td><%=text%></td>
                    <td><%=money%></td>
                </tr>
                <%
                        }
                    }
                    catch (SQLException e) {
                        out.println("SQLException : " + e.getMessage());
                    }
                    finally {
                        if(rs != null) { rs.close(); }
                        if(pstmt != null) { pstmt.close(); }
                        if(conn != null) { conn.close(); }
                    }
                %>
                </tbody>
            </table>
            <div class="d-flex justify-content-end">
                <input type="hidden" name="year" value="" id="year2">
                <input type="hidden" name="month" value="" id="month2">
                <a href="main.jsp" class="btn btn-outline-secondary me-auto">가계부 돌아가기</a>
                <button class="btn btn-outline-primary" type="submit" id="income">수입 내역 더보기</button>
            </div>
        </div>
    </form>
    <form action="detail_all.jsp" class="d-flex justify-content-end mt-0" method="post">
        <input type="hidden" name="year" value="" id="year3">
        <input type="hidden" name="month" value="" id="month3">
        <button class="btn btn-outline-success" type="submit" id="all">전체 내역 더보기</button>
    </form>
</main>

<footer class="container-fluid mt-5 p-5 border-top">
    <p class="lead text-muted text-center">made by bitc java 505</p>
</footer>
</body>
</html>
