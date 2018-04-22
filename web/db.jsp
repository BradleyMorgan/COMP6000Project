<%-- 
    Document   : db
    Created on : Apr 15, 2018, 5:13:32 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- Added for JSTL SQL queries --%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>  
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>  


<!DOCTYPE html>
<html>
    <c:if test = "${sessionScope.uname == null}">
        <c:redirect url="login.jsp?b"/>
    </c:if>
    
    <sql:setDataSource var = "creddit_db" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://localhost/comp6000"
         user = "comp6000"  password = "comp6000"/>
    
    <c:if test="${param.forum_submit != null}">
        <sql:update dataSource = "${creddit_db}" var = "result">
         INSERT INTO forums (name) VALUES("${param.name}");
        </sql:update>
    </c:if>
         
         <head>
             <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
             <title>Add a Subcreddit</title>
         </head>
         <body>
             <jsp:include page="/header.jsp" />
             <h2>Create New Subcreddit</h2>
             
             <form action="db.jsp" method="POST">
                 <fieldset>
                     <legend>Add New Forum \ Subcreddit</legend>
                     
                     <p>
                         <label for="topic"><span>Name</span></label>
                         <input type="text" name="name">
                     </p>
                     
                     <span class="button">
                         <input type="submit" name="forum_submit" value="Add Forum">
                     </span>
                 
                 </fieldset>
             </form>
         </body>
</html>
