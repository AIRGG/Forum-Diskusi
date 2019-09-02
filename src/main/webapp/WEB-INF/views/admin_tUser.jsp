<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="../dist/img" var="img" />
<jsp:include page="css_admin.jsp" />
<h3>Data User</h3>
<table id="iniTable" class="table table-hover table-bordered mt-2">
    <thead align="center">
    <th>No</th>
    <th>Userid</th>
    <th>Nama</th>
    <th>Dob</th>
    <th>Address</th>
    <th>Status</th>
    <th>Image</th>
    <th>Action</th>
</thead>
<tbody>

    <% int no=1; %>
    <c:forEach items="${data}" var='dt'>

        <tr align="center">
            <td><% out.print(no++); %></td>
            <td>${dt.getUserid()}</td>
            <td>${dt.getNama()}</td>
            <c:set var = "tgl" value = "${fn:substring(dt.getDob(), 0, 2)}" />
            <c:set var = "bln" value = "${fn:substring(dt.getDob(), 2, 4)}" />
            <c:set var = "thn" value = "${fn:substring(dt.getDob(), 4, 8)}" />
            <td style="white-space: nowrap;">${tgl}-${bln}-${thn}</td>
            <td>${dt.getAddress()}</td>
            <td>
                <c:if test="${dt.getAcces() == 1}">
                    <strong>
                        <span class="badge badge-success">Running</span>
                    </strong>
                </c:if>
                <c:if test="${dt.getAcces() != 1}">
                    <strong>
                        <span class="badge badge-danger">Blocked</span>
                    </strong>
                </c:if>
            </td>
            <td>
                <a href="/dist/img/support/${dt.getImage()}" target="_blank">
                    <img src="${img}/support/<c:if test="${dt.getImage() != ''}">${dt.getImage()}</c:if><c:if test="${dt.getImage() == ''}">user.png</c:if>" alt="" style="width: 90px; height: auto;">
                    </a>
                </td>
                <td>
                    <!--<button class="btn btn-primary btn-sm mr-2"><i class="fas fa-edit"></i></button>-->
                    <select name="" id="" class="slctSts mdb-select" onchange="ubahUid('${dt.getUserid()}_<c:if test="${dt.getAcces() == 1}">2</c:if><c:if test="${dt.getAcces() != 1}">1</c:if>')" style="background-color: white;">
                            <option value="${dt.getUserid()}_1" <c:if test="${dt.getAcces() == 1}">selected="true"</c:if>>Run</option>
                    <option value="${dt.getUserid()}_0" <c:if test="${dt.getAcces() != 1}">selected="true"</c:if>>Block</option>
                    </select>
                </td>
            </tr>
    </c:forEach>
</tbody>
</table>
    <jsp:include page="javascript.jsp" />
    <script>
        $("#iniTable").DataTable();
        if($(window).width() < 960){
            $("#iniTable").addClass("table-reponsive");
        }else{
            $("#iniTable").removeClass("table-responsive");
        }
    </script>