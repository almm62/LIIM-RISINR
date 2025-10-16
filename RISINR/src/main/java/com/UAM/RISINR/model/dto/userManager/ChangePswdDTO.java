package com.UAM.RISINR.model.dto.userManager;

public class ChangePswdDTO {
    private String pswd1;
    private String pswd2;
    private String pswdActual;
    
    public ChangePswdDTO(){
    }
    
    public ChangePswdDTO(String pswd1, String pswd2, String pswdActual){
        this.pswd1=pswd1;
        this.pswd2=pswd2;
        this.pswdActual = pswdActual;
    } 
    
    public String getPswd1(){
        return pswd1;
    }
    
    public void setPswd1(String pswd1){
        this.pswd1 = pswd1;
    }
    
    public String getPswd2(){
        return pswd2;
    }
    public void setPswd2(String pswd2){
        this.pswd2=pswd2;
    }
    
    public String getPswdActual(){
        return pswdActual;
    }
    public void setPswdActual(String pswdActual){
        this.pswdActual=pswdActual;
    }
}
