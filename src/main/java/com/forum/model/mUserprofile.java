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
public class mUserprofile {
    private String userid;
    private String password;
    private String nama;
    private String dob;
    private String address;
    private String image;
    private int acces;
    private int role;
    
    public mUserprofile(){
        
    }

    public mUserprofile(String userid, String password, String nama, String dob, String address, String image, int acces, int role) {
        this.userid = userid;
        this.password = password;
        this.nama = nama;
        this.dob = dob;
        this.address = address;
        this.image = image;
        this.acces = acces;
        this.role = role;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getAcces() {
        return acces;
    }

    public void setAcces(int acces) {
        this.acces = acces;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
    
    
}
