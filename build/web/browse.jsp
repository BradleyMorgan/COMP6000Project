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
    
    <div><h1>&#x1F92F; Creddit: A COMP 6000 Project</h1></div>
    <div><a href="index.jsp">Home</a> | <%=(session.getAttribute("uid") != null ? "<a href='logout'>Log Out</a>" : "<a href='login.jsp'>Log In</a>")%> | <a href="register.jsp">Register</a> | <a href="db.jsp">New Subcreddit</a></div>
    
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
        
        String forum_name = "";
                
        if(rs.next()) {
        
            forum_name = rs.getString(1);
            
            out.println("<h2>Posts in " + forum_name + "</h2>");
                    
        }
                    
        query = "SELECT title, body, username, posts.id, v1.vote_count, DATE_FORMAT(posts.timestamp, '%b. %D at %H:%i') as formatted_date " +
                "FROM forum_posts JOIN posts ON posts.id = forum_posts.post_id " +
                "JOIN users ON users.id = posts.user_id " +
                "LEFT JOIN (SELECT MAX(post_id) as post_id, SUM(vote) as vote_count FROM votes GROUP BY(post_id)) v1 " +
                "ON forum_posts.post_id = v1.post_id " + 
                "WHERE forum_posts.forum_id ="+forum_id+";";

        rs = st.executeQuery(query);
        
        if (!rs.next()) {
            
            out.println("<h3>No Posts in " + forum_name + "</h3>");
            
        } else {
        
            rs.beforeFirst();

            while(rs.next()) {

                String up_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id+"&count=1'>&#x25B2;</a>";
                String down_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id+"&count=-1'>&#x25BC;</a>";

                if(session.getAttribute("uid") != null) {

                    String v_query = "SELECT count(*), vote FROM votes WHERE user_id = " + session.getAttribute("uid").toString() + " AND post_id = " + rs.getString(4) + ";";

                    vst = conn.createStatement();
                    vrs = vst.executeQuery(v_query);

                    if(vrs.next()) {

                       if(vrs.getInt(1) > 0) {

                            if(vrs.getInt(2) == 1) {
                               //up_arrow = "<a style='color: red;' href='vote?post_id=" + rs.getString(4) + "&count=-1&update=1'>&#x25B2;</a>";
                               up_arrow = "<span style='color: red'>&#x25B2</span>";
                               down_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id + "&count=-1&update=1'>&#x25BC;</a>";
                            }

                            if(vrs.getInt(2) == -1) {
                                up_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id + "&count=1&update=1'>&#x25B2;</a>";
                                //down_arrow = "<a style='color: red;' href='vote?post_id=" + rs.getString(4) + "&count=1&update=1'>&#x25BC;</a>";
                                down_arrow = "<span style='color: red'>&#x25BC;</span>";
                            }

                            if(vrs.getInt(2) == 0) {
                                up_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id + "&count=1&update=1'>&#x25B2;</a>";
                                down_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id + "&count=-1&update=1'>&#x25BC;</a>";
                            }

                            out.println("<div style='clear: left; overflow: auto;'>");
                            out.println("<div style='float: left; margin-right: 18px; text-align: center;'>" + up_arrow + "<br />" + rs.getInt(5) + "<br />" + down_arrow + "</div>");

                       } else {

                            out.println("<div style='clear: left; overflow: auto;'>");
                            out.println("<div style='float: left; margin-right: 18px; text-align: center;'>" + up_arrow + "<br />" + rs.getInt(5) + "<br />" + down_arrow + "</div>");
                       }

                    } else {

                        out.println("<div style='clear: left; overflow: auto;'>");
                        out.println("<div style='float: left; margin-right: 18px; text-align: center;'>" + up_arrow + "<br />" + rs.getInt(5) + "<br />" + down_arrow + "</div>");

                    }

                } else {

                    out.println("<div style='clear: left; overflow: auto;'>");
                    out.println("<div style='float: left; margin-right: 18px; text-align: center;'>&#x25B2;<br />"+rs.getInt(5)+"<br />&#x25BC;</div>");


                }

                java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");

                out.println("<div style='float: left;'><b>" + rs.getString(1)+"</b><br />Posted by "+ rs.getString(3) + " on " + rs.getString(6) + "<br />" + rs.getString(2) + "</div>");
                out.println("</div>");
                out.println("<hr />");

            }
        
        }
        
        out.println("<div style='clear: left;'><a href='post.jsp?forum_id="+forum_id+"'>Post</a></div>");

    } catch (Exception dbException) {

        out.println("SQL Error: " + dbException.getMessage());

    }

    %> 
    
    </body>
    
</html>
