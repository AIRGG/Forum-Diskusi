<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="dist/img" var="imgNav" />

<nav class="navbar navbar-light" style="background-color: #4f4f4f;">
    <div class="container">
        <div class="col-md-1" style="margin-right: 150px;">
            <a href="../"><img src="${imgNav}/support/logo.PNG" style="width: 220px; height: auto;" /></a>
        </div>
        
        <div class="col-md-7">
            <form:form action="/" method="get">
            <div class="input-group mb-3" style="margin-top: 16px;">
                
                <input name="search" id="FSearch" type="text" class="form-control" placeholder="Search something...." aria-label="Search something..."
                       aria-describedby="button-addon2" <c:if test="${not empty param.search}">value="${param.search}"</c:if>>
                <div class="input-group-append">
                    <button class="btn btn-md btn-success m-0 px-3 py-2 z-depth-0 waves-effect" type="submit" id="button-addon2"><i class="fas fa-search"></i></button>
                </div>
                </form:form>
            </div>
        </div>
        
        <div class="col-xs-3">
            <c:if test="${not empty status}">
                <c:set var = "str" value = "${fn:split(status, '_')}" />
                <div class="nav-item avatar dropdown">
        <a class="nav-link dropdown-toggle text-light" id="navbarDropdownMenuLink-55" data-toggle="dropdown" aria-haspopup="true"
          aria-expanded="false">
            
          <img id="navProf" class="d-flex rounded-circle z-depth-1" alt="avatar image" style="width: 50px; height: 50px;">
<!--          <b class="small">Nama Orang</b>-->
        </a>
        <div class="dropdown-menu dropdown-menu-right dropdown-secondary" aria-labelledby="navbarDropdownMenuLink-55">
            <a class="dropdown-item text-primary" href="profil?userid=${str[0]}"><i class="fas fa-user"></i> Profile</a>
            <a class="dropdown-item text-danger" href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
      </div>
            </c:if>
            <c:if test="${empty status}">
                <button id="btnModsignInUp" class="btn btn-primary btn-md" title="Sign in or Sign Up">Login &nbsp;|&nbsp; Register</button>
            </c:if>
        </div>
    </div>
</nav>

<!--Modal: Login / Register Form-->
<div class="modal fade" id="modalSISU">
    <div class="modal-dialog cascading-modal" role="document">
        <!--Content-->
        <div class="modal-content">
            <!--Modal cascading tabs-->
            <div class="modal-c-tabs">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3" role="tablist">
                    <li class="nav-item">
                        <a id="NavModLog" class="nav-link active" data-toggle="tab" href="#tab1" role="tab" style="background-color: #4285F4; color: white;"><i class="fas fa-user mr-1"></i>
                            Login</a>
                    </li>
                    <li id="btnRegister" class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab2" role="tab" style="background-color: #0d47a1; color: white;"><i class="fas fa-user-plus mr-1"></i>
                            Register</a>
                    </li>
                </ul>
                <!-- Tab panels -->
                <div class="tab-content">
                    <!--Panel 7-->
                    <div class="tab-pane fade in show active" id="tab1" role="tabpanel">
                        <!--Body-->
                        <form:form action="/login" method="POST">
                        <div class="modal-body mb-1">
                            <c:if test="${not empty gagal}">
                            <div class="alert alert-danger">
                                ${gagal}
                            </div>
                            </c:if>
                            <div id="warnNotLog" class="alert alert-warning" style="display: none;">
                                Silahkan Login untuk menambahkan Konten!!
                            </div>
                            <div class="md-form form-sm mb-4">
                                <i class="fas fa-user prefix"></i>
                                <b userid class="text-danger small float-right">Enter Your Username...</b>
                                <input name="userid" type="text" id="SIusername" class="form-control form-control-sm validate" maxlength="20">
                                <label data-error="Enter Your Username" data-success="" for="SIusername">Enter Your Username</label>
                            </div>
                            <div class="md-form form-sm mb-4">
                                <i class="fas fa-lock prefix"></i>
                                <b pass class="text-danger small float-right">Enter Your Password...</b>
                                <input name="password" type="password" id="SIpassword" class="form-control form-control-sm validate">
                                <label data-error="Enter Your Password" data-success="" for="SIpassword">Enter Your Password</label>
                            </div>
                            <div class="text-center mt-2">
                                <button id="btnLogin" class="btn btn-primary btn-md" style="color:white;">Login <i class="fas fa-sign-in-alt"></i></button>
                            </div>
                        </div>
                        </form:form>
                        <!--Footer-->
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger btn-sm waves-effect ml-auto" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                    <!--/.Panel 7-->

                    <!--Panel 8-->
                    <div class="tab-pane fade" id="tab2" role="tabpanel">
                        <!--Body-->
                        <div class="modal-body">

                            <div class="md-form form-sm mb-5">
                                <i class="fas fa-user prefix"></i>
                                <b name class="text-danger small float-right">Enter Your Name...</b>
                                <input type="text" id="SUnama" class="form-control form-control-sm validate" maxlength="50">
                                <label data-error="Enter Your Nama" data-success="" for="SUnama">Enter Your Name...</label>
                            </div>
                            
                            <div class="md-form form-sm mb-5">
                                <i class="fas fa-home prefix"></i>
                                <b address class="text-danger small float-right">Enter Your Address...</b>
                                <input type="text" id="SUaddress" class="form-control form-control-sm validate">
                                <label data-error="Enter Your Address" data-success="" for="SUaddress">Enter Your Address...</label>
                            </div>

                            <div class="md-form form-sm mb-5">
                                <i class="far fa-calendar-alt prefix"></i>
                                <b birth class="text-danger small float-right">Enter Your Birth...</b>
                                <input type="text" id="SUbirth" class="form-control form-control-sm validate">
                                <label data-error="Enter Your Birthday" data-success="" for="SUbirth">Enter Your Birth...</label>
                            </div>

                            <div class="md-form form-sm mb-4">
                                <i class="fas fa-user-shield prefix"></i>
                                <b username class="text-danger small float-right">Enter Your Username...</b>
                                <b user class="text-danger small float-right">Username Sudah Dipakai</b>
                                <input type="text" id="SUusername" class="form-control form-control-sm validate" maxlength="20">
                                
                                <label data-error="Enter Your Username" data-success="" for="SUusername">Enter Your Username</label>
                                
                            </div>

                            <div class="md-form form-sm mb-4">
                                <i class="fas fa-lock prefix"></i>
                                <b password class="text-danger small float-right">Enter Your Password...</b>
                                <input type="password" id="SUpassword" class="form-control form-control-sm validate">
                                <label data-error="Enter Your Password" data-success="" for="SUpassword">Enter Your Password</label>
                            </div>

                            <div class="text-center form-sm mt-2">
                                <button id="btnSignUp" class="btn btn-blue btn-md" style="color:white;">Register</button>
                            </div>

                        </div>
                        <!--Footer-->
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger btn-sm waves-effect ml-auto" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                    <!--/.Panel 8-->
                </div>

            </div>
        </div>
        <!--/.Content-->
    </div>
