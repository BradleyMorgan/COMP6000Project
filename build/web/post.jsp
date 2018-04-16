<%-- 
    Document   : post
    Created on : Apr 15, 2018, 7:00:18 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <h2>Post in </h2>
            <%
             
            java.sql.Connection conn;
            java.sql.ResultSet rs;
            java.sql.Statement st;

            Class.forName("com.mysql.jdbc.Driver");
    
            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");
            
            String forum_id = request.getParameter("forum_id");
                   
            if(request.getParameter("post_submit") != null) {
           
            st = conn.createStatement();

            //String user_id = session.getAttribute("userId").toString();
            String user_id = "1";
            String title = request.getParameter("title");
            String body = request.getParameter("body");
            
            String query = "INSERT INTO posts (user_id, title, body) VALUES('"+user_id+"','"+title+"','"+body+"');";

            out.println(query);
            
            st.executeUpdate(query);

            query = "INSERT INTO forum_posts (forum_id, post_id) VALUES ('"+forum_id+"',LAST_INSERT_ID());";
            
            out.println(query);
            
            st.executeUpdate(query);
            
            }

            %>
            
            <form action="post.jsp" method="POST">
            <fieldset>
                
                <legend>Post</legend>
                <input type='hidden' name='forum_id' value='<% out.println(forum_id); %>'>
                
                <p>
                    <label for="title"><span>Title</span></label>
                    <input type="text" name="title">
                </p>          
                
                <p>
                    <label for="body"><span>Body</span></label>
                    <input type="text" name="body">
                </p>          
                
                
                <span class="button">
                    <input type="submit" name="post_submit" value="Submit Post">
                </span>

            </fieldset>
        </form>     
        
    </body>
</html>
