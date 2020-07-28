<%-- 
    Document   : user
    Created on : Jun 7, 2020, 6:16:22 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Dream Traveling</title>
        <style>
            .button {
                background-color: #4CAF50;
                border: none;
                color: white;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <%@include file="headerUser.jsp" %>
        <%@include file="menuUser.jsp" %>
        <div>
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
                <div style=" margin: 50px; text-align: left; width: 700px; height: 200px; background-color: #edecec; border: 1px solid #003333;">
                    <center>
                        <font color="green">
                        <h2 style="font-size: 20px">Where you want to go?</h2>
                        </font>
                        <form action="usersearch">
                            Place: <input type="text" name="txtPlace" value="${param.txtPlace}" /><br/>

                            Date From: <input type="date" name="txtDateFrom" value="${param.txtDateFrom}" required="" /> 
                            Date To: <input type="date" name="txtDateTo" value="${param.txtDateTo}" required=""/><br/>

                            Price Min: <input type="number" name="txtPriceMin" value="${param.txtPriceMin}" min="0" required="" /> 
                            Price Max: <input type="number" name="txtPriceMax" value="${param.txtPriceMax}" min="0" required="" /> ($)<br/>

                            <input type="hidden" name="txtPage" value="1" />
                            <button class="button">Search</button>
                        </form>
                    </center>
                </div>
            </center>




            <br/><br/><br/><br/><br/><br/><br/>

            <center>

                <c:if test="${not empty requestScope.LISTTOUR}">
                    <c:forEach var="dto" items="${requestScope.LISTTOUR}">
                        <div style="float: bottom;padding: 20px; margin: 30px; width: 1000px; min-height: 370px; background-color: #f4f1f1; border: 1px solid #999999">
                            <div style="float: left; margin-left: 90px;">
                                <h5>Tour Name: ${dto.tourName}</h5>
                                <h5>From Date: ${dto.fromDate}</h5>
                                <h5>To Date: ${dto.toDate}</h5>
                                <h5>Price: $${dto.price}/per</h5>
                                <h5>Place: ${dto.place}</h5>

                                <form action="addtocart">
                                    <input type="hidden" name="txtTourID" value="${dto.tourID}" />
                                    <input type="submit" value="Add to Cart" />
                                </form>

                            </div>

                            <div style="float: next; margin-left: 300px;" >
                                <img src="image/${dto.image}" width="600px" height="360px" alt=""/>
                            </div>
                        </div>
                    </c:forEach>  

                </c:if>
                <c:if test="${empty requestScope.LISTTOUR}">
                    <h2>
                        <font color="green">
                        No record is matched!!!!
                        </font>
                    </h2>
                </c:if>


            </center>


            <c:if test="${requestScope.PAGENUM > 1}">
                <c:forEach var="i" begin="1" end="${requestScope.PAGENUM}">
                    <div style="float: left; width: 20px">
                        <c:if test="${(param.txtPage) == i}">
                            <h2><a href="usersearch?txtPlace=${param.txtPlace}&txtDateFrom=${param.txtDateFrom}&txtDateTo=${param.txtDateTo}&txtPriceMin=${param.txtPriceMin}&txtPriceMax=${param.txtPriceMax}&txtPage=${i}">${i}</a></h2>
                            </c:if>
                            <c:if test="${(param.txtPage) != i}">
                            <h4><a href="usersearch?txtPlace=${param.txtPlace}&txtDateFrom=${param.txtDateFrom}&txtDateTo=${param.txtDateTo}&txtPriceMin=${param.txtPriceMin}&txtPriceMax=${param.txtPriceMax}&txtPage=${i}">${i}</a></h4>
                            </c:if>
                    </div>
                </c:forEach>
            </c:if>

            <br/>
            <br/>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
