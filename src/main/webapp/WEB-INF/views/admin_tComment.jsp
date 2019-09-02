<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="../dist/img" var="img" />
<jsp:include page="css_admin.jsp" />
<h3>Data Comment</h3>
<table id="iniTable" class="table table-hover table-bordered mt-2">
    <thead align="center">
    <th>No</th>
    <th>Userid</th>
    <th>Tgl</th>
    <th>Jam</th>
    <th>Konten</th>
    <th>Img</th>
    <th>Status</th>
    <th>Action</th>
</thead>
<tbody>
    <% int no=1; %>
    <c:forEach items="${data}" var="dt">
        <tr align="center">
            <td><% out.print(no++); %></td>
            <td>${dt.getUserid()}</td>
            <c:set var = "tgl" value = "${fn:substring(dt.getTgl(), 0, 2)}" />
            <c:set var = "bln" value = "${fn:substring(dt.getTgl(), 2, 4)}" />
            <c:set var = "thn" value = "${fn:substring(dt.getTgl(), 4, 8)}" />
            <td style="white-space: nowrap;">${tgl}-${bln}-${thn}</td>
            <c:set var = "jam" value = "${fn:substring(dt.getJam(), 0, 2)}" />
            <c:set var = "mnt" value = "${fn:substring(dt.getJam(), 2, 4)}" />
            <td style="white-space: nowrap;">${jam}:${mnt} <c:if test="${jam < 12}">AM</c:if><c:if test="${jam >= 12}">PM</c:if></td>
            <td>${dt.getKonten()}</td>
            <td>
                <c:if test="${dt.getImg() != ''}">
                    <a href="/dist/img/${dt.getImg()}" target="_blank">
                        <img src="${img}/${dt.getImg()}" alt="" style="width: 90px; height: auto;"/>
                    </a>
                </c:if>
            </td>
            <td style="vertical-align: middle;">
                <c:if test="${dt.getStatus() == 1}">
                    <strong>
                        <span class="badge badge-success">Running</span>
                    </strong>
                </c:if>
                <c:if test="${dt.getStatus() != 1 && dt.getStatus() != 0}">
                    <strong>
                        <span class="badge badge-danger">Blocked</span>
                    </strong>
                </c:if>
                <c:if test="${dt.getStatus() == 0}">
                    <strong>
                        <span class="badge badge-danger">Delete by User</span>
                    </strong>
                </c:if>
            </td>
            <td style="white-space: nowrap;">
                <!--<button class="btn btn-primary btn-sm mr-2"><i class="fas fa-edit"></i></button>-->
                <c:if test="${dt.getStatus() != 0}">
                <select name="" id="" class="slctSts mdb-select" onchange="ubahC('${dt.getId_comment()}_<c:if test="${dt.getStatus() == 1}">2</c:if><c:if test="${dt.getStatus() != 1}">1</c:if>')">
                    <option value="${dt.getId_comment()}_1" <c:if test="${dt.getStatus() == 1}">selected="true"</c:if>>Run</option>
                    <option value="${dt.getId_comment()}_0" <c:if test="${dt.getStatus() != 1}">selected="true"</c:if>>Block</option>
                </select>
                </c:if>
                </td>
            </tr>
    </c:forEach>
</tbody>
</table>

<jsp:include page="javascript.jsp" />
<script>
    $("#iniTable").DataTable();
    if ($(window).width() < 960) {
        $("#iniTable").addClass("table-reponsive");
    } else {
        $("#iniTable").removeClass("table-responsive");
    }
</script>