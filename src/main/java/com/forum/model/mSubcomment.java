/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.forum.model;

/**
 *
 * @author user
 */
public class mSubcomment {
    private int id_subcomment;
    private int id_comment;
    private int id_question;
    private String userid;
    private String tgl;
    private String jam;
    private String konten;
    private int status;
    
    private String nama;
    private String image;

    public mSubcomment(){
        
    }
    
    public mSubcomment(int id_subcomment, int id_comment, int id_question, String userid, String tgl, String jam, String konten, int status) {
        this.id_subcomment = id_subcomment;
        this.id_comment = id_comment;
        this.id_question = id_question;
        this.userid = userid;
        this.tgl = tgl;
        this.jam = jam;
        this.konten = konten;
        this.status = status;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getId_subcomment() {
        return id_subcomment;
    }

    public void setId_subcomment(int id_subcomment) {
        this.id_subcomment = id_subcomment;
    }

    public int getId_comment() {
        return id_comment;
    }

    public void setId_comment(int id_comment) {
        this.id_comment = id_comment;
    }

    public int getId_question() {
        return id_question;
    }

    public void setId_question(int id_question) {
        this.id_question = id_question;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getTgl() {
        return tgl;
    }

    public void setTgl(String tgl) {
        this.tgl = tgl;
    }

    public String getJam() {
        return jam;
    }

    public void setJam(String jam) {
        this.jam = jam;
    }

    public String getKonten() {
        return konten;
    }

    public void setKonten(String konten) {
        this.konten = konten;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    
}
