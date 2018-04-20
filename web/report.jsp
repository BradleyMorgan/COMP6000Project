<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "x" uri = "http://java.sun.com/jsp/jstl/xml" %>

<% if(request.getParameter("complete") != null) { %>
    
        <c:import url="xml/users.xml" var="xmlPath" />
        <c:import url="xml/users.xsl" var="xslPath" />
        <x:transform xml = "${xmlPath}" xslt = "${xslPath}"></x:transform>

<% } else { %>

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

<% } %>
