<%-- 
    Document   : db
    Created on : Apr 15, 2018, 5:13:32 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <%
    
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
        <title>Database Admin Tools</title>
    
    </head>
    
    <body>
    
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
