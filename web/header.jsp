<%-- 
    Document   : header
    Created on : Apr 20, 2018, 10:15:32 PM
    Author     : Ian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css">
        <title>Creddit :: A COMP 6000 Web Application </title>
    </head>
    <body>
        <div><h1><span style='font-size: 46px; vertical-align: middle;'> &#x1F92F; </span> Creddit: A COMP 6000 Project</h1></div>
        <div class="menu"><a href="index.jsp">Home</a> | ${sessionScope.uname != null ? "<a href='logout'>Log Out</a>" : "<a href='login.jsp'>Log In</a>"} | <a href="register.jsp">Register</a> | <a href="db.jsp">New Subcreddit</a> | <a href="report.jsp">Reports</a></div>
    