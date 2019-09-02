<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="dist/img" var="img" />
<!-- Sidebar -->
<div class="sidebar-fixed position-fixed">
    <a class="logo-wrapper waves-effect admin" onclick="home()">
        <h1 id="jam">ADMIN</h1>
    </a>
    <div class="list-group list-group-flush">
        <!--        <a href="/dashboard" class="list-group-item active waves-effect">
                  <i class="fas fa-chart-pie mr-3"></i>Dashboard
                </a>-->
        <a href="/dashboard" class="list-group-item list-group-item-action waves-effect" style="margin-top: 40px;">
            <i class="fas fa-chart-pie mr-3"></i>Dashboard
        </a>
        <a href="/dashboard/user" class="list-group-item list-group-item-action waves-effect" style="margin-top: 40px;">
            <i class="fas fa-user mr-3"></i>User
        </a>
        <a href="/dashboard/question" class="list-group-item list-group-item-action waves-effect">
            <i class="fas fa-question mr-3"></i>Question
        </a>
        <a href="/dashboard/comment" class="list-group-item list-group-item-action waves-effect">
            <i class="fas fa-comment mr-3"></i>Comment
        </a>
        <a href="/dashboard/subcomment" class="list-group-item list-group-item-action waves-effect">
            <i class="fas fa-comments mr-3"></i>SubComment</a>
        <a href="/" class="list-group-item list-group-item-action waves-effect" style="margin-top: 50px;">
            <i class="fa fa-external-link-alt"></i> Beranda
        </a>
        <a href="/logout" class="list-group-item list-group-item-action waves-effect">
            <i class="fas fa-sign-out-alt mr-3" style="color: #e74c3c;"></i>Logout
        </a>
    </div>
</div>
<!-- Sidebar -->
<!--Main Navigation-->
<script>
//    setInterval(myTimer, 1000);
//    function myTimer() {
//        var d = new Date();
//        var t = d.toLocaleTimeString();
//        document.getElementById("jam").innerHTML = t.substr(0, 8);
//    }
function home(){
    location.href="http://localhost:8000/dashboard";
}
</script>