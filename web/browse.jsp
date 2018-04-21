<%-- 
    Document   : browse.js[
    Created on : Apr 15, 2018, 6:59:34 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Creddit :: Subcreddit Posts</title>
    </head>
    <body>
    
    <div><h1>&#x1F92F; Creddit: A COMP 6000 Project</h1></div>
    <div><a href="index.jsp">Home</a> | <%=(session.getAttribute("uid") != null ? "<a href='logout'>Log Out</a>" : "<a href='login.jsp'>Log In</a>")%> | <a href="register.jsp">Register</a> | <a href="db.jsp">New Subcreddit</a> | <a href="report.jsp">Reports</a></div>
    
    <jsp:include page="/voteOutput" />
        
    </body>
    
</html>
