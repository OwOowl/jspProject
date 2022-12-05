<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-05
  Time: 오후 9:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("utf-8");

    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String date = year + "-" + month + "-" + day;
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
        $(document).ready(function() {
            $('#btn-back').on('click', function() {
                history.back();
            });

            let td = $('tbody tr').find('td:nth-child(4)').length;
            for(let i = 0; i < td; i++) {
                let money = $('tbody tr').find('td:nth-child(4)').eq(i).text();
                money = money.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                $('tbody tr').find('td:nth-child(4)').eq(i).text(money + '\t원');
                console.log(money);
            }
        });
    </script>

    <style>
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
    </style>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<header>
    <div class="p-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-4">
            <h1 class="text-center"><%=year%>년 <%=month%>월 <%=day%>일 내역</h1>
        </div>
    </div>
</header>
<main class="container mt-4">
    <form action="update.jsp" method="post" class="row">
        <div class="col-sm-12">
            <table class="table table-hover table-striped">
                <thead class="text-center">
                <tr>
                    <th>수입/지출</th>
                    <th>입금일</th>
                    <th>내역</th>
                    <th>금액</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
                </thead>
                <tbody class="text-center">

                <%
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        String sql = "select flow_si, history_date, text, money, idx from tblhistory where user_id = ? AND history_date = ? ";
                        sql += " ORDER BY history_date DESC";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, userId);
                        pstmt.setString(2, date);
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
                            int idx = rs.getInt("idx");
                %>
                <tr>
                    <td><%=flow%></td>
                    <td><%=historyDate%></td>
                    <td><%=text%></td>
                    <td><%=money%></td>
                    <td><a href="update.jsp?idx=<%=idx%>" class="text-decoration-none text-warning">수정</a></td>
                    <td><a href="delete_process.jsp?idx=<%=idx%>" class="text-decoration-none text-danger">삭제</a></td>
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
                <a class="btn btn-secondary" id="btn-back">뒤로</a>
            </div>
        </div>
    </form>
</main>

<footer class="container-fluid mt-5 p-5 border-top">
    <p class="lead text-muted text-center">made by bitc java 505</p>
</footer>
</body>
</html>

