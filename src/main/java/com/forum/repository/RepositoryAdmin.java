/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.forum.repository;

import com.forum.model.mComment;
import com.forum.model.mQuestion;
import com.forum.model.mSubcomment;
import com.forum.model.mUserprofile;
import com.forum.model.maStatistik;
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
public class RepositoryAdmin {
    
    @Autowired
    JdbcTemplate jdbc;
    
    public List<mQuestion> showQuestion() {
        List<mQuestion> data = jdbc.query("SELECT *, ((SELECT count(b.konten) FROM comment b WHERE b.id_question=a.id_question)+(SELECT count(d.konten) FROM subcomment d WHERE d.id_question=a.id_question)) AS jml, (SELECT u.nama FROM comment c INNER JOIN userprofile u ON c.userid=u.userid WHERE c.id_question=a.id_question ORDER BY c.id_comment DESC LIMIT 1) AS nm FROM question a INNER JOIN userprofile e ON a.userid=e.userid ORDER By id_question DESC",
                new Object[]{}, new dataQuestionMapper());
        return data;
    }
    
    public List<mComment> showComment(){
        List<mComment> data = jdbc.query("SELECT *, (SELECT b.nama FROM userprofile b WHERE b.userid=a.userid) AS nama, (SELECT b.image FROM userprofile b WHERE b.userid=a.userid) AS image FROM comment a ORDER BY a.id_comment DESC",
                new Object[]{}, new dataCommentMapper());
        return data;
    }
    
    public List<mSubcomment> showSubcomment(){
        List<mSubcomment> data = jdbc.query("SELECT *, (SELECT b.nama FROM userprofile b WHERE b.userid=a.userid) AS nama, (SELECT b.image FROM userprofile b WHERE b.userid=a.userid) AS image FROM subcomment a ORDER BY a.id_subcomment DESC",
                new Object[]{}, new dataSubcommentMapper());
        return data;
    }
    
    public List<mUserprofile> showUseridProfil() {
        List<mUserprofile> data = jdbc.query("SELECT * FROM userprofile where role <> '1'",
                new Object[]{}, new dataUserprofileMapper());
        return data;
    }
    
    public maStatistik showStatistik() {
        List<maStatistik> data = jdbc.query("SELECT count(a.konten) AS question, (SELECT count(b.konten) FROM comment b) AS comment, (SELECT count(c.konten) FROM subcomment c) AS subcomment, (SELECT count(d.userid) FROM userprofile d) AS userid FROM question a",
                new Object[]{}, new dataStatistikMapper());
        if (data.isEmpty()) {
            return null;
        }
        return data.get(0);
    }
    
    public int ubahUseridY(String id){
        int uid = jdbc.update("UPDATE userprofile SET acces = '1' WHERE userid = ?",
                new Object[]{id});
        int qid = jdbc.update("UPDATE question SET status = '1' WHERE userid = ? AND status = 5",
                new Object[]{id});
        int cid = jdbc.update("UPDATE comment SET status = '1' WHERE userid = ? AND status = 5",
                new Object[]{id});
        int scid = jdbc.update("UPDATE subcomment SET status = '1' WHERE userid = ? AND status = 5",
                new Object[]{id});
        return scid;
    }
    
    public int ubahUseridN(String id){
        int uid = jdbc.update("UPDATE userprofile SET acces = '2' WHERE userid = ?",
                new Object[]{id});
        int qid = jdbc.update("UPDATE question SET status = '5' WHERE userid = ? AND status <> 2",
                new Object[]{id});
        int cid = jdbc.update("UPDATE comment SET status = '5' WHERE userid = ? AND status <> 2",
                new Object[]{id});
        int scid = jdbc.update("UPDATE subcomment SET status = '5' WHERE userid = ? AND status <> 2",
                new Object[]{id});
        return scid;
    }
    
    public int ubahQuestionY(String id){
        int uq = jdbc.update("UPDATE question SET status = '1' WHERE id_question = ?",
                new Object[]{id});
        int uqc = jdbc.update("UPDATE comment SET status = '1' WHERE id_question = ? AND status = 4",
                new Object[]{id});
        int uqs = jdbc.update("UPDATE subcomment SET status = '1' WHERE id_question = ?  AND status = 4",
                new Object[]{id});
        return uqs;
    }
    
    public int ubahQuestionN(String id){
        int uq = jdbc.update("UPDATE question SET status = '2' WHERE id_question = ?",
                new Object[]{id});
        int uqc = jdbc.update("UPDATE comment SET status = '4' WHERE id_question = ? AND status <> 2",
                new Object[]{id});
        int uqs = jdbc.update("UPDATE subcomment SET status = '4' WHERE id_question = ? AND status <> 2",
                new Object[]{id});
        return uqs;
    }
    
//    Comment
    public int ubahCommentY(String id){
        int uc = jdbc.update("UPDATE comment SET status = '1' WHERE id_comment = ?",
                new Object[]{id});
        int ucs = jdbc.update("UPDATE subcomment SET status = '1' WHERE id_comment = ? AND status = 3",
                new Object[]{id});
        return ucs;
    }
    
    public int ubahCommentN(String id){
        int uc = jdbc.update("UPDATE comment SET status = '2' WHERE id_comment = ?",
                new Object[]{id});
        int ucs = jdbc.update("UPDATE subcomment SET status = '3' WHERE id_comment = ? AND status <> 2",
                new Object[]{id});
        return ucs;
    }
    
//    Sub Comment
    public int ubahSubcommentY(String id){
        return jdbc.update("UPDATE subcomment SET status = '1' WHERE id_subcomment = ?",
                new Object[]{id});
    }
    public int ubahSubcommentN(String id){
        return jdbc.update("UPDATE subcomment SET status = '2' WHERE id_subcomment = ?",
                new Object[]{id});
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
    
    private static final class dataStatistikMapper implements RowMapper<maStatistik> {
        @Override
        public maStatistik mapRow(ResultSet rs, int i) throws SQLException {
            maStatistik data = new maStatistik();
            data.setUser(rs.getInt("userid"));
            data.setQuestion(rs.getInt("question"));
            data.setComment(rs.getInt("comment"));
            data.setSubcomment(rs.getInt("subcomment"));
            return data;
        }
    }
}
