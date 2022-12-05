<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-01
  Time: 오후 9:47
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
        $(document).ready(function() {
            let td = $('tbody tr').find('td:last').length;
            console.log(td);

            for(let i = 0; i < td; i++) {
                let money = $('tbody tr').find('td:last').eq(i).text();
                money = money.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                $('tbody tr').find('td:last').eq(i).text(money + '\t원');
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
            <h1 class="text-center">수입내역 상세 페이지</h1>
        </div>
    </div>
</header>
<%
    request.setCharacterEncoding("utf-8");

    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String date = year + "-" + month;
%>
<main class="container mt-4">
    <form action="detail_income2.jsp" method="post" class="row">
        <div class="d-flex justify-content-center my-3">
            <h5><%=year%>년 <%=month%>월 수입 내역</h5>
        </div>
        <div class="col-sm-6 my-3">
            <div class="form-floating ms-auto" style="width: 200px">
                <input type="number" class="form-control" id="year" name="year" value="<%=year%>" max="2099" min="2010">
                <label for="year" class="form-label">년도</label>
            </div>
        </div>
        <div class="col-sm-2 my-3">
            <div class="form-floating " style="width: 200px">
                <input type="number" class="form-control" id="month" name="month" value="<%=month%>" max="12" min="1">
                <label for="month" class="form-label">월</label>
            </div>
        </div>
        <div class="col-sm-4 my-3">
            <button class="btn btn-outline-primary h-100 pt-2" type="submit">검색</button>
        </div>
        <div class="col-sm-12">
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
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        String sql = "select flow_si, history_date, text, money from tblhistory where user_id = ? AND flow_si = 'I' ";

                        if(!year.trim().equals("")) {
                            if(month.length() == 0) {
                                sql += "AND history_date LIKE '%" + year + "%' ";
                            }
                            else if(month.length() == 1) {
                                date = year + "-0" + month;
                                sql += "AND history_date LIKE '%" + date + "%' ";
                            }
                            else if(month.length() == 2) {
                                sql += "AND history_date LIKE '%" + date + "%' ";
                            }
                        }
                        else if(year.trim().equals("")) {
                            if(month.length() == 1) {
                                date = year + "-0" + month;
                                sql += "AND history_date LIKE '%" + date + "%' ";
                            }
                            else if(month.length() == 2) {
                                sql += "AND history_date LIKE '%" + date + "%' ";
                            }
                        } else if ((year.trim().equals("") && month.trim().equals(""))) {
                            sql += "AND history_date LIKE '%" + year + "%' ";
                        }

                        sql += " ORDER BY history_date DESC";
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
                <a href="detail.jsp" class="btn btn-secondary me-2">뒤로</a>
                <a href="main.jsp" class="btn btn-outline-secondary">가계부 돌아가기</a>
            </div>
        </div>
    </form>
</main>

<footer class="container-fluid mt-5 p-5 border-top">
    <p class="lead text-muted text-center">made by bitc java 505</p>
</footer>
</body>
</html>
