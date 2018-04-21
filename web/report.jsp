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
        
        <jsp:include page="/header.jsp"/>
    
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
