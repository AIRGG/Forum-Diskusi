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
        <!--        //**| CSS DIST... |**\\-->
        <jsp:include page="css.jsp" />
        <style>
            body{
                min-height: 760px;
            }
            pre{
                font-family: "roboto";
                font-size: 15px;
            }
        </style>

        <spring:url value="dist/img" var="img" />

    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <!--        //**| Navbarr... |**\\-->
        
        <div class="container">
            <c:set var = "str" value = "${fn:split(status, '_')}" />
            <c:if test="${not empty param.id && dataQ != 'gagal'}">
            <section id="blog-components" class="text-center">
                <!--Section: Author Box-->
                <section class="my-5">
                    <div class="media mt-4 px-1 text-md-left">
                        <img class="card-img-100 d-flex rounded-circle z-depth-1 mr-3" src="${img}/support/<c:if test="${dataQ.getImage() != ''}">${dataQ.getImage()}</c:if><c:if test="${dataQ.getImage() == ''}">user.png</c:if>" alt="Generic placeholder image">
                        <div class="media-body">
                            <h5 class="font-weight-bold mt-0">
                                <a href="/profil?userid=${dataQ.getUserid()}">${dataQ.getNamaQ()}</a>
                            <c:if test="${dataQ.getUserid() == str[0]}">    
                                <div class="float-right">
                                    <a id="Edit${dataQ.getId_question()}" onclick="openEditQ(${dataQ.getId_question()})" href="#!" class="mr-2" style="display: none; color: #4285f4;" title="Edit"><i class="fas fa-edit fa-xs"></i></a>
                                    <a id="Delete${dataQ.getId_question()}" onclick="openWarningQ(${dataQ.getId_question()})" href="#!" class="mr-2" style="display: none; color: #ed302f;" title="Delete"><i class="fas fa-times fa-xs"></i></a>
                                    <a onmouseover="openNav(${dataQ.getId_question()})" onclick="toggleNav(${dataQ.getId_question()})" href="#!" class="mr-2" style="display: inline;" title="Navigation"><i class="fa fa-bars"></i></a>
                                </div>
                            </c:if>
                            </h5>
                            <h4>${dataQ.getJudul()}</h4>
                            <pre>${dataQ.getKonten()}</pre>
                            <br/><br/>
                            <c:if test="${dataQ.getImg() != ''}">
                                <a href="${img}/${dataQ.getImg()}" target="_blank">
                                    <img src="${img}/${dataQ.getImg()}" alt="thumbnail" class="img-thumbnail" style="min-width: 500px; max-width: 700px; max-height: auto;">
                                </a>
                            </c:if>
                        </div>
                    </div>
                </section>
                <!--Section: Author Box-->
            </section>
                        
            <section class="my-5">
                <!-- Card header -->
                <div class="card-header border-0 font-weight-bold">${dataQ.getJml()} comments</div>
                <c:forEach items="${dataC}" var="dataC">
                <div class="media d-block d-md-flex mt-4">
                    <a href="/profil?userid=${dataC.getUserid()}">
                        <img class="card-img-64 d-flex rounded-circle mx-auto mb-3" src="${img}/support/<c:if test="${dataC.getImage() != ''}">${dataC.getImage()}</c:if><c:if test="${dataC.getImage() == '' or  dataC.getImage() == null}">user.png</c:if>" alt="Generic placeholder image">
                    </a>
                    <div class="media-body text-center text-md-left ml-md-3 ml-0">
                        <h5 class="font-weight-bold mt-0">
                            <a href="/profil?userid=${dataC.getUserid()}">${dataC.getNama()}</a>
                        <c:set var="idreply" value="${param.id}_${dataC.getId_comment()}"/>
                            <a href="#!" class="pull-right ml-3" title="Reply" <c:if test="${status != 'admin_1_'}">onclick="reply('${idreply}')"</c:if>>
                                <i class="fas fa-reply"></i>
                            </a>
                                <c:if test="${dataC.getUserid() == str[0]}">
                            <div class="float-right">
                                <a id="EditC${dataC.getId_comment()}" onclick="openEditC(${dataC.getId_comment()})" href="#!" class="mr-2" style="display: none; color: #4285f4;" title="Edit"><i class="fas fa-edit fa-xs"></i></a>
                                <a id="DeleteC${dataC.getId_comment()}" onclick="openWarningC(${dataC.getId_comment()})" href="#!" class="mr-2" style="display: none; color: #ed302f;" title="Delete"><i class="fas fa-times fa-xs"></i></a>
                                <a onmouseover="openNavC(${dataC.getId_comment()})" onclick="toggleNavC(${dataC.getId_comment()})" href="#!" class="mr-2" style="display: inline;" title="Navigation"><i class="fa fa-bars"></i></a>
                            </div>
                                </c:if>
                        </h5>
                        <pre>${dataC.getKonten()}</pre>
                        
                        
                        <c:if test="${dataC.getImg() != ''}">
                        <br/>
                        <a href="${img}/${dataC.getImg()}" target="_blank">
                            <div style="width: 100%;">
                            <img src="${img}/${dataC.getImg()}" alt="thumbnail" class="img-thumbnail" style="max-width: 200px; max-height: auto;">
                            </div>
                        </a>
                        </c:if>
                        <c:forEach items="${dataSC}" var="dataSC">
                            <c:if test="${dataSC.getId_comment() == dataC.getId_comment()}">
                        <div class="media d-block d-md-flex mt-4">
                            <img class="card-img-64 d-flex rounded-circle mx-auto mb-3" src="${img}/support/<c:if test="${dataSC.getImage() != ''}">${dataSC.getImage()}</c:if><c:if test="${dataSC.getImage() == '' or dataSC.getImage() == null}">user.png</c:if>" alt="Generic placeholder image">
                            <div class="media-body text-center text-md-left ml-md-3 ml-0">
                                <h5 class="font-weight-bold mt-0">
                                    <a href="/profil?userid=${dataSC.getUserid()}">${dataSC.getNama()}</a>
                                
                                <c:if test="${dataSC.getUserid() == str[0]}">
                            <div class="float-right">
                                <a id="EditSC${dataSC.getId_subcomment()}" onclick="openEditSC(${dataSC.getId_subcomment()})" href="#!" class="mr-2" style="display: none; color: #4285f4;" title="Edit"><i class="fas fa-edit fa-xs"></i></a>
                                <a id="DeleteSC${dataSC.getId_subcomment()}" onclick="openWarningSC(${dataSC.getId_subcomment()})" href="#!" class="mr-2" style="display: none; color: #ed302f;" title="Delete"><i class="fas fa-times fa-xs"></i></a>
                                <a onmouseover="openNavSC(${dataSC.getId_subcomment()})" onclick="toggleNavSC(${dataSC.getId_subcomment()})" href="#!" class="mr-2" style="display: inline;" title="Navigation"><i class="fa fa-bars"></i></a>
                            </div>
                                </c:if>
                                </h5>
                                <pre>${dataSC.getKonten()}</pre>
                            </div>
                        </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                </section>
                </c:forEach>
                            
            <!-- Quick Reply -->
            <div class="form-group mt-4">
                <form:form action="/addComment" method="POST" enctype="multipart/form-data">
                <label for="quickReplyFormComment">Your comment</label>
                <input type="hidden" name="id_question" value="${param.id}" />
                <textarea <c:if test="${status == 'admin_1_'}">disabled="true"</c:if> id="txtComment" name="konten" class="form-control" id="quickReplyFormComment" rows="5"></textarea>

                <div class="input-default-wrapper">
                    <input <c:if test="${status == 'admin_1_'}">disabled="true"</c:if> name="imgComment" type="file" id="file-with-current" class="input-default-js" accept="image/x-png,image/gif,image/jpeg">
                    <label class="label-for-default-js rounded-right mb-3" for="file-with-current" style="width: 400px;"><span class="span-choose-file">Add Picture...</span></label>
                </div>
                    <button <c:if test="${status == 'admin_1_'}">disabled="true"</c:if> id="cobaKlik" class="btn btn-primary btn-lg waves-effect waves-light" type="submit">Post</button>
                </form:form>
            </div>
            

            <!--Modal Reply Comment-->
            <div class="modal fade" id="modReplyComment" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
                 aria-hidden="true">
                <!-- Add .modal-dialog-centered to .modal-dialog to vertically center the modal -->
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Reply Comment</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <!-- Quick Reply -->
                            <div class="form-group mt-4">
                                <label for="quickReplyFormComment">Your comment</label>
                                <input id="isiModAddSC" type="hidden">
                                <textarea id="isiModAdd" class="form-control" id="quickReplyFormComment" rows="5"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="submitSC" type="button" class="btn btn-primary">Send Comment</button>
                        </div>
                    </div>
                </div>
            </div>

            <!--Modal Reply Comment-->
            <div class="modal fade" id="modEditComment" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
                 aria-hidden="true" style="overflow: hidden;">
                <!-- Add .modal-dialog-centered to .modal-dialog to vertically center the modal -->
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Edit Comment</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form:form action="/editComment" method="POST" enctype="multipart/form-data">
                        <div class="modal-body">
                            <!-- Quick Reply -->
                            <div class="form-group mt-4">
                                <label for="quickReplyFormComment">Your comment</label>
                                <input type="hidden" name="id_question" value="${param.id}">
                                <input type="hidden" name="id_comment">
                                <textarea id="isiModEditC" name="konten" class="form-control" id="quickReplyFormComment" rows="5"></textarea>
                                <div class="input-default-wrapper">
                                    <input type="hidden" name="img">
                                    <input name="imgComment" type="file" id="imgComment" class="input-default-js" accept="image/x-png,image/gif,image/jpeg">
                                    <label class="label-for-default-js rounded-right mb-3" for="imgComment" style="width: 400px;"><span class="span-choose-file">Add Picture...</span></label>
                                </div>
                                
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Edit Comment</button>
                        </div>
                        </form:form>
                    </div>
                </div>
            </div>
            
            <!--Modal Reply Comment-->
            <div class="modal fade" id="modEditSubComment" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
                 aria-hidden="true" style="overflow: hidden;">
                <!-- Add .modal-dialog-centered to .modal-dialog to vertically center the modal -->
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Edit Sub Comment</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <!-- Quick Reply -->
                            <div class="form-group mt-4">
                                <label for="quickReplyFormComment">Your comment</label>
                                <input type="hidden" id="isiEditSCid">
                                <textarea id="isiModEditSC" class="form-control" id="quickReplyFormComment" rows="5"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="submitEditSC" type="button" class="btn btn-primary">Edit SubComment</button>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="modal.jsp" />

            <!-- Container -->
        </div>
        <!--        //**| JS DIST... |**\\-->
        <jsp:include page="javascript.jsp" />

        <script>
            $("#PindahSI").click(function () {
                $("#modalSISU").modal("hide");
                setTimeout(function () {
                    $("#modalSISU").modal("show");
                }, 500);
            });
            function openEditC(id) {
                $.post("/showEditC", {"kode":id}, function(){
                    
                }).done(function(data){
                    var jsn = JSON.parse(data);
                    $("input[name='img']").val(jsn['img']);
                    $("input[name='id_comment']").val(id);
                    $("#isiModEditC").text(jsn['konten']);
                    ShowModal("#modEditComment");
                }).fail(function(xhr, msg, txt){
//                    alert(xhr+msg+txt);
//                    alert("Upsss.., data not found...");
                });
            }
            function openEditSC(id) {
                $.post("/showEditSC", {"kode":id}, function(){
                    
                }).done(function(data){
                    var jsn = JSON.parse(data);
                    $("#isiModEditSC").text(jsn['konten']);
                    $("#isiEditSCid").val(id);
                    ShowModal("#modEditSubComment");
                }).fail(function(xhr, msg, txt){
//                    alert(xhr+msg+txt);
//                    alert("Upsss.., data not found...");
                });
            }
            
            function reply(idx) {
                ShowModal("#modReplyComment");
                $("#isiModAddSC").val(idx);
            }
            
            $("#submitSC").click(function(){
                var jsn = {
                    "kode" : $("#isiModAddSC").val(),
                    "konten" : $("#isiModAdd").val()
                }
                <c:if test="${not empty status && status != 'admin_1_'}">
                $.post("/addSubcomment", jsn, function(){
                    
                }).done(function(data){
                    location.reload(true);
                }).fail(function(xhr, msg, txt){
//                    alert(xhr+msg+txt);
                    alert("Sorry.. :(");
                    location.reload(true);
                });
                </c:if>
            <c:if test="${empty status}">
//                alert("Silahkan Login untuk Reply Comment");
                $("#modReplyComment").modal("hide");
                $("#btnModsignInUp").trigger("click");
                $("#warnNotLog").show();
            </c:if>
            });
            
            $("#submitEditSC").click(function(){
                var jsn = {
                    "kode" : $("#isiEditSCid").val(),
                    "konten" : $("#isiModEditSC").val()
                }
                $.post("/editSubcomment", jsn, function(){
                    
                }).done(function(data){
                    ShowModal("#modWarnSuccess");
                        $('#modWarnSuccess').on('hidden.bs.modal', function (e) {
                            location.reload(true);
                        });
                }).fail(function(xhr, msg, txt){
//                    alert(xhr+msg+txt);
//                    alert("Upsss.., data not found...");
                });
            });
            <c:if test="${empty status}">
            $('form[action="/addComment"]').submit(function(e){
                e.preventDefault(e);
//                alert("Silahkan Login untuk Menambahkan Comment");
                $("#modReplyComment").modal("hide");
                $("#btnModsignInUp").trigger("click");
                $("#warnNotLog").show();
            });
            </c:if>
            <c:if test="${not empty status}">
            $('form[action="/addComment"]').submit(function(e){
                if($("#txtComment").val() == ""){
                    e.preventDefault(e);
                    alert("Silahkan isi Komentar");
                }
            });
            </c:if>
        </script>
        </c:if>
        <c:if test="${empty param.id || dataQ == 'gagal'}">
            <p style="margin-top: 20px;">Upss., Nothing Happend Here...</p>
        </c:if>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
