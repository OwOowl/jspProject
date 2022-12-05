<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-01
  Time: 오전 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<head>
    <title>로그인</title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>

    <%@ include file="dbconn.jsp"%>

    <%
        request.setCharacterEncoding("utf-8");

        String userId = request.getParameter("userId").trim();
        String userPwd = request.getParameter("userPwd").trim();
        String userName = request.getParameter("userName").trim();
        String userEmail = request.getParameter("userEmail").trim();

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT user_id FROM tbluser WHERE user_id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if(rs.next()){
                out.print("<script>alert('중복된 아이디입니다.');" +
                        "history.back();</script>");
            }
            else if(userId.equals("") || userPwd.equals("") || userName.equals("") || userEmail.equals("")) {
                out.print("<script>alert('빈칸을 모두 입력해 주세요.');" +
                        "history.back();</script>");
            }
            else {
                out.print("<script>alert('회원가입 완료');" +
                        "history.go(-2)</script>");
                sql ="INSERT INTO tbluser(user_id, user_pwd, user_name, user_email) VALUES(?, ?, ?, ?)";

                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userId);
                pstmt.setString(2, userPwd);
                pstmt.setString(3, userName);
                pstmt.setString(4, userEmail);
                pstmt.executeUpdate();

//                response.sendRedirect("login.jsp");
            }

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
</head>
<body>
</body>
</html>

