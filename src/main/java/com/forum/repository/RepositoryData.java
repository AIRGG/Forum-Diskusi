/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.forum.repository;

import com.forum.json.JSONObject;
import com.forum.model.mComment;
import com.forum.model.mQuestion;
import com.forum.model.mStatistik;
import com.forum.model.mSubcomment;
import com.forum.model.mUserprofile;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

/**
 *
 * @author user
 */
@Repository
public class RepositoryData {

    @Autowired
    JdbcTemplate jdbc;

    // ** Tampil Data Banyak ** \\
    public List<mQuestion> showQuestion(int lmt1, int lmt2) {
        List<mQuestion> data = jdbc.query("SELECT *, ((SELECT count(b.konten) FROM comment b WHERE b.id_question=a.id_question AND b.status=1)+(SELECT count(d.konten) FROM subcomment d WHERE d.id_question=a.id_question AND d.status=1)) AS jml, (SELECT u.nama FROM comment c INNER JOIN userprofile u ON c.userid=u.userid WHERE c.id_question=a.id_question AND c.status=1 ORDER BY c.id_comment DESC LIMIT 1) AS nm FROM question a INNER JOIN userprofile e ON a.userid=e.userid WHERE status=1 ORDER By id_question DESC LIMIT ?, ?",
                new Object[]{lmt1, lmt2}, new dataQuestionMapper());
        return data;
    }
    
    public mQuestion getCountQuestion() {
        List<mQuestion> data = jdbc.query("SELECT *, ((SELECT count(b.konten) FROM comment b WHERE b.id_question=a.id_question)+(SELECT count(d.konten) FROM subcomment d WHERE d.id_question=a.id_question)) AS jml, COUNT(a.konten) AS nm FROM question a INNER JOIN userprofile e ON a.userid=e.userid WHERE status=1 ORDER By id_question DESC",
                new Object[]{}, new dataQuestionMapper());
        return data.get(0);
    }
    
    public List<mComment> showComment(String kd){
        List<mComment> data = jdbc.query("SELECT *, (SELECT b.nama FROM userprofile b WHERE b.userid=a.userid) AS nama, (SELECT b.image FROM userprofile b WHERE b.userid=a.userid) AS image FROM comment a WHERE a.status='1' AND a.id_question=?",
                new Object[]{kd}, new dataCommentMapper());
        return data;
    }
    
    public List<mSubcomment> showSubcomment(String kd){
        List<mSubcomment> data = jdbc.query("SELECT *, (SELECT b.nama FROM userprofile b WHERE b.userid=a.userid) AS nama, (SELECT b.image FROM userprofile b WHERE b.userid=a.userid) AS image FROM subcomment a WHERE a.status='1' AND a.id_question=?",
                new Object[]{kd}, new dataSubcommentMapper());
        return data;
    }
    
    public List<mQuestion> showSearchQ(String kode){
        List<mQuestion> data = jdbc.query("SELECT *, ((SELECT count(b.konten) FROM comment b WHERE b.id_question=a.id_question)+(SELECT count(d.konten) FROM subcomment d WHERE d.id_question=a.id_question)) AS jml, (SELECT u.nama FROM comment c INNER JOIN userprofile u ON c.userid=u.userid WHERE c.id_question=a.id_question ORDER BY c.id_comment DESC LIMIT 1) AS nm FROM question a INNER JOIN userprofile e ON a.userid=e.userid WHERE status=1 AND judul LIKE ? OR konten LIKE ? ORDER By id_question DESC",
                new Object[]{"%"+kode+"%", "%"+kode+"%"}, new dataQuestionMapper());
        return data;
    }

