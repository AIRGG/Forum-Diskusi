/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.forum.controller;

import com.forum.Lib;
import com.forum.json.JSONObject;
import com.forum.model.mComment;
import com.forum.model.mQuestion;
import com.forum.model.mStatistik;
import com.forum.model.mSubcomment;
import com.forum.model.mUserprofile;
import com.forum.repository.RepositoryData;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author user
 */
@Controller
public class RoutingController {

    @Autowired
    RepositoryData repo;
    
    //** Mengaktifkan Bantuan Library **\\
    public Lib lib = new Lib();
    
    //** Cek Session saat ini **\\
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

    // ** Pengaturan URL ** \\
    int batas = 8;
    @GetMapping("/")
    public String tampilHalamanUtama(Model m, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        String dummy = "usr_1_1";
        String[] usr = (status == "" || status == null)? dummy.split("_") : status.split("_");
        m.addAttribute("jmlDt", repo.getCountQuestion());
        m.addAttribute("usr", usr[0]);
        m.addAttribute("batas", batas);
        return "index";
    }

    @GetMapping("/detail")
    public String tampilDetail(Model m, @RequestParam Map<String, String> url, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        mQuestion dtQ = repo.showEditQuestion(url.get("id"));
        if(dtQ == null){
            m.addAttribute("dataQ", "gagal");
        }else{
            m.addAttribute("dataQ", dtQ);
            m.addAttribute("dataC", repo.showComment(url.get("id")));
            m.addAttribute("dataSC", repo.showSubcomment(url.get("id")));
        }
        
        return "detail";
    }

    @GetMapping("/profil")
    public String tampilProfil(Model m, @RequestParam Map<String, String> url, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        m.addAttribute("dataP", repo.getUseridProfil(url.get("userid")));
        m.addAttribute("dataQ", repo.getQuestionProfil(url.get("userid")));
        return "profil";
    }

