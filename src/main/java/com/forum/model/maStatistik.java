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
public class maStatistik {
    private int user;
    private int question;
    private int comment;
    private int subcomment;
    
    public maStatistik(){
        
    }

    public maStatistik(int user, int question, int comment, int subcomment) {
        this.user = user;
        this.question = question;
        this.comment = comment;
        this.subcomment = subcomment;
    }

    public int getUser() {
        return user;
    }

    public void setUser(int user) {
        this.user = user;
    }

    public int getQuestion() {
        return question;
    }

    public void setQuestion(int question) {
        this.question = question;
    }

    public int getComment() {
        return comment;
    }

    public void setComment(int comment) {
        this.comment = comment;
    }

    public int getSubcomment() {
        return subcomment;
    }

    public void setSubcomment(int subcomment) {
        this.subcomment = subcomment;
    }

    
    
}
