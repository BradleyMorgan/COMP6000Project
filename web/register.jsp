<%-- 
    Document   : user
    Created on : Apr 15, 2018, 7:45:39 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Creddit User Registration</title>
        
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

                if(document.signupform.password.value === '')
                {
                    document.getElementById("msg").innerHTML="Enter Password";
                    str=false;
                }

                if(document.signupform.username.value === '')
                {
                    document.getElementById("msg").innerHTML="Enter Username";
                    str=false;
                }
                
                if(document.signupform.email.value === '')
                {
                    document.getElementById("msg").innerHTML="Enter Email Address";
                    str=false;
                }

                if (str == false){
      
                    if(event.preventDefault) {
                        event.preventDefault();
                    } else {
                        event.returnValue = false;
                    }

                }
    
                return str; 
                
            }
        
        </script>
        
    </head>

    <body>
        
        <jsp:include page="/header.jsp"/>
        
        <h2>Creddit User Registration</h2>
        
        <form name="signupform" method="POST" action="registrationProcess.jsp" onSubmit="return validate()">
            <fieldset>
                <legend>Account Information</legend>
                <table>
                
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" name="username" /></td>
                    </tr>
                    <tr>
                        <td>Email Address:</td>
                        <td><input type="text" name="email" /></td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password" name="password" /></td>
                    </tr>
                    <tr>
                        <td>Confirm Password:</td>
                        <td><input type="password" name="confirm" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" name="signup" value="Sign up" /></td>
                        <td>
                            <span id="msg"> </span>
                            
                            <c:if test="${param.a != null}">
                                Username already exists.
                            </c:if>
                                
                        </td>                      
                    </tr>
                </table>
            </fieldset>         
        </form>               
        <jsp:include page="/footer.jsp"/>
    </body>
</html>
