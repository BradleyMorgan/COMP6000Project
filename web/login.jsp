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
        <title>Library Login or Register</title>
        <script type="text/javascript">
        function validate() {
            // javascript code to validate user input 
            var str=true;
            document.getElementById("msg").innerHTML="";                    
            
            pwd = document.signupform.password.value;
            cpwd = document.signupform.confirm.value;
            
            
            if(pwd == cpwd) {
                
            }
            else {
                document.getElementById("msg").innerHTML="Password and confirm password must match.!";
                str=false;
            }
            
            if(document.signupform.password.value == '')
            {
                document.getElementById("msg").innerHTML="Enter Password";
                str=false;
            }
            
            if(document.signupform.username.value == '')
            {
                document.getElementById("msg").innerHTML="Enter Username";
                str=false;
            }
            
            lastname = document.signupform.lastname.value;
            if(isNaN(lastname))
            {
            }
            else
            {
                document.getElementById("msg").innerHTML="Numbers are not allowed for last name.!";
                str=false;
            }
            
            if(document.signupform.lastname.value == '')
            {
                document.getElementById("msg").innerHTML="Enter Lastname";
                str=false;
            }
            
            firstname = document.signupform.firstname.value;
            if(isNaN(firstname))
            {
            }
            else
            {
                document.getElementById("msg").innerHTML="Numbers are not allowed for first name.!";
                str=false;
            }
        
            if(document.signupform.firstname.value == '')
            {
                document.getElementById("msg").innerHTML="Enter Firstname";
                str=false;
            } 
        return str;       
        }
        </script>
    </head>
    <body>
        <%
            String isUserLoggedIn = (String) session.getAttribute("uname");
            if (isUserLoggedIn == null)
            {
        %>
        <div class="back">
            <div class="logo">
                <a href="index.jsp"><label style=" font-size: 35px;color: #ffffff; margin-left:50px; ">Library Catalog</label></a>
            </div>
            <div class="menu1">
                <ul> 
                    <li><a href="login.jsp">Login</a> </li>  
                    <li><a href="login.jsp">Register</a></li> 
                </ul>
            </div>
        </div>
        <%} else {%>
        <div class="logo">
            <a href="index.jsp"><label style=" font-size: 35px;color: #ffffff; margin-left:50px; ">Library Catalog</label></a>
        </div>        
        <div class="back">
            <div class="menu1">
                <ul>
                    <li><a href="logout.jsp">LogOut </a></li>
                </ul>
            </div>
        </div>
        <%}%>
        <br/><br/><br/>
        
        <div>
            <form name="loginform" method="POST" action="loginprocess.jsp">            <!-- On submit, the page will be redirected to loginprocess.jsp -->
                <table border="0" cellpadding="5" align="center" width = "800px">
                    <tr>
                        <td colspan="2"><h3>Login</h3></td>
                    </tr>
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
            </form>
            
            
            <form name="signupform" method="POST" action="signupprocess.jsp" onSubmit="return validate()">           <!-- On submit, the page will be redirected to signupprocess.jsp -->
                <table border="0" cellpadding="5" align="center" width = "800px">
                    <tr>
                        <td colspan="2"><h3>Register</h3></td>
                    </tr>
                    
                    <tr>
                        <td>First Name:</td>
                        <td><input type="text" name="firstname"  /></td>                 <!-- name: firstname -->
                    </tr>
                    
                    <tr>
                        <td>Last Name:</td>
                        <td><input type="text" name="lastname" /></td>                   <!-- name: lastname -->
                    </tr>
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" name="username" /></td>                  <!-- name: username -->
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password" name="password" /></td>              <!-- name: password -->
                    </tr>
                    <tr>
                        <td>Confirm Password:</td>
                        <td><input type="password" name="confirm" /></td>               <!-- name: confirm -->
                    </tr>
                    <tr>
                        <td><input type="submit" name="signup" value="Sign up" /></td>
                        <td>
                            <span id="msg"> </span>                                     <!-- span tag to print validation errors -->
                            <%
                                if(request.getParameter("a")!= null) {
                                    //check the value for variable "a"
                                    out.println("Username already exists..! Please login to continue.!");
                                }
                                
                                if(request.getParameter("b")!= null) {
                                    //check the value for variable "b"
                                    out.println("You must login to continue.!");
                                }
                            %>
                        </td>                      

                    </tr>
                </table>
            </form>
           
        </div>          
    </body>
</html>