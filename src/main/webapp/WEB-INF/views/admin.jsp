<%--
Document   : admin
Created on : Mar 14, 2019, 10:00:32 AM
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
            <title>Admin</title>
            <style>
                body{
                    background-image: url("/dist/img/support/bg1.jpg");
                    background-repeat: no-repeat;
                    background-size: 100% auto;
                }
            </style>
            <spring:url value="dist/img" var="img" />
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
                        <!--<p style="font-size: 25px; font-weight: bold; text-align: center;">Traffic</p>-->
                        <div class="row">
                            <div class="col-md-3">
                                <div class="list-group list-group-flush" style="padding: 0px;">
                                    <a href="dashboard/user" class="list-group-item list-group-item-action waves-effect" style="background-color: #2980b9; min-height: 180px; max-height: auto; text-align: center; color: white;">
                                        <i class="fas fa-user" style="font-size: 80px; margin-top: 10px; display: inline-block;;"></i>
                                        <b style="font-size: 40px; display: inline-block;">${data.getUser()}</b><br>
                                        <span class="badge badge-primary badge-pill pull-right" style="margin-top: 10px; display: inline-block;; font-size: 20px;">User
                                        </span>
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <a href="dashboard/question" class="list-group-item list-group-item-action waves-effect" style="background-color: #27ae60; min-height: 180px; max-height: auto; text-align: center; color: white;">
                                    <i class="fas fa-question" style="font-size: 80px; margin-top: 10px; display: inline-block;;"></i>
                                    <b style="font-size: 40px; display: inline-block;">${data.getQuestion()}</b><br>
                                    <span class="badge badge-success badge-pill pull-right" style="margin-top: 10px; display: inline-block; font-size: 20px;">Question
                                    </span>
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="dashboard/comment" class="list-group-item list-group-item-action waves-effect" style="background-color: #e74c3c ; min-height: 180px; max-height: auto; text-align: center; color: white;">
                                    <i class="fas fa-comment" style="font-size: 80px; margin-top: 10px; display: inline-block; display: inline-block;"></i>
                                    <b style="font-size: 40px; display: inline-block;">${data.getComment()}</b><br>
                                    <span class="badge badge-danger badge-pill pull-right" style="margin-top: 10px; display: inline-block; font-size: 20px;">Comment
                                    </span>
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="dashboard/subcomment" class="list-group-item list-group-item-action waves-effect" style="background-color: #f39c12; min-height: 180px; max-height: auto; text-align: center; color: white;">
                                    <i class="fas fa-comments" style="font-size: 80px; margin-top: 10px; display: inline-block;"></i>
                                    <b style="font-size: 40px; display: inline-block;">${data.getSubcomment()}</b><br>
                                    <span class="badge badge-warning badge-pill pull-right" style="margin-top: 10px; display: inline-block; font-size: 20px;">Sub Comment
                                    </span>
                                </a>
                            </div>
                        </div>
                        <!--                        <br/><br/>-->
                        <!--<br/>-->
                        <div class="row">
                            <h3 id="coba"></h3>
                                                        <!--<canvas id="doughnutChart"></canvas>-->
                        </div>
                    </div>
                </div>
            </div>

            <!--/.Card-->
        </div>
        <!--Grid column-->
    </main>
    <!--        //**| JS DIST... |**\\-->
    <jsp:include page="javascript.jsp" />
    <script type="text/javascript">
        // Animations initialization
        new WOW().init();
        $(document).ready(function () {
            $("a[href='/dashboard']").addClass("active");
            
            var peserta = {
                "no": "123",
                "nama": "GG",
                "alamat": "CBN"
            }
            var panitia = {
                "no": "888",
                "nama": "QQ",
                "alamat": "BGR"
            }
            var dt = {"peserta" : peserta, "panitia": panitia}
            $.post("/dashboard", {"data": dt}, function () {

            }).done(function (data) {
                $("#coba").html(data);
            }).fail(function (xhr, msg, txt) {
                alert(xhr + msg + txt);
            });
        });
        //doughnut
        var ctxD = document.getElementById("doughnutChart").getContext('2d');
        var myLineChart = new Chart(ctxD, {
            type: 'doughnut',
            data: {
                labels: ["User", "Question", "Comment", "Sub Comment"],
                datasets: [{
                        data: [${data.getUser()}, ${data.getQuestion()}, ${data.getComment()}, ${data.getSubcomment()}],
                        backgroundColor: ["#F7464A", "#46BFBD", "#FDB45C", "#4D5360"],
                        hoverBackgroundColor: ["#FF5A5E", "#5AD3D1", "#FFC870", "#616774"]
                    }]
            },
            options: {
                responsive: true
            }
        });
        
    </script>

</body>
</html>
</f:view>