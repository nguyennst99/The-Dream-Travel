<%-- 
    Document   : history
    Created on : Jun 18, 2020, 10:07:05 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History</title>
    </head>
    <body>
        <%@include file="headerAdmin.jsp" %>
        <%@include file="menuadminn.jsp" %>
        <h2>
            <font color="green">
            <h2 style="font-size: 20px">Welcome, ${sessionScope.NAME}</h2>       
            </font>
        </h2>
        <c:if test="${empty sessionScope}">
            <c:redirect url="Login"/>
        </c:if>

        <c:if test="${sessionScope.ROLE != 1}">
            <c:redirect url="Login" />
        </c:if>
    <center>
        <c:if test="${not empty requestScope.TOURHISTORY}">
            <table border="1">
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>User ID</th>
                        <th>Total Price</th>
                        <th>Discount</th>
                        <th>Order Date</th>
                        <th>Expiry Date</th>
                        <th>Status ID</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dto" items="${requestScope.TOURHISTORY}">
                        <tr>
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
                                    <form action="PaidTour">
                                        <input type="hidden" name="bookingIDD" value="${dto.bookingID}" />
                                        <input type="submit" value="Paid" />
                                    </form>
                                </c:if>
                            </th>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </c:if>

    </center>
    <br/><br/>
    <%@include file="footer.jsp" %>
</body>
</html>
