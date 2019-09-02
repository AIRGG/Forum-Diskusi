<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="../dist" var="distCSS" />

<!--<link rel="icon" href="dist/img/support/tabicon.png">-->
<link rel="stylesheet" href="${distCSS}/fa/css/fontawesome.css">
<link rel="stylesheet" href="${distCSS}/css/bootstrap.min.css">
<link rel="stylesheet" href="${distCSS}/css/mdb.min.css">
<link rel="stylesheet" href="${distCSS}/css/jquery-ui.css">
<link rel="stylesheet" href="${distCSS}/css/datatables.min.css">

<style>
    .sidebar-fixed {
        height: 100vh;
        width: 270px;
        -webkit-box-shadow: 0 2px 5px 0 rgba(0, 0, 0, .16), 0 2px 10px 0 rgba(0, 0, 0, .12);
        box-shadow: 0 2px 5px 0 rgba(0, 0, 0, .16), 0 2px 10px 0 rgba(0, 0, 0, .12);
        z-index: 1050;
        background-color: #fff;
        padding: 0 1.5rem 1.5rem
    }
    .sidebar-fixed .list-group .active {
        -webkit-box-shadow: 0 2px 5px 0 rgba(0, 0, 0, .16), 0 2px 10px 0 rgba(0, 0, 0, .12);
        box-shadow: 0 2px 5px 0 rgba(0, 0, 0, .16), 0 2px 10px 0 rgba(0, 0, 0, .12);
        -webkit-border-radius: 5px;
        border-radius: 5px
    }
    .sidebar-fixed .logo-wrapper {
        padding: 2.5rem
    }
    .sidebar-fixed .logo-wrapper img {
        max-height: 50px
    }
    @media (min-width: 1200px) {
        .navbar,
        .page-footer,
        main {
            padding-left: 270px
        }
    }
    @media (max-width: 1199.98px) {
        .sidebar-fixed {
            display: none
        }
    }
    .map-container{
        overflow:hidden;
        padding-bottom:56.25%;
        position:relative;
        height:0;
    }
    .map-container iframe{
        left:0;
        top:0;
        height:100%;
        width:100%;
        position:absolute;
    }
    #jam:hover{
        cursor: pointer;
        box-shadow: 0px 0px 10px #1c71ff;
        background-color: transparent;
        border-radius: 10px 10px 10px 10px;
        padding: 10px;
        transition: 0.2s;
    }
    #jam{
        
        transition: 0.2s;
    }
    .admin{
        text-decoration: none;
        cursor: default;
    }
</style>