    // ** Tampil Data ** \\
    @GetMapping("/showQuestion")
    public String ShowQuestion(Model m, HttpServletRequest request, @RequestParam Map<String, String> url) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        int posisi;
        if(Integer.parseInt(url.get("page")) < 1 || Integer.parseInt(url.get("page")) == 0){
            posisi = (1-1)*batas;
        }else{
            posisi = (Integer.parseInt(url.get("page"))-1)*batas;
        }
        
        
        m.addAttribute("data", repo.showQuestion(posisi, batas));
        return "t_question";
    }

    @GetMapping("/showStatistics")
    public String ShowStatistics(Model m, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        mStatistik data = repo.showStatistik();
        JSONObject jsn = new JSONObject();
        jsn.put("member", data.getMember());
        jsn.put("replies", data.getReplies());
        jsn.put("thread", data.getThread());

        m.addAttribute("data", jsn);
        return "emptyJSON";
    }
    
    @PostMapping("/search")
    public String ShowSearchQ(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
//        String[] req = request_data.split("=");
        
        List<mQuestion> isi = repo.showSearchQ(dt.get("kode"));
        m.addAttribute("data", isi);
        m.addAttribute("isi", dt.get("kode"));
        return "t_question";
    }

    @PostMapping("/showEditQ")
    public String ShowEditQ(Model m, @RequestBody String request_data, BindingResult bindingResult, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        Map<String, String> dt = lib.parseHttp(request_data);

        mQuestion data = repo.showEditQuestion(dt.get("kode"));
        if(bindingResult.hasErrors()){
            m.addAttribute("data", data.getUserid());
            return "emptyJSON";
        }
        JSONObject jsn = new JSONObject();
        jsn.put("id_q", (data.getId_question() == 0) ? "" : data.getId_question());
        jsn.put("userid", (data.getUserid() == null) ? "" : data.getUserid());
        jsn.put("judul", (data.getJudul() == null) ? "" : data.getJudul());
        jsn.put("konten", (data.getKonten() == null) ? "" : data.getKonten());
        jsn.put("img", (data.getImg() == null) ? "" : data.getImg());

        m.addAttribute("data", jsn);
        return "emptyJSON";
    }
    
    @PostMapping("/showEditC")
    public String showEditC(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
        mComment data = repo.getComment(dt.get("kode"));
        
        JSONObject jsn = new JSONObject();
        jsn.put("konten", (data.getKonten() == null)? "" : data.getKonten());
        jsn.put("img", (data.getImg() == null)? "" : data.getImg());
        
        m.addAttribute("data", jsn);
        return "emptyJSON";
    }
    
    @PostMapping("/showEditSC")
    public String showEditSC(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
        mSubcomment data = repo.getSubComment(dt.get("kode"));
        
        JSONObject jsn = new JSONObject();
        jsn.put("konten", data.getKonten());
        
        m.addAttribute("data", jsn);
        return "emptyJSON";
    }

    // ** Proses Data ** \\
    @PostMapping("/addQuestion")
    public String AddQuestion(Model m, @ModelAttribute mQuestion dForm, BindingResult bindingResult, @RequestParam Map<String, MultipartFile> files, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        String path = "\\src\\main\\resources\\static\\dist\\img";
        String[] userid = status.split("_");
        String[] tgl = tglJam().split(" ");
        
        try {
            String var = files.get("imgQuestion").getOriginalFilename();
            byte[] var1 = files.get("imgQuestion").getBytes();
            if (files.get("imgQuestion").getOriginalFilename() != null || files.get("imgQuestion").getOriginalFilename() == "") {
                lib.writeFile(var, var1, path);
            }
        } catch (IOException e) {
            System.out.println(String.format("Warning: cannot writefile %s", files.get("imgQuestion").getOriginalFilename()));
        }

        JSONObject jsn = new JSONObject();
        jsn.put("userid", userid[0]);
        jsn.put("tgl", tgl[0]);
        jsn.put("jam", tgl[1]);
        jsn.put("judul", (dForm.getJudul() == null) ? "" : (dForm.getJudul().length() > 100)? dForm.getJudul().substring(0, 100) : dForm.getJudul());
        jsn.put("konten", (dForm.getKonten() == null) ? "" : dForm.getKonten());
        jsn.put("img", (files.get("imgQuestion").getOriginalFilename() == null) ? "" : files.get("imgQuestion").getOriginalFilename());
        jsn.put("status", 1);

        repo.AddQuestion(jsn);

        return "redirect:/";
    }
    
    @PostMapping("/addComment")
    public String AddComment(Model m, @ModelAttribute mComment dForm, BindingResult bindingResult, @RequestParam Map<String, MultipartFile> files, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        String path = "\\src\\main\\resources\\static\\dist\\img";
        String[] userid = status.split("_");
        String[] tglJ = tglJam().split(" ");
        
        try {
            String var = files.get("imgComment").getOriginalFilename();
            byte[] var1 = files.get("imgComment").getBytes();
            if (files.get("imgComment").getOriginalFilename() != null || files.get("imgComment").getOriginalFilename() == "") {
                lib.writeFile(var, var1, path);
            }
        } catch (IOException e) {
            System.out.println(String.format("Warning: cannot writefile %s", files.get("imgComment").getOriginalFilename()));
        }
        
        JSONObject jsn = new JSONObject();
        jsn.put("id_q", dForm.getId_question());
        jsn.put("user", userid[0]);
        jsn.put("tgl", tglJ[0]);
        jsn.put("jam", tglJ[1]);
        jsn.put("konten", (dForm.getKonten() == null)? "" : dForm.getKonten());
        jsn.put("img", (lib.cmpStr(files.get("imgComment").getOriginalFilename(), "") == true)? "" : files.get("imgComment").getOriginalFilename());
        jsn.put("sts", 1);
        
        repo.AddComment(jsn);
        
        m.addAttribute("data", jsn);
        return "redirect:detail?id="+dForm.getId_question();
    }
    
    @PostMapping("/addSubcomment")
    public String AddSubcomment(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
        String[] kd = dt.get("kode").split("_");
        String[] userid = status.split("_");
        String[] tglJ = tglJam().split(" ");
        
        JSONObject jsn = new JSONObject();
        jsn.put("id_c", kd[1]);
        jsn.put("id_q", kd[0]);
        jsn.put("user", userid[0]);
        jsn.put("tgl", tglJ[0]);
        jsn.put("jam", tglJ[1]);
        jsn.put("konten", dt.get("konten"));
        jsn.put("sts", 1);
        
        repo.AddSubcomment(jsn);
        
        return "emptyJSON";
    }
    
    @PostMapping("/editQ")
    public String EditQuestion(Model m, @ModelAttribute mQuestion dForm, BindingResult bindingResult, @RequestParam Map<String, MultipartFile> files, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        String path = "\\src\\main\\resources\\static\\dist\\img";
        String[] userid = status.split("_");
        String[] tgl = tglJam().split(" ");
        
        try {
            String var = files.get("imgQuestion").getOriginalFilename();
            byte[] var1 = files.get("imgQuestion").getBytes();
            if (files.get("imgQuestion").getOriginalFilename() != null || files.get("imgQuestion").getOriginalFilename() == "") {
                lib.writeFile(var, var1, path);
            }
        } catch (IOException e) {
            System.out.println(String.format("Warning: cannot writefile %s", files.get("imgQuestion").getOriginalFilename()));
        }
        
        JSONObject jsn = new JSONObject();
        jsn.put("id_q", (dForm.getId_question() == 0)? 0 : dForm.getId_question() );
        jsn.put("userid", userid[0]);
        jsn.put("tgl", tgl[0]);
        jsn.put("jam", tgl[1]);
        jsn.put("judul", (dForm.getJudul() == null)? "" : (dForm.getJudul().length() > 100)? dForm.getJudul().substring(0, 100) : dForm.getJudul());
        jsn.put("konten", (dForm.getKonten() == null)? "" : dForm.getKonten());
        jsn.put("img", (lib.cmpStr(files.get("imgQuestion").getOriginalFilename(), "") == true)? dForm.getImg() : files.get("imgQuestion").getOriginalFilename());
        jsn.put("sts", 1);
        
        repo.EditQuestion(jsn);

        if(lib.cmpStr(dForm.getTgl(), "/") == true){
            return "redirect:/";
        }
        if(lib.cmpStr(dForm.getTgl(), "/profil") == true){
            return "redirect:"+dForm.getTgl()+"?userid="+userid[0];
        }
        if(lib.cmpStr(dForm.getTgl(), "/detail") == true){
            return "redirect:"+dForm.getTgl()+"?id="+dForm.getId_question();
        }
        return "redirect:/";
    }
    
    @PostMapping("/editComment")    
    public String EditComment(Model m, @ModelAttribute mComment dForm, BindingResult bindingResult, @RequestParam Map<String, MultipartFile> files, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        String path = "\\src\\main\\resources\\static\\dist\\img";
        String[] userid = status.split("_");
        String[] tglJ = tglJam().split(" ");
        
        JSONObject jsn = new JSONObject();
        jsn.put("tgl", tglJ[0]);
        jsn.put("jam", tglJ[1]);
        jsn.put("konten", (dForm.getKonten() == null)? "" : dForm.getKonten());
        jsn.put("img", (lib.cmpStr(files.get("imgComment").getOriginalFilename(), "") == true)? dForm.getImg() : files.get("imgComment").getOriginalFilename());
        jsn.put("id_c", dForm.getId_comment());
        
        repo.EditComment(jsn);
        
        return "redirect:detail?id="+dForm.getId_question();
    }
    
    @PostMapping("/editSubcomment")
    public String EditSubcomment(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
        String[] tglJ = tglJam().split(" ");
        
        JSONObject jsn = new JSONObject();
        jsn.put("tgl", tglJ[0]);
        jsn.put("jam", tglJ[1]);
        jsn.put("konten", dt.get("konten"));
        jsn.put("kode", dt.get("kode"));
        
        repo.EditSubcomment(jsn);
        
        return "emptyJSON";
    }
    @PostMapping("/delQuestion")
    public String DelQuestion(Model m, @RequestBody String request_data, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);

        repo.DelQuestion(dt.get("kode"));
        repo.DelCommentQ(dt.get("kode"));
        repo.DelSubcommentQ(dt.get("kode"));

        m.addAttribute("data", repo.showQuestion(1, 5));
        return "t_question";
    }
    
    @PostMapping("/delComment")
    public String DelComment(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
        
        repo.DelComment(dt.get("kode"));
        repo.DelSubcommentC(dt.get("kode"));
        
        m.addAttribute("data", "success");
        return "emptyJSON";
    }    
    
    @PostMapping("/delSubcomment")
    public String DelSubComment(Model m, @RequestBody String request_data, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
        repo.DelSubcomment(dt.get("kode"));
        
        return "emptyJSON";
    }
    
    //** Management User **\\
    @PostMapping("/addUserprofile")
    public String AddUserprofile(Model m, @RequestBody String request_data, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        Map<String, String> dt = lib.parseHttp(request_data);
        String[] dob = dt.get("birth").split("/");

        JSONObject jsn = new JSONObject();
        jsn.put("user", (dt.get("user") == null)? "" : dt.get("user"));
        jsn.put("pass", (dt.get("pass") == null)? "" : dt.get("pass"));
        jsn.put("nama", (dt.get("nama") == null)? "" : dt.get("nama"));
        jsn.put("birth", (dt.get("birth") == null)? "" : dob[1] + "" + dob[0] + "" + dob[2]);
        jsn.put("address", (dt.get("address") == null)? "" : dt.get("address"));
        jsn.put("img", getImage(randNumber())+".jpg");
        jsn.put("role", 2);
        jsn.put("acces", 1);
        
        boolean data = repo.cekUserid(dt.get("user"));
        if (data == false) {
            m.addAttribute("data", "gagal");
            return "emptyJSON";
        }
        
        m.addAttribute("data", repo.AddUserprofil(jsn));
        return "emptyJSON";
    }
    
    @PostMapping("/editProfil")
    public String EditProfil(Model m, @ModelAttribute mUserprofile dForm, BindingResult bindingResult, @RequestParam Map<String, MultipartFile> files, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        
        String path = "\\src\\main\\resources\\static\\dist\\img\\support";
        String[] userid = status.split("_");
        String tgl = "00/00/0000";
        String[] dob = (lib.cmpStr(dForm.getDob(), "") == true)? tgl.split("/") : dForm.getDob().split("/");
        
        try {
            String var = files.get("imgProfil").getOriginalFilename();
            byte[] var1 = files.get("imgProfil").getBytes();
            if (files.get("imgProfil").getOriginalFilename() != null || files.get("imgProfil").getOriginalFilename() == "") {
                lib.writeFile(var, var1, path);
            }
        } catch (IOException e) {
            System.out.println(String.format("Warning: cannot writefile %s", files.get("imgProfil").getOriginalFilename()));
        }
        
        mUserprofile dtPw = repo.getUseridProfil(dForm.getUserid());
        
        JSONObject jsn = new JSONObject();
        jsn.put("user", dForm.getUserid());
        jsn.put("nama", dForm.getNama());
        jsn.put("birth", dob[0]+""+dob[1]+""+dob[2]);
        jsn.put("address", dForm.getAddress());
        jsn.put("img", (lib.cmpStr(files.get("imgProfil").getOriginalFilename(), "") == true)? dForm.getImage() : files.get("imgProfil").getOriginalFilename());
        jsn.put("pass", (lib.cmpStr(dForm.getPassword(), "") == true)? dtPw.getPassword() : dForm.getPassword());
        
        repo.EditUserprofil(jsn);
        return "redirect:/profil?userid="+dForm.getUserid();
    }
    
    //** Login/Logout **\\
    @PostMapping("/login")
    public String Login(Model m, @ModelAttribute mUserprofile dForm, BindingResult bindingResult, HttpServletRequest request){
        JSONObject jsn = new JSONObject();
        jsn.put("user", dForm.getUserid());
        jsn.put("pass", dForm.getPassword());
        
        mUserprofile log = null;
        if(lib.cmpStr(dForm.getUserid(), "admin") == true){
            log = repo.loginAdmin(jsn);
            if(log == null){
                m.addAttribute("gagal", "Gagal Login, Username Atau Password Salah");
                m.addAttribute("dtUssr", dForm.getUserid());
                return "index";
            }
            String imgg = (log.getImage() == null)? "" : log.getImage();
            cekSession(m, request, log.getUserid()+"_"+log.getRole()+"_"+imgg);
            return "redirect:/dashboard";
        }else{
            log = repo.login(jsn);
            if(log == null){
                m.addAttribute("gagal", "Gagal Login, Username Atau Password Salah!!");
                m.addAttribute("dtUssr", dForm.getUserid());
                return "index";
            }
            if(log.getAcces() == 2){
                m.addAttribute("gagal", "Maaf, Akun anda Sudah di Blokir oleh ADMIN!!");
                m.addAttribute("dtUssr", dForm.getUserid());
                return "index";
            }
            String imgg = (log.getImage() == null)? "" : log.getImage();
            cekSession(m, request, log.getUserid()+"_"+log.getRole()+"_"+imgg);
            return "redirect:/";
        }
        
    }
    
    @GetMapping("/logout")
    public String logout(Model m, HttpServletRequest request){
        cekSession(m, request, null);
        return "redirect:/";
    }
    
    // ** Fungsi Bantuan ** \\
    @GetMapping("/foto")
    public String img(Model m, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        String status = (String) session.getAttribute("user");
        if(cekSession(m, request, status) == false){
            
        }
        String[] uid = status.split("_");
        mUserprofile dt = repo.getUseridProfil(uid[0]);
        m.addAttribute("data", dt.getImage());
        return "emptyJSON";
    }
    
    public String tglJam() {
        String pattern = "ddMMyyyy HHmmss";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        String date = simpleDateFormat.format(new Date());
        return date;
    }
    
    public int randNumber(){
        Random rand = new Random();
        int n = rand.nextInt(10);
        return n;
    }
    
    public String getImage(int rand){
        String[] img = {"chris", "daniel", "elliot", "justen", "steve", "ade", "helen", "jenny", "nan", "stevie", "veronika"};
        return img[rand];
    }
}
