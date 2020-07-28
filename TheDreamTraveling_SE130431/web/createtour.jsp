<%-- 
    Document   : createtour
    Created on : Jun 13, 2020, 9:50:25 PM
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
        <h2 style="font-size: 25px">Create New Tour</h2>
        <div style="padding: 20px; margin: 50px; text-align: left; width: 400px; min-height: 70px; background-color: #edecec; border: 1px solid #003333;">
            <form action="create" method="POST" enctype="multipart/form-data">
                Tour Name: <input type="text" name="txtTourNameInsert" value="" required="" /><br>
                Place: <input type="text" name="txtPlaceInsert" value="" required="" /><br/>
                From Date: <input type="date" name="txtFromDateInsert" value="" required="" /><br/>
                To Date: <input type="date" name="txtToDateInsert" value="" required="" /><br/>
                Price: <input type="number" name="txtPriceInsert" value="" required="" /><br/>
                Quota: <input type="number" name="txtQuotaInsert" value="" required="" /><br/>
                Image: <input type="file" name="txtImageInsert" value="" required="" /> <br/>
                (Maximum size for new files: 10MB) 
                <br/>
                <font color="red">
                <h3>
                    ${requestScope.MAXSIZE}
                    ${requestScope.DATE}
                </h3>
                </font>
                <br/>
                <input type="submit" value="Create " />

            </form>
        </div>
    </center>
    <br/><br/><br/><br/><br/>
    <br/><br/><br/>
    <%@include file="footer.jsp" %>
</body>
</html>
