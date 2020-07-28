<%-- 
    Document   : viewcart
    Created on : Jun 10, 2020, 3:29:58 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart</title>
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


        <div style="padding: 20px; margin-left: 300px; text-align: left; width: 700px; height: 550px; background-color: #edecec; border: 1px solid #003333;">
            <c:if test="${not empty sessionScope}">
                <c:if test="${not empty sessionScope.CART.items}">
                    <form action="actionCart">

                        <table border="1">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Tour Name</th>
                                    <th>Amount</th>
                                    <th>Price</th>
                                    <th>From Date</th>
                                    <th>To Date</th>
                                    <th>Place</th>
                                    <th>Total</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="dto" items="${sessionScope.CART.items.values()}" varStatus="couter">
                                    <tr>
                                        <td>${couter.count}</td>
                                        <td>${dto.tourName}</td>
                                        <td>
                                            <input type="hidden" name="tourID" value="${dto.tourID}" />
                                            <input type="number" name="txtAmount" value="${dto.amount}" min="1"/>
                                        </td>
                                        <td>${dto.price}</td>
                                        <td>${dto.fromDate}</td>
                                        <td>${dto.toDate}</td>
                                        <td>${dto.place}</td>
                                        <td>${dto.amount * dto.price}</td>
                                        <td>
                                            <input type="checkbox" name="chkItem" value="${dto.tourID}" />
                                        </td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                        <br/>
                        <input type="submit" value="Remove" name="btAction" onclick="return confirm('Are you sure you want to delete this item?')" />
                        <input type="submit" value="Update" name="btAction" />
                    </form>
                    <br/>
                    <a href="user">Add more tours</a>
                    <br/><br/>
                    <form action="discount">
                        <input type="submit" value="Add a discount" />
                    </form>
                    <c:if test="${not empty sessionScope.DISCOUNTID}">
                        <c:if test="${sessionScope.DISCOUNTID != 0}">
                            <h4>
                                You get ${sessionScope.DISCOUNTID}% off.
                            </h4>

                        </c:if>
                    </c:if>
                    <br/><br/><br/>
                    <h3>
                        <font color="black">
                        Total amount of money of this cart: ${(sessionScope.CART.total)*(100 - sessionScope.DISCOUNTID)/100 }
                        </font>
                    </h3>
                    <center>
                        <form action="confirm">
                            <input type="hidden" name="UserIDConfirm" value="${sessionScope.USERID}" />
                            <input type="hidden" name="totalPriceConfirm" value="${(sessionScope.CART.total)*(100 - sessionScope.DISCOUNTID)/100}" />
                            <input type="hidden" name="discountIDConfirm" value="${sessionScope.DISCOUNTID}" />
                            <input type="submit" value="Confirm" />
                        </form>
                    </center>

                    <c:if test="${not empty requestScope.LISTINVALID}" >
                        <c:forEach var="invalid_dto" items="${requestScope.LISTINVALID}">
                            <h2>
                                <font color="green">
                                Sorry, Amount of tour ${invalid_dto.tourName} has only ${invalid_dto.amount}. :(
                                </font>
                            </h2>
                        </c:forEach>

                    </c:if>


                </c:if>

                <c:if test="${empty sessionScope.CART.items}">
                    <center>
                        <h1>
                            <font color="green">EMPTY CART</font><br/>

                        </h1>
                    </center>
                </c:if>



            </c:if>
        </div>

        <c:if test="${empty sessionScope}">
            <h2>
                <font color="green">No Cart is existed</font><br/><br/>
                <a href="user">
                    <button type="button">
                        HOME
                    </button>
                </a>
            </h2>
        </c:if>
        <br/><br/><br/>

        <%@include file="footer.jsp" %>
    </body>
</html>
