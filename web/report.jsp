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
        
        <c:if test = "${sessionScope.uname == null}">
            <c:redirect url="login.jsp?b"/>
        </c:if>

                <form action="genreport" method="POST" target="_blank">
                    <fieldset>
                        <legend>User Activity Report</legend>
                        <c:choose>
                            <c:when test="${sessionScope.admin eq '0'}">
                                <h3>Administrative access is required for reporting. Please log in with an administrator account.</h3>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" name="submit" value="Generate Report">
                            </c:otherwise>
                        </c:choose>
                    </fieldset>
                </form>
        
        <jsp:include page="/footer.jsp"/>
    
    </body>
    
</html>

<% } %>
