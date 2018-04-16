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
        <title>Creddit :: Subcreddit Posts</title>
    </head>
    <body>
        
    <%
    
    java.sql.Connection conn;
    java.sql.ResultSet rs;
    java.sql.Statement st;

    Class.forName("com.mysql.jdbc.Driver");
    
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");

    try {

        String forum_id = request.getParameter("forum_id");
        
        st = conn.createStatement();

        String query = "SELECT name FROM forums WHERE id="+forum_id+";";
        
        rs = st.executeQuery(query);
        
        if(rs.next()) {
            
            out.println("<h2>Posts in " + rs.getString(1) + "</h2>");
                    
        }
        
        query = "SELECT title, body, username, vote_count, posts.id FROM forum_posts JOIN posts ON posts.id = forum_posts.post_id JOIN users ON users.id = posts.user_id WHERE forum_posts.forum_id = "+forum_id+";";

        rs = st.executeQuery(query);

        while(rs.next()) {

            out.println("<div style='clear: left'>");
            out.println("<div style='float: left;'><a href='vote?post_id="+rs.getString(5)+"&count=1'>&#x25B2;</a><br />"+rs.getString(4)+"<br /><a href='vote?post_id="+rs.getString(5)+"&count=-1'>&#x25BC;</a></div>");
            out.println("<div style='float: left;'>" + rs.getString(1)+" by "+ rs.getString(3) + "<br />" + rs.getString(2) + "</div>");
            out.println("<div>");
            
        }   
        
        out.println("<div style='clear: left;'><a href='post.jsp?forum_id="+forum_id+"'>Post</a></div>");

    } catch (Exception dbException) {

        out.println("SQL Error: " + dbException.getMessage());

    }

    %> 
    
    </body>
    
</html>
