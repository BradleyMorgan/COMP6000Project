<%-- 
    Document   : post
    Created on : Apr 15, 2018, 7:00:18 PM
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
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post a Message</title>
    </head>
    <body>
        <jsp:include page="/header.jsp"/>
        <h2>Post a Message</h2>
        
        <c:if test = "${sessionScope.uname == null}">
            <c:redirect url="login.jsp?b"/>
        </c:if>
        
        <sql:setDataSource var = "creddit_db" driver = "com.mysql.jdbc.Driver"
                           url = "jdbc:mysql://localhost/comp6000"
                           user = "comp6000"  password = "comp6000"/>
        
        <c:if test="${param.post_submit != null}">
            <sql:transaction dataSource="${creddit_db}">    
                <sql:update var = "resultingPost">
                    INSERT INTO posts (user_id, title, body) VALUES("${sessionScope.uid}", "${param.title}", "${param.body}");
                </sql:update>
                    
                <sql:update var = "resultingForumPost">
                    INSERT INTO forum_posts (forum_id, post_id) VALUES(${param.forum_id}, LAST_INSERT_ID());
                </sql:update>
            </sql:transaction>
            <c:redirect url="browse.jsp?forum_id=${param.forum_id}"/>
        </c:if>
                    
        <form action="post.jsp" method="POST">
            <fieldset>
                
                <legend>Post</legend>
                <input type='hidden' name='forum_id' value='${param.forum_id}'>
                <p>
                    <label for="title"><span>Title</span></label>
                    <input type="text" name="title">
                </p>          
                
                <p>
                    <label for="body"><span>Body</span></label>
                    <textarea name="body" cols="60" rows="12" ></textarea>
                </p>          
                
                <span class="button">
                    <input type="submit" name="post_submit" value="Submit Post">
                </span>
            </fieldset>
        </form>   
        <jsp:include page="/footer.jsp"/>
    </body>
</html>