    public mQuestion showEditQuestion(String kd) {
        List<mQuestion> data = jdbc.query("SELECT *, ((SELECT count(b.konten) FROM comment b WHERE b.id_question=a.id_question AND b.status=1)+(SELECT count(d.konten) FROM subcomment d WHERE d.id_question=a.id_question AND d.status=1)) AS jml, (SELECT u.nama FROM comment c INNER JOIN userprofile u ON c.userid=u.userid WHERE c.id_question=a.id_question AND c.status=1 ORDER BY c.id_comment DESC LIMIT 1) AS nm FROM question a INNER JOIN userprofile e ON a.userid=e.userid WHERE status=1 AND id_question=?",
                new Object[]{kd}, new dataQuestionMapper());
        if (data.isEmpty()) {
            return null;
        }
        return data.get(0);
    }
    
    public List<mQuestion> getQuestionProfil(String uid) {
        List<mQuestion> data = jdbc.query("SELECT *, ((SELECT count(b.konten) FROM comment b WHERE b.id_question=a.id_question AND b.status=1)+(SELECT count(d.konten) FROM subcomment d WHERE d.id_question=a.id_question AND d.status=1)) AS jml, (SELECT u.nama FROM comment c INNER JOIN userprofile u ON c.userid=u.userid WHERE c.id_question=a.id_question AND c.status=1 ORDER BY c.id_comment DESC LIMIT 1) AS nm FROM question a INNER JOIN userprofile e ON a.userid=e.userid WHERE status=1 AND a.userid=? ORDER By id_question DESC",
                new Object[]{uid}, new dataQuestionMapper());
        return data;
    }
    
    public mUserprofile getUseridProfil(String uid) {
        List<mUserprofile> data = jdbc.query("SELECT * FROM userprofile WHERE userid=?",
                new Object[]{uid}, new dataUserprofileMapper());
        if (data.isEmpty()) {
            return null;
        }
        return data.get(0);
    }
    
    public mComment getComment(String kd){
        List<mComment> data = jdbc.query("SELECT *, (SELECT b.nama FROM userprofile b WHERE b.userid=a.userid) AS nama, (SELECT b.image FROM userprofile b WHERE b.userid=a.userid) AS image FROM comment a WHERE a.status='1' AND a.id_comment=?",
                new Object[]{kd}, new dataCommentMapper());
        if(data.isEmpty()){
            return null;
        }
        return data.get(0);
    }
    
    public mSubcomment getSubComment(String kd){
        List<mSubcomment> data = jdbc.query("SELECT *, (SELECT b.nama FROM userprofile b WHERE b.userid=a.userid) AS nama, (SELECT b.image FROM userprofile b WHERE b.userid=a.userid) AS image FROM subcomment a WHERE a.status='1' AND a.id_subcomment=?",
                new Object[]{kd}, new dataSubcommentMapper());
        if(data.isEmpty()){
            return null;
        }
        return data.get(0);
    }

    public mStatistik showStatistik() {
        List<mStatistik> data = jdbc.query("SELECT count(userid) AS member, (SELECT count(id_question) FROM question WHERE status = 1) AS threads, (SELECT count(id_comment) FROM comment WHERE status = 1)+(SELECT count(id_subcomment) FROM subcomment WHERE status = 1) AS replies FROM userprofile WHERE acces = 1",
                new Object[]{}, new dataStatistikMapper());
        if (data.isEmpty()) {
            return null;
        }
        return data.get(0);
    }

    public boolean cekUserid(String uid) {
        List<mUserprofile> data = jdbc.query("SELECT * FROM userprofile WHERE userid=?",
                new Object[]{uid}, new dataUserprofileMapper());
        if (data.isEmpty()) {
            return true;
        }
        return false;
    }

    // ** Proses Data ** \\
    public int AddQuestion(JSONObject jsn) {
        return jdbc.update("INSERT INTO question (id_question, userid, tgl, jam, judul, konten, img, status) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?)",
                new Object[]{
                    jsn.get("userid"),
                    jsn.get("tgl"),
                    jsn.get("jam"),
                    jsn.get("judul"),
                    jsn.get("konten"),
                    jsn.get("img"),
                    jsn.get("status")
                });
    }
    
