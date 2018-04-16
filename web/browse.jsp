<%-- 
    Document   : browse.js[
    Created on : Apr 15, 2018, 6:59:34 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forum Posts</title>
    </head>
    <body>
        
                    <%
    
    java.sql.Connection conn;
    java.sql.ResultSet rs;
    java.sql.Statement st;

    Class.forName("com.mysql.jdbc.Driver");
    
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");

    try {

        st = conn.createStatement();

        String forum_id = request.getParameter("forum_id");
        String query = "SELECT title, body, username FROM forum_posts JOIN posts ON posts.id = forum_posts.post_id JOIN users ON users.id = posts.user_id WHERE forum_posts.forum_id = "+forum_id+";";

        //out.println(query);

        rs = st.executeQuery(query);

        while(rs.next()) {

            out.println(rs.getString(1)+" by "+ rs.getString(3) + "<br />" + rs.getString(2) + "<hr />");
        
        }   
        
        out.println("<a href='post.jsp?forum_id="+forum_id+"'>Post</a>");

    } catch (Exception dbException) {

        out.println("SQL Error: " + dbException.getMessage());

    }

    %>
       
    
    </body>
</html>
