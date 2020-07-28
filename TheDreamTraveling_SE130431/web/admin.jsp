<%-- 
    Document   : admin
    Created on : Jun 7, 2020, 6:18:31 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Dream Traveling</title>
    </head>
    <body>
        <%@include file="headerAdmin.jsp" %>
        <%@include file="menuAdmin.jsp" %>
        <div>

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

            <br/><br/>


            <br/><br/><br/><br/><br/>

            <center>
                <c:if test="${not empty requestScope.LISTTOURADMIN}">
                    <c:forEach var="dto" items="${requestScope.LISTTOURADMIN}">
                        <div style="float: bottom;padding: 20px; margin: 30px; width: 1000px; min-height: 370px; background-color: #f4f1f1; border: 1px solid #999999">
                            <div style="float: left; margin-left: 90px;">
                                <h5>Tour Name: ${dto.tourName}</h5>
                                <h5>From Date: ${dto.fromDate}</h5>
                                <h5>To Date: ${dto.toDate}</h5>
                                <h5>Price: ${dto.price} $</h5>                
                                <h5>Place: ${dto.place}</h5>
                                <c:if test="${(dto.status) == 1}">
                                    <h5>Status: Active</h5>
                                </c:if>
                                <c:if test="${(dto.status) == 2}">
                                    <h5>Status: Expiry</h5>
                                </c:if>
                                <h5>Amount: ${dto.amount}</h5>
                                <h5>Date Import: ${dto.dateImport}</h5>
                            </div>

                            <div style="float: next; margin-left: 300px;" >
                                <img src="image/${dto.image}" width="600px" height="360px" alt=""/>
                            </div>

                        </div>
                    </c:forEach>  
                </c:if>
                <c:if test="${empty requestScope.LISTTOURADMIN}">
                    <h2>
                        <font color="green">
                        No record is matched!!!!
                        </font>
                    </h2>
                </c:if>
            </center>
            <c:if test="${requestScope.PAGENUMADMIN > 1}">
                <c:forEach var="i" begin="1" end="${requestScope.PAGENUMADMIN}">
                    <div style="float: left; width: 20px">
                        <c:if test="${(param.txtPage) == i}">
                            <h2><a href="adminshowtour?txtPage=${i}">${i}</a></h2>
                            </c:if>
                            <c:if test="${(param.txtPage) != i}">
                            <h4><a href="adminshowtour?txtPage=${i}">${i}</a></h4>
                            </c:if>
                    </div>
                </c:forEach>
            </c:if>
        </div>
                
                
        <%@include file="footer.jsp" %>
    </body>
</html>
