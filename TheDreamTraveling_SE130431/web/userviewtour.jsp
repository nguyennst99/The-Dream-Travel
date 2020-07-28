<%-- 
    Document   : userviewtour
    Created on : Jun 19, 2020, 12:09:12 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booked Tour</title>
    </head>
    <body>
        <%@include file="headerUser.jsp" %>
        <%@include file="menuUserdiscount.jsp" %>
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
        <c:if test="${not empty requestScope.LISTUSERBOOKED}">
            <table border="1">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Booking ID</th>
                        <th>User ID</th>
                        <th>Total Price</th>
                        <th>Discount</th>
                        <th>Order Date</th>
                        <th>Expiry Date</th>
                        <th>Status</th>
                        <th>Payment</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dto" items="${requestScope.LISTUSERBOOKED}" varStatus="counter">
                        <tr>
                            <th>${counter.count}</th>
                            <th>${dto.bookingID}</th>
                            <th>${dto.userID}</th>
                            <th>${dto.totalPrice} $</th>
                            <th>${dto.discountID}%</th>
                            <th>${dto.orderDateTime}</th>
                            <th>${dto.expiryDateTime}</th>                           
                            <th>
                                <c:if test="${dto.statusID == 2}">
                                    Expiry
                                </c:if>
                                <c:if test="${dto.statusID == 3}">
                                    Pending
                                </c:if>
                                <c:if test="${dto.statusID == 4}">
                                    Paid
                                </c:if>

                            </th>
                            <th>
                                <c:if test="${dto.statusID != 3}">
                                </c:if>

                                <c:if test="${dto.statusID == 3}">
                                    <form method="POST" action="${initParam['posturl']}">
                                        <input type="hidden" name="upload" value="1" />
                                        <input type="hidden" name="return" value="http://localhost:8080/TheDreamTraveling_SE130431/payment?txtBookingIDD=${dto.bookingID}" />
                                        <input type="hidden" name="cmd" value="_cart" />
                                        <input type="hidden" name="business" value="${initParam['business']}" />
                                        <input type="hidden" name="item_name_1" value="${dto.bookingID}" />
                                        <input type="hidden" name="amount_1" value="${dto.totalPrice}" />
                                        <input type="hidden" name="txtBookingIDD" value="${dto.bookingID}" />
                                        <input type="submit" value="Payment with Paypal" />
                                    </form>
                                </c:if>
                            </th>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </c:if>
        <c:if test="${empty requestScope.LISTUSERBOOKED}">
            <h1>
                <font color="green">
                You haven't booked any tour yet
                <br/><br/><br/><br/><br/>
                <br/><br/><br/><br/><br/>
                <br/><br/><br/><br/><br/><br/><br/><br/>
                <br/><br/><br/><br/><br/>
                <br/><br/><br/><br/>
                </font>
            </h1>
        </c:if>
    </center>
    <br/><br/><br/><br/><br/>
    <br/><br/><br/><br/><br/>
    <br/><br/><br/><br/><br/><br/><br/><br/>
    <br/><br/><br/><br/><br/>
    <br/><br/><br/><br/>
    <%@include file="footer.jsp" %>
</body>
</html>