</div>

<jsp:include page="javascript.jsp" />
<!--Modal: Login / Register Form-->
<script>
    $(document).ready(function(){
       $("b[name], b[address], b[birth], b[username], b[password], b[user], b[userid], b[pass]").hide();
       <c:if test="${not empty gagal}">
            $("#btnModsignInUp").trigger("click");
            $("#SIusername").val('${dtUssr}');
            $("#SIusername").attr("autofocus", true);
       </c:if>
    });
    $("#btnModsignInUp").click(function () {
        $("#modalSISU").modal("show");
        $("#SIusername").attr("autofocus", true);
    });
    $('#SUbirth, #EditBirth').datepicker();
//    $(window).scroll(function () {
//        if ($(this).scrollTop() >= 95) {
//            $("nav.navbar-light").addClass("fixed-top");
//        } else if ($(this).scrollTop() < 95) {
//            $("nav.navbar-light").removeClass("fixed-top");
//        }
//    });
    $("#btnLogin").click(function(e){
        $("b[userid], b[pass]").hide();
        ($("#SIusername").val() == "")? $("b[userid]").show() : "";
        ($("#SIpassword").val() == "")? $("b[pass]").show() : "";
        
        if($("#SIusername").val() == "" || $("#SIpassword").val() == ""){
            e.preventDefault(e);
        }
    });
    $("#btnSignUp").click(function () {
        $("b[name], b[address], b[birth], b[username], b[password], b[user]").hide();
        ($("#SUnama").val() == "")? $("b[name]").show() : "";
        ($("#SUaddress").val() == "")? $("b[address]").show() : "";
        ($("#SUbirth").val() == "")? $("b[birth]").show() : "";
        ($("#SUusername").val() == "")? $("b[username]").show() : "";
        ($("#SUpassword").val() == "")? $("b[password]").show() : "";
        
        if($("#SUusername").val() == "" || $("#SUpassword").val() == "" || $("#SUnama").val() == "" || $("#SUbirth").val() == "" || $("#SUaddress").val() == ""){
            
        }else{
            var jsn = {
                "user": $("#SUusername").val(),
                "pass": $("#SUpassword").val(),
                "nama": $("#SUnama").val(),
                "birth": $("#SUbirth").val(),
                "address":$("#SUaddress").val()
            }
            $.post("/addUserprofile", jsn, function (data) {

            }).done(function (data) {
                if(data == "gagal"){
                    $("b[name], b[address], b[birth], b[username], b[password], b[user]").hide();
                    $("b[user]").show();
                }else{
                    ShowModal("#modWarnSuccess");
                    $('#modWarnSuccess').on('hidden.bs.modal', function () {
                        $("a#NavModLog").trigger("click");
                        $("#SUusername, #SUpassword, #SUnama, #SUbirth, #SUaddress").val("");
                        getStatistik();
                    });
                    $("a#NavModLog").trigger("click");
                }
            }).fail(function (xhr, msg, txt) {
//                alert(xhr + msg + txt);
                alert("Upsss.., data not found...");
            });
        }
    });
    $('.dropdown-toggle').dropdown();
    <c:if test="${not empty status}">
    $.get("/foto", function(){
        
    }).done(function(data){
        var img = (data == "")? "user.png" : data;
        $("#navProf").attr("src", "${imgNav}/support/"+img);
    }).fail(function (xhr, msg, txt) {
//        alert(xhr + msg + txt);
        alert("Upsss.., data not found...");
    });
    </c:if>
    
</script>