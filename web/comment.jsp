<%-- 
    Document   : comment
    Created on : Apr 23, 2018, 3:39:38 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <jsp:include page="/header.jsp"/>
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
                
        <jsp:include page="/commentOutput" />
        <jsp:include page="/footer.jsp"/>
        
    </body>
</html>
