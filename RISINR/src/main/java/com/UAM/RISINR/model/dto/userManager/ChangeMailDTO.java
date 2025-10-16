package com.UAM.RISINR.model.dto.userManager;

public class ChangeMailDTO {
    private String mail1;
    private String mail2;
    private String pswd;
    
    public ChangeMailDTO(){
    }
    
    public ChangeMailDTO(String mail1, String mail2, String pswd){
        this.mail1=mail1;
        this.mail2=mail2;
        this.pswd = pswd;
    } 
    
    public String getmail1(){
        return mail1;
    }
    
    public void setmail1(String mail1){
        this.mail1 = mail1;
    }
    
    public String getmail2(){
        return mail2;
    }
    public void setmail2(String mail2){
        this.mail2=mail2;
    }
    
    public String getpswd(){
        return pswd;
    }
    public void setpswd(String pswd){
        this.pswd=pswd;
    }
}