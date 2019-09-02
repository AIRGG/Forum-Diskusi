<%-- 
    Document   : admin_comment
    Created on : Mar 17, 2019, 7:38:55 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<f:view>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <!-- Tell the browser to be responsive to screen width -->
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Admin Comment</title>
            <style>
                body{
                    background-image: url("/dist/img/support/bg1.jpg");
                    background-repeat: no-repeat;
                    background-size: 100% 100%;
                }
            </style>
            <spring:url value="../dist/img" var="img" />
            <!--        //**| CSS DIST... |**\\-->
            <jsp:include page="css_admin.jsp" />
        </head>
        <body>
            <!-- Navbar -->
            <jsp:include page="v_headnav.jsp" />
            <!-- /.navbar -->
            <!-- Main Sidebar Container -->
            <jsp:include page="v_sidenav.jsp" />
            <!--Main layout-->
        <main class="pt-5 mx-lg-5">
            <div class="container-fluid mt-5">
                <!--Card-->
                <div class="card mb-4">
                    <!--Card content-->
                    <div class="card-body">
                        <!-- List group links -->
                        <img id="loading" src="${img}/support/preloader.gif" alt="" style="align-content: center;">
                        <div id="inTable"></div>
                    </div>
                </div>
                <jsp:include page="modal.jsp" />
            </div>
            <!--/.Card-->
            <!--Grid column-->
        </main>
        <!--        //**| JS DIST... |**\\-->
        <jsp:include page="javascript.jsp" />
        <script type="text/javascript">
            // Animations initialization
            new WOW().init();
            $(document).ready(function () {
                $.get("/tbl_c", function(){
                    $("#loading").show();
                }).done(function(data){
                    var str = ''+Math.floor(Math.random()*1000)+'';
                    var sub = str.substr(0, 4);
                    setTimeout(function(){
                        $("#loading").hide();
                        $("#inTable").html(data);
                    }, sub);
                }).fail(function(xhr, msg, txt){
                    alert(xhr+msg+txt);
                });
                $("a[href='/dashboard/comment']").addClass("active");
                $("a[href='/dashboard/comment']").attr("href", "#!");
                $("#iniTable").DataTable();
            });
            function ubahC(idx){
//            $("select.slctSts").change(function(){
                $.post("/ChangeComment", {"kode" : idx}, function(){

                }).done(function(data){
                    $("#inTable").html(data);
                }).fail(function(xhr, msg, txt){
                    alert(xhr+msg+txt);
                });
//            });
            }
        </script>
    </body>
</html>
</f:view>
