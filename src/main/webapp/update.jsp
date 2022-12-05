<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-05
  Time: 오후 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%@ include file="dbconn.jsp"%>
<%
    request.setCharacterEncoding("utf-8");

    String date = "";
    int money = 0;
    String text = "";
    String flowSi = "";
    int idx = Integer.parseInt(request.getParameter("idx"));

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String sql = "SELECT flow_si, text, money, history_date FROM tblhistory where idx = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idx);
        rs = pstmt.executeQuery();

        if(rs.next()) {
            date = rs.getString("history_date");
            date = date.substring(0, 10);
            text = rs.getString("text");
            money = rs.getInt("money");
            flowSi = rs.getString("flow_si");
        }
    }
    catch (Exception e) {
        out.print(e.getMessage());
    }
    finally {
        if(rs != null) { rs.close(); }
        if(pstmt != null) { pstmt.close(); }
        if(conn != null) { conn.close(); }
    }
%>

<header>
    <div class="p-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-4">
            <h1 class="text-center">내용 수정 페이지</h1>
        </div>
    </div>
</header>

<main class="container">
    <div class="row">
        <div class="col-sm-6 mx-auto">
            <form action="update_process.jsp" method="post" class="border rounded-3 p-4">
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="date" name="date" value="<%=date%>">
                    <label for="date" class="form-label">날짜</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="flowSi" id="income" value="income">수입
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="flowSi" id="spending" value="spending">지출
                </div>
                <div class="form-check">
                </div>
                <div class="form-floating my-3">
                    <input type="number" class="form-control" id="money" name="money" value="<%=money%>">
                    <label for="money" class="form-label">금액</label>
                </div>
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="text" name="text" value="<%=text%>">
                    <label for="text" class="form-label">사용내역</label>
                </div>
                <div class="d-flex justify-content-end">
                    <input type="hidden" name="idx" value="<%=idx%>" id="idx">
                    <button class="btn btn-primary me-2" type="submit">확인</button>
                    <a class="btn btn-secondary" id="btn-back">뒤로</a>
                </div>
            </form>
        </div>
    </div>
</main>

<footer class="container-fluid mt-5 p-5 border-top">
    <p class="lead text-muted text-center">made by bitc java 505</p>
</footer>
</body>
</html>

