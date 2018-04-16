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
        String query = "SELECT * FROM forum_posts WHERE forum_id = "+forum_id+";";

        //out.println(query);

        rs = st.executeQuery(query);

        while(rs.next()) {

            out.println(rs.getString(4)+"<br />");
        }

    } catch (Exception dbException) {

        out.println("SQL Error: " + dbException.getMessage());

    }

    %>
       
    
    </body>
</html>
