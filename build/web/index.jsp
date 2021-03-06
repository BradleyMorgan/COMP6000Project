<%-- 
    Document   : index
    Created on : Apr 15, 2018, 5:12:27 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Added for JSTL SQL queries --%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>  
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>  

<jsp:include page="/header.jsp"/>

    <c:choose>
        <c:when test = "${sessionScope.uname != null}">
            <h2>Welcome to Creddit, ${sessionScope.uname}. </h2>
        </c:when>
        <c:otherwise>
            <h2>Welcome to Creddit</h2>
        </c:otherwise>
    </c:choose>

    <p>Creddit is a web content aggregation, crowdsourcing, and discussion web application that allows users to post, comment, and vote on content.<br />You can browse existing subcreddits, or log in or register to contribute new content.</p>
    <hr />
    <h3>Choose a Subcreddit</h3>

    <%
        
    if(request.getParameter("err") != null) {
        
        out.println("<p class='error'>An error occurred. Please try the operation again.</p>");
        
    }

    %>
    <sql:setDataSource var = "creddit_db" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/comp6000" user = "comp6000"  password = "comp6000"/>

    <sql:query dataSource = "${creddit_db}" var = "result">SELECT * FROM forums;</sql:query>

    <c:choose>
        <c:when test = "${result.rowCount == 0 || result == null}">
            <h4>No Subcreddits Available. Log in or Register to create one!</h4>
        </c:when>
        <c:otherwise>
            <ul>
                <c:forEach var = "row" items = "${result.rows}">
                    <li><a href="browse.jsp?forum_id=${row.id}">${row.name}</a><br/></li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>

    <jsp:include page="/footer.jsp"/>

       