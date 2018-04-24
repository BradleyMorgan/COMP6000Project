<%-- 
    Document   : comment
    Created on : Apr 23, 2018, 3:39:38 PM
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
    <jsp:include page="/header.jsp"/>
    <h2>Comments</h2>
        <c:choose>
            <c:when test="${sessionScope.uname == null}">    
                <h4>Please <a href='login.jsp'>log in</a> to add comments.</h4>
            </c:when>
                <c:otherwise>
                    <form action="comment" method="POST">
                        <fieldset>

                            <legend>Add Comment</legend>
                            <input type='hidden' name='post_id' value='${param.post_id}'>
                            <input type='hidden' name='forum_id' value='${param.forum_id}'>
                                <textarea name="body" cols="60" rows="8" ></textarea>
                                <br />
                            <span class="button">
                                <input type="submit" name="comment_submit" value="Submit Comment">
                            </span>
                        </fieldset>
                    </form>   
                </c:otherwise>
        </c:choose>
        <jsp:include page="/commentOutput" />
        <jsp:include page="/footer.jsp"/>
    </body>
</html>