    public int EditQuestion(JSONObject jsn){
        return jdbc.update("UPDATE question SET userid = ?, tgl = ?, jam = ?, judul = ?, konten = ?, img = ?, status = ? WHERE id_question = ?",
                new Object[]{
                    jsn.get("userid"),
                    jsn.get("tgl"),
                    jsn.get("jam"),
                    jsn.get("judul"),
                    jsn.get("konten"),
                    jsn.get("img"),
                    jsn.get("sts"),
                    jsn.get("id_q")
                });
    }

    public int AddUserprofil(JSONObject jsn) {
        return jdbc.update("INSERT INTO userprofile (userid, password, nama, dob, address, image, acces, role) VALUES (?,?,?,?,?,?,?,?)",
                new Object[]{
                    jsn.get("user"),
                    jsn.get("pass"),
                    jsn.get("nama"),
                    jsn.get("birth"),
                    jsn.get("address"),
                    jsn.get("img"),
                    jsn.get("acces"),
                    jsn.get("role")
                });
    }
    
    public int EditUserprofil(JSONObject jsn){
        return jdbc.update("UPDATE userprofile SET password = ?, nama = ?, dob = ?, address = ?, image = ? WHERE userid = ?",
                new Object[]{
                    jsn.get("pass"),
                    jsn.get("nama"),
                    jsn.get("birth"),
                    jsn.get("address"),
                    jsn.get("img"),
                    jsn.get("user")
                });
    }
    
    public int AddComment(JSONObject jsn){
        return jdbc.update("INSERT INTO comment (id_comment, id_question, userid, tgl, jam, konten, img, status) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?)",
                new Object[]{
                    jsn.get("id_q"),
                    jsn.get("user"),
                    jsn.get("tgl"),
                    jsn.get("jam"),
                    jsn.get("konten"),
                    jsn.get("img"),
                    jsn.get("sts"),
                });
    }
    
    public int AddSubcomment(JSONObject jsn){
        return jdbc.update("INSERT INTO subcomment (id_subcomment, id_comment, id_question, userid, tgl, jam, konten, status) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?)",
                new Object[]{
                    jsn.get("id_c"),
                    jsn.get("id_q"),
                    jsn.get("user"),
                    jsn.get("tgl"),
                    jsn.get("jam"),
                    jsn.get("konten"),
                    jsn.get("sts")
                });
    }
    
    public int EditComment(JSONObject jsn){
        return jdbc.update("UPDATE comment SET tgl = ?, jam = ?, konten = ?, img = ? WHERE id_comment = ?",
                new Object[]{
                    jsn.get("tgl"),
                    jsn.get("jam"),
                    jsn.get("konten"),
                    jsn.get("img"),
                    jsn.get("id_c")
                });
    }
    
    public int EditSubcomment(JSONObject jsn){
        return jdbc.update("UPDATE subcomment SET tgl = ?, jam = ?, konten = ? WHERE id_subcomment = ?",
                new Object[]{
                    jsn.get("tgl"),
                    jsn.get("jam"),
                    jsn.get("konten"),
                    jsn.get("kode"),
                });
    }
    
    public int DelComment(String kode){
        return jdbc.update("UPDATE comment a SET status = '0' WHERE a.id_comment = ?",
                new Object[]{kode});
    }
    
    public int DelCommentQ(String kode){
        return jdbc.update("UPDATE comment a SET status = '0' WHERE a.id_question = ?",
                new Object[]{kode});
    }

    public int DelQuestion(String id) {
        return jdbc.update("UPDATE question a SET status = '0' WHERE a.id_question = ?",
                new Object[]{id});
    }
    
    public int DelSubcomment(String kode){
        return jdbc.update("UPDATE subcomment a SET status = '0' WHERE a.id_subcomment = ?",
                new Object[]{kode});
    }
    
    public int DelSubcommentQ(String kode){
        return jdbc.update("UPDATE subcomment a SET status = '0' WHERE a.id_question = ?",
                new Object[]{kode});
    }
    
    public int DelSubcommentC(String kode){
        return jdbc.update("UPDATE subcomment a SET status = '0' WHERE a.id_comment = ?",
                new Object[]{kode});
    }
    
