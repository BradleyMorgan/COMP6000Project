<%-- 
    Document   : login.jsp
    Created on : 10-Apr-2017
    Author     : ian
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css">
        <title>Creddit :: Login</title>
    </head>
    
    <body>
        <jsp:include page="/header.jsp"/>
        <h2>Creddit Login</h2>
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
                            <td><input type="submit" value="Login" /></td>
                            <td>
                                <c:if test="${param.c != null}">
                                    Username or password is incorrect.
                                </c:if>
                                <c:if test="${param.b != null}">
                                    You must login to continue.
                                </c:if>
                            </td>
                        </tr>
                    </table>        
                </fieldset>        
            </form>
        </div>       
        <jsp:include page="/footer.jsp"/>
    </body>
</html>