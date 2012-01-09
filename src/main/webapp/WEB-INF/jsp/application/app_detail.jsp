<%-- 
    Document   : app_detail
    Created on : 09.01.2012, 10:12:13
    Author     : Aljona Murygina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<spring:url value='/css/main.css' />" />
        <title><spring:message code="title" /></title>
    </head>

    <body>

        <spring:url var="formUrlPrefix" value="/web/urlaubsverwaltung" />

        <%@include file="../include/header.jsp" %>

        <div id="content">

            <h2><spring:message code="app.title" /></h2>    

            <table>
                <tr>
                    <td>
                        <spring:message code="name" />:&nbsp;
                    </td>
                    <td>
                        <c:out value="${application.person.lastName}" />&nbsp;<c:out value="${application.person.firstName}" />
                    </td> 
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <spring:message code="app.apply" />
                    </td>
                    <td>
                        <spring:message code="${application.vacationType.vacationTypeName}" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <spring:message code="time" />
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${application.startDate == application.endDate}">
                                am&nbsp;<joda:format style="M-" value="${application.startDate}"/>
                            </c:when>
                            <c:otherwise>
                                <joda:format style="M-" value="${application.startDate}"/>&nbsp;-&nbsp;<joda:format style="M-" value="${application.endDate}"/>
                            </c:otherwise>    
                        </c:choose> 
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <label for="grund"><spring:message code='reason' />:</label>
                    </td>
                    <td>
                        <c:out value="${application.reason}" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="vertreter"><spring:message code='app.rep' />:</label> 
                    </td>
                    <td>
                        <c:out value="${application.rep}" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="anschrift"><spring:message code='app.address' />:</label>
                    </td>
                    <td colspan="4">
                        <c:out value="${application.address}" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="telefon"><spring:message code='app.phone' />:</label>
                    </td>
                    <td colspan="4">
                        <c:out value="${application.phone}" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <spring:message code='app.footer' />&nbsp;<joda:format style="M-" value="${application.applicationDate}"/>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
            </table>

            <sec:authorize access="hasRole('role.boss')">         

                <form:form method="put" action="${formUrlPrefix}/application/${application.id}/allow"> 
                    <input type="submit" name="<spring:message code='app.state.ok' />" value="<spring:message code='app.state.ok' />" class="button" />    
                </form:form>  

                <form:form method="put" action="${formUrlPrefix}/application/${application.id}/reject"> 
                    <input type="submit" name="<spring:message code='app.state.no' />" value="<spring:message code='app.state.no' />" class="button" />    
                </form:form>   

            </sec:authorize>

            <sec:authorize access="hasRole('role.office')">
                
                <a class="button" href="${formUrlPrefix}/application/${app.id}/print">Drucken</a>

            </sec:authorize>     

            <%--     
            
           <input type="button" name="<spring:message code='app.state.no' />" value="<spring:message code='app.state.no' />" onclick="$('#reason-reject').show(1000); return false;" />      
            
       <div id="reason-reject" style="display: none;">
           <spring:message code='reason' />&nbsp;<input type="text" />
       </div> 

            --%>

        </div>

    </body>

</html>