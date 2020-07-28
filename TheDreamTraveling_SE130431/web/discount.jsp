<%-- 
    Document   : discount
    Created on : Jun 11, 2020, 12:20:35 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Discount</title>
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

        <div style="padding: 20px; margin-left: 300px; text-align: left; width: 550px; height: 350px; background-color: #edecec; border: 1px solid #003333;">
            <center>
                <c:if test="${not empty sessionScope.LISTDISCOUNT}">

                    <table border="1">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>DiscountID</th>
                                <th>Discount</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${sessionScope.LISTDISCOUNT}" varStatus="counter">
                            <form action="useDiscount">
                                <tr> 
                                    <td>${counter.count}</td>
                                    <td>${dto.discountID}</td>                      
                                    <td>${dto.discount}</td>
                                    <c:if test="${dto.discountID != 0}">
                                        <td>
                                            <input type="hidden" name="UserID" value="${sessionScope.USERID}" />
                                            <input type="hidden" name="txtDiscountID" value="${dto.discountID}" />
                                            <input type="submit" value="Use now" />
                                        </td>
                                    </c:if>
                                    <c:if test="${dto.discountID == 0}">
                                        <td>
                                            <input type="hidden" name="UserID" value="${sessionScope.USERID}" />
                                            <input type="hidden" name="txtDiscountID" value="${dto.discountID}" />
                                            <input type="submit" value="Cancel discount" />
                                        </td>
                                    </c:if>
                                </tr>
                            </form>
                        </c:forEach>
                        </tbody>
                    </table>
                    <h2>
                        <font color="green">
                        ${requestScope.DISCOUNTEXISTED}
                        </font>
                    </h2>
                </c:if>
                <c:if test="${empty sessionScope.LISTDISCOUNT}">
                    <h2>
                        <font color="green">
                        No discount code
                        </font>
                    </h2>
                </c:if>
            </center>
        </div>
        <br/><br/><br/><br/><br/>
        <br/><br/><br/><br/><br/>
        <br/><br/><br/>
        <%@include file="footer.jsp" %>
    </body>
</html>
