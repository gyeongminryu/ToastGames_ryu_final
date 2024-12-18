package com.toast.dataconfig;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Hex;
import org.springframework.stereotype.Component;

import com.toast.dataconstant.FinalKEY;



@Component
public class DataConfig {
	
	private static String aeskey_256 = FinalKEY.AESKEY;
	
	public static String aesCBCEncode(String plainText) throws Exception{
		
		SecretKeySpec secretKey = new SecretKeySpec(aeskey_256.getBytes("UTF-8"),"AES");
		IvParameterSpec IV = new IvParameterSpec(aeskey_256.substring(0, 16).getBytes());
		
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		
		c.init(Cipher.ENCRYPT_MODE, secretKey,IV);
		
		byte[] encrpytionByte = c.doFinal(plainText.getBytes("UTF-8"));

		
		return Hex.encodeHexString(encrpytionByte);
	}
	
	
	public static String aesCBCDecode(String encodeText) throws Exception{
		
		SecretKeySpec secretKey = new SecretKeySpec(aeskey_256.getBytes("UTF-8"),"AES");
		IvParameterSpec IV = new IvParameterSpec(aeskey_256.substring(0, 16).getBytes());
		
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		
		c.init(Cipher.DECRYPT_MODE, secretKey,IV);
		
		byte[] decodenByte = Hex.decodeHex(encodeText.toCharArray());

		return new String(c.doFinal(decodenByte),"UTF-8");
	}
	
}
