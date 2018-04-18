<%-- 
    Document   : db
    Created on : Apr 15, 2018, 5:13:32 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    
    <%
    
    if(session.getAttribute("uid") == null) {

        RequestDispatcher rd = request.getRequestDispatcher("login.jsp?c");

        rd.forward(request,response);

    }
                             
    java.sql.Connection conn;
    java.sql.ResultSet rs;
    java.sql.Statement st;

    Class.forName("com.mysql.jdbc.Driver");
    
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");
    
    if(request.getParameter("forum_submit") != null) {

        st = conn.createStatement();

        String name = request.getParameter("name");

        String query = "INSERT INTO forums (name) VALUES('"+name+"');";

        out.println(query);

        st.executeUpdate(query);

    }
        
    %>
    
    <head>
    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Test</title>
    
    </head>
    
    <body>
    
        <div><h1>&#x1F92F; Creddit: A COMP 6000 Project</h1></div>
        <div><a href="index.jsp">Home</a> | <%=(session.getAttribute("uid") != null ? "<a href='logout.jsp'>Log Out</a>" : "<a href='login.jsp'>Log In</a>")%> | <a href="user.jsp">Register</a> | <a href="db.jsp">New Subcreddit</a></div>
        <h2>Create New Subcreddit</h2>
        
        <form action="db.jsp" method="POST">
            <fieldset>
                
                <legend>Add New Forum \ Subcreddit</legend>
                
                <p>
                    <label for="topic"><span>Name</span></label>
                    <input type="text" name="name">
                </p>          
                
                <span class="button">
                    <input type="submit" name="forum_submit" value="Add Forum">
                </span>

            </fieldset>
        </form>     
        
    </body>
    
</html>
