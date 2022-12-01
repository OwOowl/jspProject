<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2022-10-28
  Time: 오전 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>

<%
    Connection conn = null;

    String url = "jdbc:mysql://localhost:3306/javadb";
    String user = "test1";
    String passwd = "java505";

    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, user, passwd);

%>