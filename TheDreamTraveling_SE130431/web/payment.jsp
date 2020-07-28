<%-- 
    Document   : payment
    Created on : Jun 19, 2020, 10:21:18 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment</title>
    </head>
    <body>
        <%@include file="headerUser.jsp" %>
        <%@include file="menuUserviewcart.jsp" %>


        <h2>
            <font color="green">
            <h2 style="font-size: 20px">Welcome, ${sessionScope.NAME}</h2>       
            </font>
        </h2>
        <c:if test="${empty sessionScope}">
            <c:redirect url="Login"/>
        </c:if>


        <c:if test="${sessionScope.ROLE != 2}">
            <c:redirect url="Login" />
        </c:if>
    <center>
        <font color="green">
        <h2 style="font-size: 25px">Payment successfully!!! <br/>
            Thanks for choosing us!</h2>
        </font>
    </center>
    <br/><br/><br/><br/><br/>
    <br/><br/><br/>
    <br/><br/><br/><br/><br/>
    <br/><br/><br/>
    <br/><br/><br/><br/><br/>
    <br/><br/><br/>
    <%@include file="footer.jsp" %>
</body>
</html>