    public mUserprofile login(JSONObject jsn){
        List<mUserprofile> data = jdbc.query("SELECT * FROM userprofile WHERE userid=? AND password=? AND role='2'",
                new Object[]{
                    jsn.get("user"),
                    jsn.get("pass")
                }, new dataUserprofileMapper());
        if (data.isEmpty()) {
            return null;
        }
        return data.get(0);
    }
    
    public mUserprofile loginAdmin(JSONObject jsn){
        List<mUserprofile> data = jdbc.query("SELECT * FROM userprofile WHERE userid=? AND password=? AND acces=1 AND role='1'",
                new Object[]{
                    jsn.get("user"),
                    jsn.get("pass")
                }, new dataUserprofileMapper());
        if (data.isEmpty()) {
            return null;
        }
        return data.get(0);
    }
    

    private static final class dataQuestionMapper implements RowMapper<mQuestion> {
        @Override
        public mQuestion mapRow(ResultSet rs, int i) throws SQLException {
            mQuestion data = new mQuestion();
            data.setId_question(rs.getInt("id_question"));
            data.setUserid(rs.getString("userid"));
            data.setTgl(rs.getString("tgl"));
            data.setJam(rs.getString("jam"));
            data.setJudul(rs.getString("judul"));
            data.setKonten(rs.getString("konten"));
            data.setImg(rs.getString("img"));
            data.setStatus(rs.getInt("status"));
            data.setJml(rs.getInt("jml"));
            data.setNamaC(rs.getString("nm"));
            data.setNamaQ(rs.getString("nama"));
            data.setImage(rs.getString("image"));
            return data;
        }
    }
    
    private static final class dataCommentMapper implements RowMapper<mComment> {
        @Override
        public mComment mapRow(ResultSet rs, int i) throws SQLException {
            mComment data = new mComment();
            data.setId_comment(rs.getInt("id_comment"));
            data.setId_question(rs.getInt("id_question"));
            data.setImg(rs.getString("img"));
            data.setJam(rs.getString("jam"));
            data.setKonten(rs.getString("konten"));
            data.setStatus(rs.getInt("status"));
            data.setTgl(rs.getString("tgl"));
            data.setUserid(rs.getString("userid"));
            data.setNama(rs.getString("nama"));
            data.setImage(rs.getString("image"));
            return data;
        }
    }
    
    private static final class dataSubcommentMapper implements RowMapper<mSubcomment> {
        @Override
        public mSubcomment mapRow(ResultSet rs, int i) throws SQLException {
            mSubcomment data = new mSubcomment();
            data.setId_subcomment(rs.getInt("id_subcomment"));
            data.setId_comment(rs.getInt("id_comment"));
            data.setId_question(rs.getInt("id_question"));
            data.setJam(rs.getString("jam"));
            data.setKonten(rs.getString("konten"));
            data.setStatus(rs.getInt("status"));
            data.setTgl(rs.getString("tgl"));
            data.setUserid(rs.getString("userid"));
            data.setNama(rs.getString("nama"));
            data.setImage(rs.getString("image"));
            return data;
        }
    }

    private static final class dataUserprofileMapper implements RowMapper<mUserprofile> {
        @Override
        public mUserprofile mapRow(ResultSet rs, int i) throws SQLException {
            mUserprofile data = new mUserprofile();
            data.setUserid(rs.getString("userid"));
            data.setPassword(rs.getString("password"));
            data.setNama(rs.getString("nama"));
            data.setDob(rs.getString("dob"));
            data.setAddress(rs.getString("address"));
            data.setImage(rs.getString("image"));
            data.setAcces(rs.getInt("acces"));
            data.setRole(rs.getInt("role"));
            return data;
        }
    }

    private static final class dataStatistikMapper implements RowMapper<mStatistik> {
        @Override
        public mStatistik mapRow(ResultSet rs, int i) throws SQLException {
            mStatistik data = new mStatistik();
            data.setMember(rs.getInt("member"));
            data.setReplies(rs.getInt("replies"));
            data.setThread(rs.getInt("threads"));
            return data;
        }
    }
}
