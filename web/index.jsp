<%-- 
    Document   : index
    Created on : Apr 15, 2018, 5:12:27 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Creddit :: A COMP 6000 Web Application </title>
    </head>
    <body>
    
    <h1>Welcome to Creddit</h1>
    
    <h3>Choose a Subcreddit</h3>
    
    <%
    
    java.sql.Connection conn;
    java.sql.ResultSet rs;
    java.sql.Statement st;

    Class.forName("com.mysql.jdbc.Driver");
    
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");

    try {

        st = conn.createStatement();

        String query = "SELECT * FROM forums;";

        //out.println(query);

        rs = st.executeQuery(query);

        while(rs.next()) {

            out.println("<a href='browse.jsp?forum_id="+rs.getString(1)+"'>"+rs.getString(2)+"</a><br />");
        }

    } catch (Exception dbException) {

        out.println("SQL Error: " + dbException.getMessage());

    }

    %>
       
        
    </body>
</html>
