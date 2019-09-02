<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:url value="dist/img" var="img" />

<c:forEach items="${data}" var="dt">
    <div class="media mt-4 px-1 text-md-left">
        <img class="d-flex rounded-circle z-depth-1 mr-3" src="${img}/support/<c:if test="${dt.getImage() != ''}">${dt.getImage()}</c:if><c:if test="${dt.getImage() == ''}">user.png</c:if>" alt="Generic placeholder image" style="width: 90px; height: 90px;">
        <div class="media-body">
            <h6 class="font-weight-bold mt-0">
                <a href="/profil?userid=${dt.getUserid()}">${dt.getNamaQ()}</a>
            <c:set var = "str" value = "${fn:split(status, '_')}" />

            <c:if test="${dt.getUserid() == str[0]}">
                <div class="float-right">
                    <a id="Edit${dt.getId_question()}" onclick="openEditQ(${dt.getId_question()})" href="#!" class="mr-2" style="display: none; color: #4285f4;" title="Edit"><i class="fas fa-edit fa-xs"></i></a>
                    <a id="Delete${dt.getId_question()}" onclick="openWarningQ(${dt.getId_question()})" href="#!" class="mr-2" style="display: none; color: #ed302f;" title="Delete"><i class="fas fa-times fa-xs"></i></a>
                    <a onmouseover="openNav(${dt.getId_question()})" onclick="toggleNav(${dt.getId_question()})" href="#!" class="mr-2" style="display: inline;" title="Navigation"><i class="fa fa-bars"></i></a>
                </div>
            </c:if>
            </h6>
              <c:set var = "strJudul" value = "${fn:substring(dt.getJudul(), 0, 40)}" />
            <a href="/detail?id=${dt.getId_question()}">
                <h5><c:if test="${fn:length(dt.getJudul()) > 40}">${strJudul}...</c:if><c:if test="${fn:length(dt.getJudul()) <= 40}">${dt.getJudul()}</c:if></h5>
            </a>
            
            <c:set var = "tgl" value = "${fn:substring(dt.getTgl(), 0, 2)}" />
            <c:set var = "bln" value = "${fn:substring(dt.getTgl(), 2, 4)}" />
            <c:set var = "thn" value = "${fn:substring(dt.getTgl(), 4, 8)}" />

            <c:set var = "jam" value = "${fn:substring(dt.getJam(), 0, 2)}" />
            <c:set var = "mnt" value = "${fn:substring(dt.getJam(), 2, 4)}" />

            <c:if test="${bln < 10}">
                <c:set var="bln0" value="${fn:substring(bln, 1, 2)}"/>
            </c:if>
            <c:if test="${bln >= 10}">
                <c:set var="bln0" value="${bln}"/>
            </c:if>
            <c:set var="blnNm" value="${['', 'January', 'February', 'March', 'April', 'Mei', 'June', 'July', 'August', 'September', 'October', 'November', 'December']}" />

            Updated on ${blnNm[bln0]} ${tgl}, ${thn} <b>|</b> ${jam}:${mnt} <c:if test="${jam < 12}">AM</c:if><c:if test="${jam >= 12}">PM</c:if>.

            <c:if test="${dt.getJml() < 1}">
                <b>Not Reply Yet</b>
                <i class="far fa-comment-dots ml-2"></i>&nbsp;${dt.getJml()}
            </c:if>
            <c:if test="${dt.getJml() > 0}">
                <a href="/detail?id=${dt.getId_question()}">Last reply</a> by <b>${dt.getNamaC()}</b>
                <i class="far fa-comment-dots ml-2"></i>&nbsp;${dt.getJml()}
            </c:if>
        </div>
    </div><hr/>
</c:forEach>
<c:if test="${data == '[]'}">
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-6">
            <p id="ketnull" style="margin-top: 40px;">No Result of <b><u>${isi}</u></b> </p>
        </div>
    </div>
    
</c:if>