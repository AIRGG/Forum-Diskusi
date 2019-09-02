/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.forum;

import com.forum.json.*;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author root
 */

//jangan static
public class Lib {

    public Lib() {

    }

    public List<Integer> range(int stop) {
        List<Integer> toreturn = new ArrayList<Integer>();
        for (int i = 0; i < stop; i++) {
            toreturn.add(i);
        }
        return toreturn;
    }

    public List<Integer> range(int start, int stop) {
        List<Integer> toreturn = new ArrayList<Integer>();
        for (; start < stop; start++) {
            toreturn.add(start);
        }
        return toreturn;
    }

    public List<Integer> range(int start, int stop, int step) {
        List<Integer> toreturn = new ArrayList<Integer>();
        for (; start < stop; start += step) {
            toreturn.add(start);
        }
        return toreturn;
    }

    public List<String> jsonArrayToList(JSONArray jsonarray) {
        List<String> toreturn = new ArrayList<String>();
        for (Object x : jsonarray) {
            toreturn.add((String) x);
        }
        return toreturn;
    }

    public <Type0, Type1> Map<Type0, Type1> mergeArray(Type0[] arr0, Type1[] arr1) {
        Map<Type0, Type1> toreturn = new HashMap<>();
        for (int i = 0; i < arr0.length; i++) {
            toreturn.put(arr0[i], arr1[i]);
        }
        return toreturn;
    }

    public boolean cmpStr(String str0, String str1) {
        if (str0.length() != str1.length()) {
            return false;
        }
        for (int i = 0; i < str0.length(); i++) {
            if (str0.charAt(i) != str1.charAt(i)) {
                return false;
            }
        }
        return true;
    }

    public <T> JSONObject listMapToJSON(List<Map<String, T>> x) {
        JSONObject json = new JSONObject();
        List<JSONObject> a = new ArrayList<JSONObject>();
        for (Map<String, T> y : x) {
            JSONObject c = new JSONObject();

            for (String b : y.keySet()) {
                c = c.put(b, y.get(b));
            }
            a.add(c);
        }
        json = json.put("data", a);
        return json;
    }

    public <T> List<T> arrayToList(T[] x) {
        List<T> toReturn = new ArrayList<>();
        for (T i : x) {
            toReturn.add(i);
        }
        return toReturn;
    }

    public String decodeHttp(String str) {
        try {
            return java.net.URLDecoder.decode(str, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            return "error decode http";
        }
    }

    public Map<String, String> parseHttp(String data) {
        return this.parseHttp(data, true);
    }

    public Map<String, String> parseHttp(String data, boolean httpDecode) {
        Map<String, String> x = new HashMap<String, String>();
        String[] split_and = data.split("&");
        String[] split_eq;
        for (String i : split_and) {
            if (!i.matches("(.*)\\=(.*)")) {
                continue;
            }
            split_eq = i.split("=");
            for (int a = 0; a < split_eq.length; a++) {
                if (httpDecode) {
                    try {
                        split_eq[a] = java.net.URLDecoder.decode(split_eq[a], "UTF-8");
                    } catch (UnsupportedEncodingException e) {

                    }
                }
                x.put(split_eq[0], split_eq[1]);
            }
        }
        return x;
    }

    public List<Map<String, Object>> listMapToJSON(String toString) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    public void writeFile(String filename, byte[] raw_data, String path) throws IOException {
        Path currentPath = Paths.get(System.getProperty("user.dir"));
        Path filePath = Paths.get(currentPath.toString(), path, filename);
        try (DataOutputStream dataOut = new DataOutputStream(new FileOutputStream(filePath.toString()))) {
            dataOut.write(raw_data);
        } catch (Exception e) {
            System.out.println(String.format("AA %s", e.toString()));
        }
    }

}
