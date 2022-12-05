<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-01
  Time: 오전 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>

<%@ include file="dbconn.jsp"%>
<%-- 로그인 확인. 세션 --%>
<%
    request.setCharacterEncoding("utf-8");

    String userId = request.getParameter("userId");
    String userPwd = request.getParameter("userPwd");

    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        String sql ="SELECT user_name FROM tbluser WHERE user_id = ? AND user_pwd = ?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, userPwd);
        rs = pstmt.executeQuery();

        if(rs.next()) {
            String userName = rs.getString("user_name");
//            로그인 정보 세션 저장
            session.setAttribute("userName", userName);
            session.setAttribute("userId", userId);
            session.setAttribute("userPwd", userPwd);
            response.sendRedirect("main.jsp");
        }
        else {
            out.print("<script>alert('로그인 정보를 확인하세요');" +
                    "history.back();</script>");
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
