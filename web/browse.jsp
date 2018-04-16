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
    java.sql.ResultSet vrs;
    java.sql.Statement st;
    java.sql.Statement vst;

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
        
        query = "SELECT title, body, username, posts.id, v1.vote_count " +
                "FROM forum_posts JOIN posts ON posts.id = forum_posts.post_id " +
                "JOIN users ON users.id = posts.user_id " +
                "LEFT JOIN (SELECT MAX(post_id) as post_id, SUM(vote) as vote_count FROM votes) v1 " +
                "ON forum_posts.post_id = v1.post_id " + 
                "WHERE forum_posts.forum_id ="+forum_id+";";
        
        rs = st.executeQuery(query);
        
        while(rs.next()) {

            String up_arrow = "<a href='vote?post_id=" + rs.getString(4) + "&count=1'>&#x25B2;</a>";
            String down_arrow = "<a href='vote?post_id=" + rs.getString(4) + "&count=-1'>&#x25BC;</a>";
                    
            if(session.getAttribute("uid") != null) {
        
                String v_query = "SELECT count(*), vote FROM votes WHERE user_id = " + session.getAttribute("uid").toString() + " AND post_id = " + rs.getString(4) + ";";
                
                out.println(v_query);
                
                vst = conn.createStatement();
                vrs = vst.executeQuery(v_query);
                
                if(vrs.next()) {
                
                   if(vrs.getInt(1) > 0) {
                   
                        if(vrs.getInt(2) == 1) {
                           up_arrow = "<a style='color: red;' href='vote?post_id=" + rs.getString(4) + "&count=-1&update=1'>&#x25B2;</a>";
                        }
                        
                        if(vrs.getInt(2) == -1) {
                            down_arrow = "<a style='color: red;' href='vote?post_id=" + rs.getString(4) + "&count=1&update=1'>&#x25BC;</a>";
                        }
                        
                        if(vrs.getInt(2) == 0) {
                            up_arrow = "<a href='vote?post_id=" + rs.getString(4) + "&count=1&update=1'>&#x25B2;</a>";
                            down_arrow = "<a href='vote?post_id=" + rs.getString(4) + "&count=-1&update=1'>&#x25BC;</a>";
                        }
                        
                        out.println("<div style='clear: left; overflow: auto;'>");
                        out.println("<div style='float: left;'>" + up_arrow + "<br />" + rs.getInt(5) + "<br />" + down_arrow + "</div>");
                        out.println("<div style='float: left;'>" + rs.getString(1)+" by "+ rs.getString(3) + "<br />" + rs.getString(2) + "</div>");
                        out.println("</div>");
                   
                   } else {
                       
                        out.println("<div style='clear: left; overflow: auto;'>");
                        out.println("<div style='float: left;'>" + up_arrow + "<br />" + rs.getInt(5) + "<br />" + down_arrow + "</div>");
                        out.println("<div style='float: left;'>" + rs.getString(1)+" by "+ rs.getString(3) + "<br />" + rs.getString(2) + "</div>");
                        out.println("</div>");
                   }
                    
                } else {
                    
                    out.println("<div style='clear: left; overflow: auto;'>");
                    out.println("<div style='float: left;'>" + up_arrow + "<br />" + rs.getInt(5) + "<br />" + down_arrow + "</div>");
                    out.println("<div style='float: left;'>" + rs.getString(1)+" by "+ rs.getString(3) + "<br />" + rs.getString(2) + "</div>");
                    out.println("</div>");
                    
                }
                
            } else {
                    
                out.println("<div style='clear: left; overflow: auto;'>");
                out.println("<div style='float: left;'>&#x25B2;<br />"+rs.getInt(5)+"<br />&#x25BC;</div>");
                out.println("<div style='float: left;'>" + rs.getString(1)+" by "+ rs.getString(3) + "<br />" + rs.getString(2) + "</div>");
                out.println("</div>");

            }
            
            out.println("<hr />");

        }   
        
        out.println("<div style='clear: left;'><a href='post.jsp?forum_id="+forum_id+"'>Post</a></div>");

    } catch (Exception dbException) {

        out.println("SQL Error: " + dbException.getMessage());

    }

    %> 
    
    </body>
    
</html>
