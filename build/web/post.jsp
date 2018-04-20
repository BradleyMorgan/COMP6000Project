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
        
        <div><h1>&#x1F92F; Creddit: A COMP 6000 Project</h1></div>
        <div><a href="index.jsp">Home</a> | <%=(session.getAttribute("uid") != null ? "<a href='logout'>Log Out</a>" : "<a href='login.jsp'>Log In</a>")%> | <a href="register.jsp">Register</a> | <a href="db.jsp">New Subcreddit</a></div>
        <h2>Post a Message</h2>
        <c:if test = "${username == null}">
            <c:redirect url="login.jsp?c"/>
        </c:if>
        

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
                <input type='hidden' name='forum_id' value='<% out.println(forum_id); %>'>
                
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
