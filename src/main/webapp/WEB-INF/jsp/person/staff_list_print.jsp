<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
    <title><spring:message code="title"/></title>
    <%@include file="../include/header.jsp" %>
</head>

<body>

<spring:url var="formUrlPrefix" value="/web"/>

    <div class="container_12" style="margin-top: 1em">

        <a class="btn" href="${formUrlPrefix}/staff">
            <i class="icon-arrow-left"></i>&nbsp;<spring:message code="back" />
        </a>

        <a class="btn btn-right" href="#" media="print" onclick="window.print(); return false;">
            <i class="icon-print"></i>&nbsp;<spring:message code='table.staff.list' />&nbsp;<spring:message code='print' />
        </a>

        <div class="btn-group year-selector" style="float:right; margin-left: 0.5em;">

            <button class="btn dropdown-toggle" data-toggle="dropdown">
                <spring:message code="ov.header.year" />&nbsp;<span class="caret"></span>
            </button>

            <ul class="dropdown-menu">

                <script type="text/javascript">
                    $(document).ready(function () {

                        var href = window.location.href;
                        
                        var year = ${year};

                        var nextYear = year + 1;
                        var nextYearHref = href.replace(/(year=)[^\&]+/, '$1' + nextYear);

                        $("div.year-selector ul.dropdown-menu").append(
                                '<li><a href="' + nextYearHref + '">' + nextYear + '</a></li>'
                        );

                        for (var i = 0; i <= 10; i++) {

                            var pastYear = year - i;
                            var pastYearHref = href.replace(/(year=)[^\&]+/, '$1' + pastYear);

                            $("div.year-selector ul.dropdown-menu").append(
                                    '<li><a href="' + pastYearHref + '">' + pastYear + '</a></li>'
                            );

                        }

                    });
                </script>

            </ul>

        </div>

        <div class="btn-group status-selector" style="float:right">

            <script type="text/javascript">
                $(document).ready(function() {
                    
                    var active = getUrlParam("active");
                    
                    if(active === "true") {
                        $("div.status-selector button").html('<spring:message code="table.active" />&nbsp;<span class="caret"></span>');
                    } else {
                        $("div.status-selector button").html('<spring:message code="table.inactive" />&nbsp;<span class="caret"></span>')
                    }

                    var href = window.location.href;

                    var activeHref = href.replace(/(active=)[^\&]+/, '$1' + "true");
                    var inactiveHref = href.replace(/(active=)[^\&]+/, '$1' + "false");
                    
                    $("div.status-selector ul.dropdown-menu").append(
                            '<li><a href="' + activeHref + '"><spring:message code="table.active" /></a></li>'
                    );

                    $("div.status-selector ul.dropdown-menu").append(
                            '<li><a href="' + inactiveHref + '"><spring:message code="table.inactive" /></a></li>'
                    );
                    
                });
            </script>
            
            <button class="btn dropdown-toggle" data-toggle="dropdown">
            </button>

            <ul class="dropdown-menu">
            </ul>

        </div>
        
        <div class="grid_12">

            <c:choose>
                <c:when test="${!empty param.year}">
                    <c:set var="displayYear" value="${param.year}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="displayYear" value="${year}"/>
                </c:otherwise>
            </c:choose>

            <div class="overview-header">

                <legend style="margin-bottom: 17px">

                    <p>
                        <spring:message code="table.overview"/><c:out value="${displayYear}"/>
                    </p>
                    
                    <p class="heading-date">
                        <spring:message code="Effective"/>&nbsp;<joda:format style="M-" value="${today}"/>
                    </p>

                </legend>

            </div>

            <c:choose>

                <c:when test="${notexistent == true}">

                    <spring:message code="table.empty"/>

                </c:when>

                <c:otherwise>
                    <table id="staff-list" cellspacing="0" class="sortable-tbl tablesorter zebra-table">
                        <thead>
                        <tr>
                            <th class="attributes"><spring:message code="firstname"/></th>
                            <th class="attributes"><spring:message code="name"/></th>
                            <th class="vac"><spring:message code='overview.entitlement.per.year' /></th>
                            <th class="vac"><spring:message code='overview.actual.entitlement' /></th>
                            <th class="vac"><spring:message code='overview.remaining.days.last.year' /></th>
                            <th class="vac"><spring:message code="left"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${persons}" var="person" varStatus="loopStatus">
                            <tr>
                                <td><c:out value="${person.firstName}"/></td>
                                <td><c:out value="${person.lastName}"/></td>
                                <td class="vac">
                                    <c:choose>
                                        <c:when test="${accounts[person] != null}">
                                            <fmt:formatNumber maxFractionDigits="1"
                                                              value="${accounts[person].annualVacationDays}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <spring:message code='not.specified'/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="vac">
                                    <c:choose>
                                        <c:when test="${accounts[person] != null}">
                                            <fmt:formatNumber maxFractionDigits="1"
                                                              value="${accounts[person].vacationDays}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <spring:message code='not.specified'/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="vac">
                                    <c:choose>
                                        <c:when test="${accounts[person] != null}">
                                            <fmt:formatNumber maxFractionDigits="1"
                                                              value="${accounts[person].remainingVacationDays}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <spring:message code='not.specified'/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="vac">
                                    <c:choose>
                                        <c:when test="${leftDays[person] != null && remLeftDays[person] != null}">
                                            <fmt:formatNumber maxFractionDigits="1" value="${leftDays[person]}"/>
                                            <c:if test="${beforeApril || !accounts[person].remainingVacationDaysExpire}">
                                                +
                                                <fmt:formatNumber maxFractionDigits="1" value="${remLeftDays[person]}"/>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <spring:message code='not.specified'/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>

            </c:choose>

        </div>
    </div>

</body>

</html>
