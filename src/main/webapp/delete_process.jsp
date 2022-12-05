<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-05
  Time: 오후 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%@ include file="dbconn.jsp"%>

<%
    request.setCharacterEncoding("utf-8");

    int idx = Integer.parseInt(request.getParameter("idx"));

    PreparedStatement pstmt = null;
    try{
        String sql = "DELETE FROM tblhistory WHERE idx = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idx);
        pstmt.executeUpdate();
    }
    catch (Exception e) {
        out.println("SQLException : " + e.getMessage());
    }
    finally {
        if(pstmt != null) { pstmt.close(); }
        if(conn != null) { conn.close(); }
    }
    response.sendRedirect("main.jsp");
%>
