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
public class mStatistik {
    private int member;
    private int thread;
    private int replies;
    
    public mStatistik(){
        
    }

    public mStatistik(int member, int thread, int replies) {
        this.member = member;
        this.thread = thread;
        this.replies = replies;
    }

    public int getMember() {
        return member;
    }

    public void setMember(int member) {
        this.member = member;
    }

    public int getThread() {
        return thread;
    }

    public void setThread(int thread) {
        this.thread = thread;
    }

    public int getReplies() {
        return replies;
    }

    public void setReplies(int replies) {
        this.replies = replies;
    }
    
    
}
