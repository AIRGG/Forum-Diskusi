<%-- 
    Document   : index
    Created on : Feb 26, 2019, 11:07:52 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>Forum</title>
        <spring:url value="dist/img" var="img" />
        <!--        //**| CSS DIST... |**\\-->
        <jsp:include page="css.jsp" />
        <style>
            body{
                min-height: 760px;
            }
        </style>
    </head>
    <body>
        <!--        //**| Navbarr... |**\\-->
        <jsp:include page="navbar.jsp" />

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-9">

                    <div id="t_question"></div>

                    <c:if test="${empty param.search}">
                        <!--Pagination -->
                        <nav class="d-flex justify-content-center mt-5 mb-2 ">
                            <ul class="pagination pg-blue mb-0">
                                <c:if test="${not empty param.page}">
                                    <c:set var="page" value="${param.page}" />
                                </c:if>
                                <c:if test="${empty param.page}">
                                    <c:set var="page" value="1" />
                                </c:if>
                                <c:set var="bts" value="${batas}"/>
                                <c:set var="jml" value = "${fn:split(jmlDt.getNamaC()/bts, '.')}" />
                                <c:set var="str" value="${(((jmlDt.getNamaC()/bts) % 1 == 0 ? 0 : 0.5) * 2)}" />
                                <c:set var="last" value = "${fn:split(jml[0] + str, '.')}" />
                                <!--First-->
                                <c:if test="${empty param.page || not empty param.page && param.page == 1}">
                                    <li class="page-item disabled">
                                        <a class="page-link waves-effect waves-effect">First</a>
                                    </li>
                                </c:if>
                                <c:if test="${not empty param.page && param.page > 1}">
                                    <li class="page-item mr-2">
                                        <a href="?page=1" class="page-link waves-effect waves-effect">First</a>
                                    </li>
                                </c:if>

                                <!--Paging-->
                                <c:forEach var="i" begin="1" end="${last[0]}">
                                    <li class="page-item mr-2 <c:if test='${page == i}'>active</c:if>">
                                        <a href="<c:if test='${param.page == i}'>#!</c:if><c:if test='${param.page != i}'>?page=${i}</c:if>" class="page-link waves-effect waves-effect">${i}</a>
                                        </li>
                                </c:forEach>

                                <!--Last-->
                                <c:if test="${param.page == last[0]}">
                                    <li class="page-item disabled">
                                        <a class="page-link waves-effect waves-effect">Last</a>
                                    </li>
                                </c:if>
                                <c:if test="${empty param.page || not empty param.page && param.page < last[0]}">
                                    <li class="page-item mr-2">
                                        <a href="?page=${last[0]}" class="page-link waves-effect waves-effect">Last</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                        <!--Pagination -->
                    </c:if>

                    <jsp:include page="modal.jsp" />
                </div>

                <div class="col-md-3">
                    <!--Panel-->
                    <div class="card mb-3 mt-3">
                        <!--Card content-->
                        <div class="card-body">
                            <!--Title-->
                            <h4 class="card-title lead"><b>Statistics: </b></h4>
                            <!--Text-->
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Members
                                    <span id="Stskmember" class="badge badge-primary badge-pill"></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Threads
                                    <span id="Stskthreads" class="badge badge-primary badge-pill"></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Replies
                                    <span id="Stskreplies" class="badge badge-primary badge-pill"></span>
                                </li>
                            </ul>
                        </div>
                    </div>


                    <!--/.Panel-->
                    <c:if test="${usr != 'admin'}">
                        <button id="btnModQueSub" class="btn btn-md btn-deep-orange" title="Add Some Topic"><i class="fa fa-plus"></i> Add Topic</button>
                    </c:if>

                    <c:if test="${usr == 'admin'}">
                        <a href="/dashboard" class="btn btn-md btn-outline-primary"><i class="fa fa-external-link-alt"></i> Dashboard</a>
                    </c:if>
                    <!--Modal Add Question-->
                    <div class="modal fade " id="modQueSub">
                        <div class="modal-dialog cascading-modal" role="document">
                            <!--Content-->
                            <div class="modal-content">
                                <!--Modal cascading tabs-->
                                <div class="modal-c-tabs">
                                    <!-- Nav tabs -->
                                    <ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-toggle="tab" href="#panel7" role="tab" style="background-color: #4285F4; color: white;"><i class="fas fa-pencil mr-1"></i><b>Add Topic</b></a>
                                        </li>
                                    </ul>
                                    <!-- Tab panels -->
                                    <div class="tab-content">
                                        <div class="tab-pane fade in show active" role="tabpanel">
                                            <!--Body-->
                                            <div class="modal-body mb-1">
                                                <form:form method="POST" action="/addQuestion" enctype="multipart/form-data">
                                                    <div class="md-form form-sm">
                                                        <div class="md-form md-outline">
                                                            <input id="question" name="judul" type="text" maxlength="50" class="form-control">
                                                            <label for="question">Input Your Header Topic...</label>
                                                        </div>
                                                    </div>
                                                    <div class="md-form form-sm">
                                                        <div class="md-form md-outline">
                                                            <textarea type="text" id="subquestion" name="konten" class="form-control" rows="3"></textarea>
                                                            <label for="subquestion">Input Your Detail....</label>
                                                        </div>
                                                    </div>
                                                    <div class="md-form form-sm mb-1">
                                                        <div class="input-default-wrapper mt-3">
                                                            <input type="hidden" name="img" />
                                                            <input type="file" id="image" name="imgQuestion" class="input-default-js" accept="image/x-png,image/gif,image/jpeg">
                                                            <label class="label-for-default-js rounded-left rounded-right mb-3" for="image"><span class="span-choose-file">Add Image</span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <br/><br/>
                                                    <div class="md-form form-sm mb-1 text-center">
                                                        <button id="btnAddTopic" class="btn btn-lg btn-deep-orange" style="color:white;"><i class="far fa-paper-plane"></i> Send</button>
                                                    </div>
                                                </form:form>
                                            </div>
                                            <!--Footer-->
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-danger btn-sm waves-effect ml-auto" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--/.Content-->
                        </div>
                    </div>
                    <!--col-md-3-->
                </div>
            </div>
            <!--        //**| Footer... |**\\-->
            <jsp:include page="footer.jsp" />

            <!--Container-->
        </div>
        <!--        //**| JS DIST... |**\\-->
        <jsp:include page="javascript.jsp" />

        <script>
            $(document).ready(function () {
                $("div.navigasiQ").click(function () {
                    $("div.navigasiQ a:eq(0), div.navigasiQ a:eq(1)").toggle(function () {
                        $("div.navigasiQ .fa").css("color", "#00c851");
                    });
                });
            <c:if test="${not empty param.search}">
                $.post("/search", {"kode": "${param.search}"}, function () {

                }).done(function (data) {
                    $("#t_question").html(data);

                }).fail(function (xhr, msg, txt) {
//                    alert(xhr + msg + txt);
                    alert("Upsss.., data not found...");
                });
            </c:if>
            <c:if test="${empty param.search}">
                <c:if test="${not empty param.page}">
                var url = "/showQuestion?page=${param.page}";
                </c:if>
                <c:if test="${empty param.page || param.page < 1}">
                var url = "/showQuestion?page=1";
                </c:if>
                $.get(url, function (data) {

                }).done(function (data) {
                    $("#t_question").html(data);

                }).fail(function (xhr, msg, txt) {
//                    alert(xhr + msg + txt);
                    alert("Upsss.., data not found...");
                });
            </c:if>
                getStatistik();
            });
            $("#btnModQueSub").click(function () {
                ShowModal("#modQueSub");
            });

            function getStatistik() {
                $.get("/showStatistics", function (data) {

                }).done(function (jsn) {
                    var data = JSON.parse(jsn);
                    $("#Stskmember").text(data["member"]);
                    $("#Stskreplies").text(data["replies"]);
                    $("#Stskthreads").text(data["thread"]);

                }).fail(function (xhr, msg, txt) {
//                    alert(xhr + msg + txt);
                    alert("Upsss.., data not found...");
                });
            }

            <c:if test="${empty status}">
            $('form[action="/addQuestion"]').submit(function (e) {
                if ($("#question").val() == "") {
                    e.preventDefault(e);
                    alert("Harap Mengisi Judul");
                    $("#question").attr("autofocus", true);
                } else {
                    e.preventDefault(e);
                    $("#modQueSub").modal("hide");
                    $("#btnModsignInUp").trigger("click");
                    $("#warnNotLog").show()
                }
            });
            </c:if>
            <c:if test="${not empty status}">
            $('form[action="/addQuestion"]').submit(function (e) {
                if ($("#question").val() == "") {
                    e.preventDefault(e);
                    alert("Harap Mengisi Judul");
                    $("#question").attr("autofocus", true);
                }
            });
            </c:if>
        </script>
    </body>
</html>
