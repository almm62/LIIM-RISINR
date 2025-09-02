package com.UAM.RISINR.security;

import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.security.InvalidKeyException;

import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.SignatureException;
import java.util.Base64;
import java.util.Date;

public class JWT2RSA {

    public void testJWTWithRsa() throws NoSuchAlgorithmException {
        KeyPairGenerator keyGenerator = KeyPairGenerator.getInstance("RSA");
        keyGenerator.initialize(2048);

        KeyPair kp = keyGenerator.genKeyPair();
        PublicKey publicKey = (PublicKey) kp.getPublic();
        PrivateKey privateKey = (PrivateKey) kp.getPrivate();

        String encodedPublicKey = Base64.getEncoder().encodeToString(publicKey.getEncoded());
        System.out.println("Public Key:");
        System.out.println(convertToPublicKey(encodedPublicKey));
        String token = generateJwtToken(privateKey);
        System.out.println("TOKEN:");
        System.out.println(token);
        printStructure(token, publicKey);
    }

    @SuppressWarnings("deprecation")
    public String generateJwtToken(PrivateKey privateKey) {
        String token = Jwts.builder().setSubject("EL BERDUGO")
                .setExpiration(new Date(2023, 6, 1))
                .setIssuer("DVG@CORREO.com")
                .claim("groups", new String[]{"user", "admin"})
                .claim("APPS", new String[]{"RIS", "PACS"})
                .signWith(SignatureAlgorithm.RS256, privateKey).compact();
        return token;
    }
    

    public void printStructure(String token, PublicKey publicKey) {
        Jws parseClaimsJws = Jwts.parser().setSigningKey(publicKey).parseClaimsJws(token);
        System.out.println("Header     : " + parseClaimsJws.getHeader());
        System.out.println("Body       : " + parseClaimsJws.getBody());
        System.out.println("Signature  : " + parseClaimsJws.getSignature());
        

    }
      
   public boolean verify(PublicKey publicKey, String header, String payload, String signature) {
        try {
            String data = header + "." + payload;
            System.out.println("Probando validación");
            System.out.println(data);
            Signature sig = Signature.getInstance("SHA256withRSA");
            sig.initVerify(publicKey);
            sig.update(data.getBytes());
            byte[] decodedSignature = Base64.getUrlDecoder().decode(signature);
            return sig.verify(decodedSignature);
        } catch (InvalidKeyException | NoSuchAlgorithmException | SignatureException e) {
            e.printStackTrace(System.out);
            throw new RuntimeException(e);
        }
   }    

    private String convertToPublicKey(String key) {
        StringBuilder result = new StringBuilder();
        result.append("-----BEGIN PUBLIC KEY-----\n");
        result.append(key);
        result.append("\n-----END PUBLIC KEY-----");
        return result.toString();
    }

    public static void main(String[] args) throws Exception {
        JWT2RSA jwtrsa = new JWT2RSA();
        jwtrsa.testJWTWithRsa();
    }
}
