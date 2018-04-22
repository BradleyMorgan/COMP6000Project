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
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="/header.jsp"/>
        <h2>Post a Message</h2>
        
        <%--
        <c:if test = "${sessionScope.uname == null}">
            <c:redirect url="login.jsp?b"/>
        </c:if>
        
        <sql:setDataSource var = "creddit_db" driver = "com.mysql.jdbc.Driver"
                           url = "jdbc:mysql://localhost/comp6000"
                           user = "comp6000"  password = "comp6000"/>
        
        <c:if test="${param.post_submit != null}">
            <sql:update dataSource = "${creddit_db}" var = "resultingPost">
                INSERT INTO posts (user_id, title, body) VALUES("${sessionScope.uid}", "${param.title}", "${param.body}");
            </sql:update>
                
            <sql:update dataSource = "${creddit_db}" var = "resultingForumPost">
                INSERT INTO forum_posts (forum_id, post_id) VALUES(${param.forum_id}, LAST_INSERT_ID());
            </sql:update>
                
            <c:redirect url="browse.jsp?forum_id=${param.forum_id}"/>
        </c:if>
        --%>

            
            <%    
            java.sql.Connection conn;
            java.sql.ResultSet rs;
            java.sql.Statement st;

            Class.forName("com.mysql.jdbc.Driver");
    
            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");
            
            String forum_id = request.getParameter("forum_id");
                   
            if(request.getParameter("post_submit") != null) {
           
            st = conn.createStatement();

            String user_id = session.getAttribute("uid").toString();
            String title = request.getParameter("title");
            String body = request.getParameter("body");
            
            String query = "INSERT INTO posts (user_id, title, body) VALUES('"+user_id+"','"+title+"','"+body+"');";

            st.executeUpdate(query);

            query = "INSERT INTO forum_posts (forum_id, post_id) VALUES ('"+forum_id+"',LAST_INSERT_ID());";
            
            st.executeUpdate(query);
            
            RequestDispatcher rd = request.getRequestDispatcher("browse.jsp?forum_id=" + forum_id);

            rd.forward(request,response);
            
            }

            %>
           
            
            <form action="post.jsp" method="POST">
            <fieldset>
                
                <legend>Post</legend>
                <input type='hidden' name='forum_id' value='${param.forum_id}'<%--<% out.println(forum_id); %>--%>>
                
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
        
    </body>
</html>
