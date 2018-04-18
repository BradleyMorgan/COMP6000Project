<%-- 
    Document   : report.jsp
    Created on : Apr 18, 2018, 1:54:17 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Creddit :: Administrative Reports </title>
    </head>

    <body>
    
    <div><h1>&#x1F92F; Creddit: A COMP 6000 Project</h1></div>
    
    <div><a href="index.jsp">Home</a> | <%=(session.getAttribute("uid") != null ? "<a href='logout.jsp'>Log Out</a>" : "<a href='login.jsp'>Log In</a>")%> | <a href="user.jsp">Register</a> | <a href="db.jsp">New Subcreddit</a></div>
    
    <%            
        
        if(session.getAttribute("uid") == null) {

            response.sendRedirect("login.jsp?err=1");
            
        } 

    %>
    
    <form action="genreport" method="POST">
        
        <input type="submit" name="submit" value="Generate Report">
        
    </form>

    
    </body>

</html>
