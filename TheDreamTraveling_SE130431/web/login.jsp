<%-- 
    Document   : login
    Created on : Jun 7, 2020, 11:22:40 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="menuLogin.jsp" %> <br/><br/>
    <center>
        <div style="padding: 20px; margin: 50px; text-align: left; width: 300px; height: 200px; background-color: #edecec; border: 1px solid #003333;">
            <form action="login" method="POST">
                UserID: <input type="text" name="txtUserId" value="${param.txtUserId}" />
                <font color="red">
                ${requestScope.FAIL.userIDError}
                </font><br/>
                Password: <input type="password" name="txtPassword" value="" />
                <font color="red">
                ${requestScope.FAIL.passwordError}
                </font><br/>
                <input type="submit" value="Login" />
                <input type="reset" value="Reset" />
            </form>

            <br/>

            <script>

                function statusChangeCallback(response) {  // Called with the results from FB.getLoginStatus().
                    console.log('statusChangeCallback');
                    console.log(response);                   // The current login status of the person.
                    if (response.status === 'connected') {   // Logged into your webpage and Facebook.
                        testAPI();
                    }
                }


                function checkLoginState() {               // Called when a person is finished with the Login Button.
                    FB.getLoginStatus(function (response) {   // See the onlogin handler
                        statusChangeCallback(response);
                    });
                }


                window.fbAsyncInit = function () {
                    FB.init({
                        appId: '686899098757730',
                        xfbml: true, // Parse social plugins on this webpage.
                        version: 'v7.0'           // Use this Graph API version for this call.
                    });


                    FB.getLoginStatus(function (response) {   // Called after the JS SDK has been initialized.
                        statusChangeCallback(response);        // Returns the login status.
                    });
                };


                (function (d, s, id) {                      // Load the SDK asynchronously
                    var js, fjs = d.getElementsByTagName(s)[0];
                    if (d.getElementById(id))
                        return;
                    js = d.createElement(s);
                    js.id = id;
                    js.src = "https://connect.facebook.net/en_US/sdk.js";
                    fjs.parentNode.insertBefore(js, fjs);
                }(document, 'script', 'facebook-jssdk'));


                function testAPI() {                      // Testing Graph API after login.  See statusChangeCallback() for when this call is made.
                    FB.api('/me', {fields: 'name, email'}, function (response) {
                        window.location.href = 'LoginFB?name=' + response.name + '&email=' + response.email + '&id=' + response.id;
                    });
                }

            </script>

            Login via Facebook

            <fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
            </fb:login-button>

            <div id="status">
            </div>

            <font color="red">
            <h2>
                ${requestScope.ERRORFB}
            </h2>
            </font>           
        </div>
    </center>
    <br/><br/><br/><br/><br/>
    <br/><br/><br/><br/><br/><br/>
    <br/><br/><br/><br/><br/><br/><br/>
    <%@include file="footer.jsp" %>
</body>
</html>
