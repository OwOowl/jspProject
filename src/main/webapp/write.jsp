<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-01
  Time: 오후 4:44
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
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");

    int year = Integer.parseInt(request.getParameter("year"));
    int month = Integer.parseInt(request.getParameter("month"));
    int day = Integer.parseInt(request.getParameter("day"));
    String date = year + "-" + month + "-" + day;
%>

<header>
    <div class="p-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-4">
            <h1 class="text-center">가계부 작성 페이지</h1>
        </div>
    </div>
</header>

<main class="container">
    <div class="row">
        <div class="col-sm-6 mx-auto">
            <form action="write_process.jsp" method="post" class="border rounded-3 p-4">
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="date" name="date" value="<%=date%>" readonly>
                    <label for="date" class="form-label">날짜</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="flowSi" id="income" value="income">입금
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="flowSi" id="spending" value="spending" checked>출금
                </div>
                <div class="form-check">
                </div>
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="money" name="money">
                    <label for="money" class="form-label">금액</label>
                </div>
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="text" name="text">
                    <label for="text" class="form-label">사용내역</label>
                </div>
                <div class="d-flex justify-content-end">
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
