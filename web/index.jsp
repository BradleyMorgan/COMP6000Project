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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Creddit :: A COMP 6000 Web Application </title>
    </head>
    <body>
    <div><h1>&#x1F92F; Creddit: A COMP 6000 Project</h1></div> 
    <div><a href="index.jsp">Home</a> | ${sessionScope.uname != null ? "<a href='logout'>Log Out</a>" : "<a href='login.jsp'>Log In</a>"} | <a href="register.jsp">Register</a> | <a href="db.jsp">New Subcreddit</a></div>
    <c:choose>
        <c:when test = "${sessionScope.uname != null}">
            <h2>Welcome to Creddit, ${sessionScope.uname} </h2>
         </c:when>
         <c:otherwise>
            <h2>Welcome to Creddit</h2>
         </c:otherwise>
      </c:choose> 
            <h3>Choose a Subcreddit</h3>
            
            <sql:setDataSource var = "creddit_db" driver = "com.mysql.jdbc.Driver"
                               url = "jdbc:mysql://localhost/comp6000"
                               user = "comp6000"  password = "comp6000"/>

            <sql:query dataSource = "${creddit_db}" var = "result">
                SELECT * FROM forums;
            </sql:query>
            
                <c:choose>
                    <c:when test = "${result == null}">
                        <h4>No Subcreddits Available</h4>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var = "row" items = "${result.rows}">
                            <p>
                                <a href="browse.jsp?forum_id='${row.id}'">${row.name}</a><br/>
                            </p>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
    </body>    
</html>

    <%--
    Not sure about how to implement this into JSLT yet.
    
    } catch (Exception dbException) {

        out.println("SQL Error: " + dbException.getMessage());

    }

    %>
    --%>
       