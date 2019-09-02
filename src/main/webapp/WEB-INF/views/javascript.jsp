<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="../dist" var="distJS" />

<!-- JQuery -->
<script type="text/javascript" src="${distJS}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${distJS}/js/jquery-ui.js"></script>
<script type="text/javascript" src="${distJS}/js/popper.min.js"></script>
<script type="text/javascript" src="${distJS}/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${distJS}/js/mdb.min.js"></script>
<script type="text/javascript" src="${distJS}/js/wow.js"></script>
<script type="text/javascript" src="${distJS}/js/datatables.min.js"></script>

<script>
    var url = "${requestScope['javax.servlet.forward.request_uri']}";
    function ShowModal(namaMod) {
        var nm = namaMod.substring(0, 1);
        if (nm !== "#" || nm != "#") {
            $("#" + namaMod).modal("show");
        } else {
            $(namaMod).modal("show");
        }
    }
    function HideModal(namaMod) {
        var nm = namaMod.substring(0, 1);
        if (nm !== "#" || nm != "#") {
            $("#" + namaMod).modal("hide");
        } else {
            $(namaMod).modal("hide");
        }
    }
    function openNav(id) {
        $("#Edit" + id + ", #Delete" + id).show();;
    }
    function openNavC(id) {
        $("#EditC" + id + ", #DeleteC" + id).show();
    }
    function openNavSC(id) {
        $("#EditSC" + id + ", #DeleteSC" + id).show();
    }
    
    function toggleNav(id) {
        $("#Edit" + id + ", #Delete" + id).toggle();
    }
    function toggleNavC(id) {
        $("#EditC" + id + ", #DeleteC" + id).toggle();
    }
    function toggleNavSC(id) {
        $("#EditSC" + id + ", #DeleteSC" + id).toggle();
    }
    
    function openWarningC(id) {
        ShowModal("#modWarningDel");
        $("#yes").click(function () {
            HideModal("#modWarningDel");
            $.post("/delComment", {"kode": id}, function () {

            }).done(function (data) {
                ShowModal("#modWarnSuccess");
                $('#modWarnSuccess').on('hidden.bs.modal', function (e) {
                    location.reload(true);
                });
            }).fail(function (xhr, msg, txt) {
//                alert(xhr + msg + txt);
//                alert("Upsss.., data not found...");
            });
        });
    }
    function openWarningSC(id) {
        ShowModal("#modWarningDel");
        $("#yes").click(function () {
            HideModal("#modWarningDel");
            $.post("/delSubcomment", {"kode": id}, function () {

            }).done(function (data) {
                ShowModal("#modWarnSuccess");
                $('#modWarnSuccess').on('hidden.bs.modal', function (e) {
                    location.reload(true);
                });
            }).fail(function (xhr, msg, txt) {
//                alert(xhr + msg + txt);
//                alert("Upsss.., data not found...");
            });
        });
//        ShowModal("#modWarningDel, #modWarnSuccess");
    }
    function openWarningQ(id) {
        ShowModal("#modWarningDel");
        $("#yes").click(function () {
            HideModal("#modWarningDel");
            $.post("/delQuestion", {"kode": id}, function () {

            }).done(function (data) {
                ShowModal("#modWarnSuccess");
                $('#modWarnSuccess').on('hidden.bs.modal', function (e) {
                    if (url == "/profil") {
                        location.reload(true);
                    } else if (url == "/") {
                        $("#t_question").empty();
                        $("#t_question").html(data);
                    } else if (url == "/detail") {
                        location.reload(true);
                    }
                });
            }).fail(function (xhr, msg, txt) {
//                alert(xhr.responseText + msg + txt);
//                alert("Upsss.., data not found...");
            });
        });
    }
    function openEditQ(id) {
        $.post("/showEditQ", {"kode": id}, function () {

        }).done(function (data) {
            var jsn = JSON.parse(data);
            $("#Editquestion").val(jsn["judul"]);
            $("#Editsubquestion").val(jsn["konten"]);
            $("input[name='img']").val(jsn["img"]);
            $("input[name='id_question']").val(jsn["id_q"]);
            $("input[name='tgl']").val(url);
            ShowModal("#modEditQueSub");
        }).fail(function (xhr, msg, txt) {
//            alert(xhr + msg + txt);
//            alert("Upsss.., data not found... Q");
        });
    }

    function openWarningUsrA(id) {
        ShowModal("#modWarningDel, #modWarnSuccess");
    }
    
    function cleanURL(url){
        var rgx = /[`~!@#$%^&*()_|+\-;'",.\{\}\[\]\\]+/gi;
        var rgxHTMLTgs = /(<([^>]+)>)+/gi;
        var result = (url.replace(rgx, "")).replace(rgxHTMLTgs, "");
        return result;
    }
</script>