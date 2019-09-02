/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.forum.controller;

import com.forum.Lib;
import com.forum.model.maStatistik;
import com.forum.repository.RepositoryAdmin;
import java.util.Arrays;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 *
 * @author user
 */

@Controller
public class AdminController {
    
    @Autowired
    RepositoryAdmin repo;
    
    Lib lib = new Lib();
    
    public static boolean cekSession(Model m, HttpServletRequest request, String isi) {
        HttpSession session = request.getSession(true);
        session.setAttribute("user", isi);
        String status = (String) session.getAttribute("user");
        if (status != null) {
            m.addAttribute("status", isi);
            return true;
        }
        return false;
    }
    
    public boolean CekUrl(String url) {
        String[] values = {"/","/detail","/profil","dashboard", "dashboard/user", "dashboard/question", "dashboard/comment", "dashboard/subcomment", "tbl_u", "tbl_q", "tbl_c", "tbl_sc"};
        boolean contains = Arrays.stream(values).anyMatch(url::equals);
        return contains;
    }

    //Selain\\
//    @GetMapping("{url}")
//    public String pindah(@PathVariable String url, Model m, HttpServletRequest request) {
//        if (CekUrl(url) == true) {
//            return "404";
//        }
//        return "404";
//    }
    
    @GetMapping("dashboard")
    public String tampilDashboard(Model m, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        m.addAttribute("data", repo.showStatistik());
        return "admin";
    }
    @PostMapping("/dashboard")
    public String coba(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        Map<String, String> dt = lib.parseHttp(request_data);
//        m.addAttribute("data", dt.get("data[panitia][nama]"));
//        m.addAttribute("data", dt);
//        m.addAttribute("data", request_data);
        return "emptyJSON";
    }
    

    @GetMapping("dashboard/user")
    public String tampilUser(Model m, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        m.addAttribute("data", repo.showUseridProfil());
        return "admin_user";
    }

    @GetMapping("dashboard/question")
    public String tampilQuestion(Model m, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        m.addAttribute("data", repo.showQuestion());
        return "admin_question";
    }

    @GetMapping("dashboard/comment")
    public String tampilComment(Model m, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        m.addAttribute("data", repo.showComment());
        return "admin_comment";
    }

    @GetMapping("dashboard/subcomment")
    public String tampilSubComment(Model m, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        m.addAttribute("data", repo.showSubcomment());
        return "admin_subcomment";
    }
    
    @PostMapping("/ChangeUserid")
    public String ubahUserid(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
        String[] kd = dt.get("kode").split("_");
        if(Integer.parseInt(kd[1]) == 1){
            repo.ubahUseridY(kd[0]);
        }else{
            repo.ubahUseridN(kd[0]);
        }
        m.addAttribute("data", repo.showUseridProfil());
        return "admin_tUser";
    }
    
    @PostMapping("/ChangeQuestion")
    public String ubahQuestion(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
        String[] kd = dt.get("kode").split("_");
        if(Integer.parseInt(kd[1]) == 1){
            repo.ubahQuestionY(kd[0]);
        }else{
            repo.ubahQuestionN(kd[0]);
        }
        
        m.addAttribute("data", repo.showQuestion());
        return "admin_tQuestion";
    }
    
    @PostMapping("/ChangeComment")
    public String ubahComment(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
        String[] kd = dt.get("kode").split("_");
        if(Integer.parseInt(kd[1]) == 1){
            repo.ubahCommentY(kd[0]);
        }else{
            repo.ubahCommentN(kd[0]);
        }
        m.addAttribute("data", repo.showComment());
        return "admin_tComment";
    }
    
    @PostMapping("/ChangeSubComment")
    public String ubahSubComment(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
        String[] kd = dt.get("kode").split("_");
        if(Integer.parseInt(kd[1]) == 1){
            repo.ubahSubcommentY(kd[0]);
        }else{
            repo.ubahSubcommentN(kd[0]);
        }
        m.addAttribute("data", repo.showSubcomment());
        return "admin_tSubcomment";
    }
    
    @GetMapping("tbl_u")
    public String tbU(Model m, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        m.addAttribute("data", repo.showUseridProfil());
        return "admin_tUser";
    }
    
    @GetMapping("tbl_q")
    public String tbQ(Model m, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        m.addAttribute("data", repo.showQuestion());
        return "admin_tQuestion";
    }
    
    @GetMapping("tbl_c")
    public String tbC(Model m, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        m.addAttribute("data", repo.showComment());
        return "admin_tComment";
    }
    
    @GetMapping("tbl_sc")
    public String tbSC(Model m, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            return "404";
        }
        String[] kodeSts = status.split("_");
        if(lib.cmpStr(kodeSts[0], "admin") == false && lib.cmpStr(kodeSts[1], "1") == false){
            return "404";
        }
        
        m.addAttribute("data", repo.showSubcomment());
        return "admin_tSubcomment";
    }
    
}
