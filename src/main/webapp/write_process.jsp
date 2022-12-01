<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-01
  Time: 오후 5:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%@ include file="dbconn.jsp"%>

<%
        request.setCharacterEncoding("utf-8");

        String userId = (String)session.getAttribute("userId");
        String historyDate = request.getParameter("date");
        String flowSi = request.getParameter("flowSi");
        String text = request.getParameter("text");
        int money = Integer.parseInt(request.getParameter("money"));

        if(flowSi.equals("income")) {
                flowSi = "I";
        }
        else if(flowSi.equals("spending")) {
                flowSi = "S";
        }
        PreparedStatement pstmt = null;
        try {
                String sql = "INSERT INTO tblhistory (user_id, flow_si, text, money, history_date) VALUES(?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userId);
                pstmt.setString(2, flowSi);
                pstmt.setString(3, text);
                pstmt.setInt(4, money);
                pstmt.setString(5, historyDate);
                pstmt.executeUpdate();
                response.sendRedirect("main.jsp");
        }
        catch (Exception e) {
                out.println("SQLException : " + e.getMessage());
        }
        finally {
                if(pstmt != null) { pstmt.close(); }
                if(conn != null) { conn.close(); }
        }

%>
