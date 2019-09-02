<%-- 
    Document   : profil
    Created on : Feb 27, 2019, 2:56:01 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>Forum</title>
        <!--        //**| CSS DIST... |**\\-->
        <jsp:include page="css.jsp" />
        <style>
            body{
                min-height: 760px;
            }
        </style>

        <spring:url value="dist/img" var="img" />

    </head>
    <body>
        <!--        //**| Navbarr... |**\\-->
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <c:set var = "str" value = "${fn:split(status, '_')}" />
            <div class="row">
                <div class="col-md-10">
                    <div class="media mt-4 px-1 text-md-left">
                        <c:if test="${dataP.getImage() != null && dataP.getUserid() != 'admin'}">
                            <a href="${img}/support/<c:if test="${dataP.getImage() != ''}">${dataP.getImage()}</c:if><c:if test="${dataP.getImage() == '' or dataP.getImage() == null}">user.png</c:if>" target="_blank">
                                <img class="card-img-100 d-flex rounded-circle z-depth-1 mr-3" src="${img}/support/<c:if test="${dataP.getImage() != ''}">${dataP.getImage()}</c:if><c:if test="${dataP.getImage() == ''}">user.png</c:if>" alt="Generic placeholder image">
                            </a>
                            <div class="media-body">
                                
                                    <h4 class="font-weight-bold mt-0">
                                        <a href="#!">${dataP.getNama()}</a><c:if test="${dataP.getUserid() == str[0]}"><a href="#!" onclick="openModEditProfil('${dataP.getUserid()}')"><i class="fas fa-edit fa-xs ml-3"></i></a></c:if>
                                    </h4>
                                
                                <c:set var = "tgl" value = "${fn:substring(dataP.getDob(), 0, 2)}" />
                                <c:set var = "bln" value = "${fn:substring(dataP.getDob(), 2, 4)}" />
                                <c:set var = "thn" value = "${fn:substring(dataP.getDob(), 4, 8)}" />
                                <h6>
                                    Date of Birth: ${tgl}-${bln}-${thn}<br/>
                                    Address: ${dataP.getAddress()}
                                </h6>
                            </div>
                        </c:if>
                            <c:if test="${dataP.getUserid() == null || dataP.getUserid() == 'admin'}"><p style="text-align: center;" align="center">Upss., Nothing Happend Here...</p></c:if>
                    </div><hr/>
                    <c:forEach items="${dataQ}" var="data">
                        <c:if test="${data.getUserid() == str[0]}">
                        <div class="float-right">
                            <a id="Edit${data.getId_question()}" onclick="openEditQ(${data.getId_question()})" href="#!" class="mr-2" style="display: none; color: #4285f4;" title="Edit"><i class="fas fa-edit fa-xs"></i></a>
                            <a id="Delete${data.getId_question()}" onclick="openWarningQ(${data.getId_question()})" href="#!" class="mr-2" style="display: none; color: #ed302f;" title="Delete"><i class="fas fa-times fa-xs"></i></a>
                            <a onmouseover="openNav(${data.getId_question()})" onclick="toggleNav(${data.getId_question()})" href="#!" class="mr-2" style="display: inline;" title="Navigation"><i class="fa fa-bars"></i></a>
                        </div>
                        </c:if>
                        <a href="/detail?id=${data.getId_question()}"><h4>${data.getJudul()}</h4></a>

                        <c:set var = "tgl" value = "${fn:substring(data.getTgl(), 0, 2)}" />
                        <c:set var = "bln" value = "${fn:substring(data.getTgl(), 2, 4)}" />
                        <c:set var = "thn" value = "${fn:substring(data.getTgl(), 4, 8)}" />

                        <c:set var = "jam" value = "${fn:substring(data.getJam(), 0, 2)}" />
                        <c:set var = "mnt" value = "${fn:substring(data.getJam(), 2, 4)}" />

                        <c:if test="${bln < 10}">
                            <c:set var="bln0" value="${fn:substring(bln, 1, 2)}"/>
                        </c:if>
                        <c:if test="${bln >= 10}">
                            <c:set var="bln0" value="${bln}"/>
                        </c:if>
                        <c:set var="blnNm" value="${['', 'January', 'February', 'March', 'April', 'Mei', 'June', 'July', 'August', 'September', 'October', 'November', 'December']}" />

                        Updated on ${blnNm[bln0]} ${tgl}, ${thn} <b>|</b> ${jam}:${mnt} <c:if test="${jam < 12}">AM</c:if><c:if test="${jam >= 12}">PM</c:if>.

                        <c:if test="${data.getJml() < 1}">
                            <b>Not Reply Yet</b>
                            <i class="far fa-comment-dots ml-2"></i>&nbsp;${data.getJml()}
                        </c:if>
                        <c:if test="${data.getJml() > 0}">
                            <a href="/detail?id=${data.getId_question()}">Last reply</a> by <b>${data.getNamaC()}</b>
                            <i class="far fa-comment-dots ml-2"></i>&nbsp;${data.getJml()}
                        </c:if>
                        <hr/>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!--ModEditProfil-->
        <div class="modal fade" id="modEditProfil" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Edit Profil</h4>
                        <button type="button" class="close float-right" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                    <form:form action="/editProfil" method="POST" enctype="multipart/form-data">
                        <div class="md-form form-sm mb-4">
                            <i class="fas fa-user-shield prefix"></i>
                            <input type="hidden" name="userid" value="${dataP.getUserid()}">
                            <input type="text" id="EditSUusername" class="form-control form-control-sm validate" disabled="true" value="${dataP.getUserid()}">
                            <label data-error="Enter Your Username" data-success="" for="EditSUusername"></label>
                        </div>

                        <div class="md-form form-sm mb-5">
                            <i class="fas fa-user prefix"></i>
                            <input type="text" name="nama" id="EditNama" class="form-control form-control-sm validate" value="${dataP.getNama()}" maxlength="50">
                            <label data-error="Enter Your Nama" data-success="" for="EditNama">Enter Your Name...</label>
                        </div>
                            <c:set var = "tgl" value = "${fn:substring(dataP.getDob(), 0, 2)}" />
                            <c:set var = "bln" value = "${fn:substring(dataP.getDob(), 2, 4)}" />
                            <c:set var = "thn" value = "${fn:substring(dataP.getDob(), 4, 8)}" />
                        <div class="md-form form-sm mb-5">
                            <i class="fas fa-home prefix"></i>
                            <input type="text" name="address" id="EditAddress" class="form-control form-control-sm validate" value="${dataP.getAddress()}">
                            <label data-error="Enter Your Address" data-success="" for="EditAddress">Enter Your Address...</label>
                        </div>

                        <div class="md-form form-sm mb-5">
                            <i class="far fa-calendar-alt prefix"></i>
                            <input type="text" name="dob" id="EditBirth" class="form-control form-control-sm validate" value="${tgl}/${bln}/${thn}" maxlength="10">
                            <label data-error="Enter Your Birthday" data-success="" for="EditBirth">Enter Your Birth...</label>
                        </div>

                        <div class="input-default-wrapper mb-4">
                            <input type="hidden" name="image" value="${dataP.getImage()}">
                            <input name="imgProfil" type="file" id="file-with-current" class="input-default-js" accept="image/x-png,image/gif,image/jpeg">
                            <label class="label-for-default-js rounded-right mb-3" for="file-with-current"><span class="span-choose-file">Change Picture...</span>
                            </label>
                        </div>

                        <input type="checkbox" id="ConfirmEditPassword"> <label for="ConfirmEditPassword">Click This to Change Password</label>

                        <div class="md-form form-sm mb-4" id="divEditPassword" style="display: none;">
                            <i class="fas fa-lock prefix"></i>
                            <input name="password" type="password" id="EditPassword" class="form-control form-control-sm validate">
                            <label data-error="Enter Your Password" data-success="" for="EditPassword">Enter Your New Password</label>
                        </div>

                        <div class="text-center form-sm mt-2">
                            <button id="btnEditProfil" class="btn btn-blue btn-lg" style="color:white;">Edit</button>
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
        <!--        //**| Modal... |**\\-->
        <jsp:include page="modal.jsp" />
        
        <jsp:include page="footer.jsp" />

        <!--        //**| JavaScript... |**\\-->
        <jsp:include page="javascript.jsp" />

        <script>
            $(document).ready(function () {
                var usr = <c:if test="${param.userid != null || param.userid != '' || not empty param.userid}">'${param.userid}'</c:if><c:if test="${param.userid == null || param.userid == '' || empty param.userid}">""</c:if>;
                $("div[class='modal-footer flex-center']").css("height", "auto");
                $("input[name='dob']").datepicker();
            });


            $("#ConfirmEditPassword").click(function () {
                var check = $(this).prop("checked");
                var div = $("#divEditPassword");
                if (check == true) {
                    div.show();
                } else {
                    div.hide();
                }
            });
            function openModEditProfil(id) {
                ShowModal("#modEditProfil");
            }

        </script>

    </body>
</html>