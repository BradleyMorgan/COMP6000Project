<%-- 
    Document   : user
    Created on : Apr 15, 2018, 7:45:39 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>User Registration</title>
        
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
                    document.getElementById("msg").innerHTML="Password and confirm password must match!";
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
                    document.getElementById("msg").innerHTML="Numbers are not allowed for last name!";
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
                    document.getElementById("msg").innerHTML="Numbers are not allowed for first name!";
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
        
        <div><h1>&#x1F92F; Creddit: A COMP 6000 Project</h1></div>
        <div><a href="index.jsp">Home</a> | <a href="login.jsp">Login</a> | <a href="user.jsp">Register</a> | <a href="db.jsp">New Subcreddit</a></div>
        <h2>User Registration</h2>
        
        <form name="signupform" method="POST" action="signupprocess.jsp" onSubmit="return validate()">           <!-- On submit, the page will be redirected to signupprocess.jsp -->
            
            <fieldset>
                
                <legend>User Registration</legend>
            
                <table>
                
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" name="username" /></td>                  <!-- name: username -->
                    </tr>
                    <tr>
                        <td>Email Address:</td>
                        <td><input type="text" name="email" /></td>                 <!-- name: firstname -->
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
                        
            </fieldset>
                    
        </form>
                       
    </body>
    
</html>
