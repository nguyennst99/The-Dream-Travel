<%-- 
    Document   : confirm
    Created on : Jun 12, 2020, 12:32:01 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirm Tour</title>
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


        <div style="padding: 20px; margin-left: 400px; text-align: left; width: 550px; height: 350px; background-color: #edecec; border: 1px solid #003333;">
            <center>
                <c:if test="${not empty requestScope.INVOICE}">
                    <h2 style="font-size: 25px">INVOICE</h2>
                    <form method="POST" action="${initParam['posturl']}">
                        <input type="hidden" name="upload" value="1" />
                        <input type="hidden" name="return" value="http://localhost:8080/TheDreamTraveling_SE130431/payment?txtBookingIDD=${requestScope.INVOICE.bookingID}" />
                        <input type="hidden" name="cmd" value="_cart" />
                        <input type="hidden" name="business" value="${initParam['business']}" />

                        <input type="hidden" name="item_name_1" value="${requestScope.INVOICE.bookingID}" />
                        <input type="hidden" name="amount_1" value="${requestScope.INVOICE.totalPrice}" />

                        Booking ID: ${requestScope.INVOICE.bookingID} <br/>
                        Total Price: ${requestScope.INVOICE.totalPrice}<br/>
                        User ID:  ${requestScope.INVOICE.userID}<br/>
                        Discount Code: ${requestScope.INVOICE.discountID}<br/>
                        Order Date:  ${requestScope.INVOICE.orderDateTime}<br/>
                        Expiry Date: ${requestScope.INVOICE.expiryDateTime}<br/>

                        <input type="submit" value="Payment with Paypal" />
                    </form>
                </c:if>
            </center>
        </div>

        <br/><br/><br/><br/><br/><br/><br/><br/>
        <br/><br/><br/><br/><br/>
        <%@include file="footer.jsp" %>
    </body>
</html>
