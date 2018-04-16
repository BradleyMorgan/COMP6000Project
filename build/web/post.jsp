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
            <%
             
            java.sql.Connection conn;
            java.sql.ResultSet rs;
            java.sql.Statement st;

            Class.forName("com.mysql.jdbc.Driver");
    
            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");
            
            if(request.getParameter("post_submit") != null) {
           
            st = conn.createStatement();

            String author_id = session.getAttribute("userId");

            String query = "INSERT INTO posts (user_id, title, ) VALUES('"+topic_id+"','"+book_name+"','"+author_id+"','"+book_avail+"');";

            //out.println(query);
            
            st.executeUpdate(query);

        }


            %>
            <form action="db.jsp" method="POST">
            <fieldset>
                
                <legend>Post</legend>
                
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
