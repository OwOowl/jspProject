<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-01
  Time: 오전 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>

    <script>
        function chk() {

        }
        $(document).ready(function () {
            $('#btn-back').on('click', function() {
                history.back();
            });

            $('#btn-sign').on('click', function() {

            });
        });
    </script>
</head>
<body>
<header>
    <div class="p-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-4">
            <h1 class="text-center">회원가입 페이지</h1>
        </div>
    </div>
</header>

<main class="container">
    <div class="row">
        <div class="col-sm-6 mx-auto">
            <form action="signup_process.jsp" method="post" class="border rounded-3 p-4">
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="user-id" name="userId" placeholder="ID을 입력하세요">
                    <label for="user-id" class="form-label">ID</label>
                </div>
                <div class="form-floating my-3">
                    <input type="password" class="form-control" id="user-pwd" name="userPwd" placeholder="비밀번호를 입력하세요">
                    <label for="user-pwd" class="form-label">비밀번호</label>
                </div>
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="user-name" name="userName" placeholder="이름을 입력하세요">
                    <label for="user-name" class="form-label">이름</label>
                </div>
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="user-email" name="userEmail" placeholder="이메일을 입력하세요">
                    <label for="user-email" class="form-label">이메일</label>
                </div>
                <div class="d-grid gap-2">
                    <button class="btn btn-primary" type="submit" id="btn-sign">회원가입</button>
                    <button class="btn btn-secondary" type="button" id="btn-back">돌아가기</button>
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
