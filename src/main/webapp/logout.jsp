<%--
  Created by IntelliJ IDEA.
  User: yang
  Date: 2022-12-01
  Time: 오후 1:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    session.removeAttribute("userName");
    response.sendRedirect("login.jsp");
%>
