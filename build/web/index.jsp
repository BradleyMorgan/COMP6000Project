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
    
    <div><h1>&#x1F92F; Creddit: A COMP 6000 Project</h1></div>
    
    <div><a href="index.jsp">Home</a> | <%=(session.getAttribute("uid") != null ? "<a href='logout'>Log Out</a>" : "<a href='login.jsp'>Log In</a>")%> | <a href="register.jsp">Register</a> | <a href="db.jsp">New Subcreddit</a></div>
    
    <%            
        
        if(session.getAttribute("uid") != null) {

            out.println("<h2>Welcome to Creddit, " + session.getAttribute("uname").toString() + "</h2>");

        } else {
            
            out.println("<h2>Welcome to Creddit</h2>");
            
        }

    %>
    
    
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

        if(!rs.next()) {
        
            out.println("<h4>No Subcreddits Available</h4>");
            
        } else {
        
            rs.beforeFirst();
            
            while(rs.next()) {

                out.println("<a href='browse.jsp?forum_id="+rs.getString(1)+"'>"+rs.getString(2)+"</a><br />");
            }
            
        }

    } catch (Exception dbException) {

        out.println("SQL Error: " + dbException.getMessage());

    }

    %>
       
        
    </body>
    
</html>
