<%-- 
    Document   : login.jsp
    Created on : 10-Apr-2017
    Author     : ian
--%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.PreparedStatement"%>

<!DOCTYPE html>

<html>

    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/header.css" rel="stylesheet" type="text/css">
        <title>Creddit :: Login</title>
    
    </head>
    
    <body>

        <h1>Creddit Login</h1>
        <div><a href="index.jsp">Home</a> | <a href="login.jsp">Login</a> | <a href="user.jsp">Register</a> | <a href="db.jsp">New Subcreddit</a></div>
        
        <div>
            
            <form name="loginform" method="POST" action="loginprocess.jsp">            <!-- On submit, the page will be redirected to loginprocess.jsp -->
                
                <fieldset>
                    
                    <legend>Login</legend>
                    
                    <table>
                        
                        <tr>
                            <td>Username:</td>
                            <td><input type="text" name="username" required /></td>                  <!-- name: username -->
                        </tr>
                        
                        <tr>
                            <td>Password:</td>
                            <td><input type="password" name="password" required/></td>               <!-- name: password -->
                        </tr>
                        
                        <tr>
                            <td><input type="submit" value="Login" /> </td>
                            <td>
                                <%
                                    if(request.getParameter("c")!= null) {
                                        //check the value for variable "c"
                                        out.println("Username or password is incorrect.!");
                                    }
                                %>
                            </td>
                        </tr>
                        
                    </table>
                            
                </fieldset>
                        
            </form>
           
        </div>    
                        
    </body>
    
</html>