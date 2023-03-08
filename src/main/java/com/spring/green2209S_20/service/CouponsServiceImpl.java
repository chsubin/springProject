package com.spring.green2209S_20.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.green2209S_20.dao.CouponsDAO;
import com.spring.green2209S_20.vo.CouponsVO;	

@Service
public class CouponsServiceImpl implements CouponsService {

	@Autowired
	CouponsDAO couponsDAO;


	@Override
	public String getLastIdx() {
		return couponsDAO.getLastIdx();
	}


	@Override
	public String qrCreate(int intIdx, CouponsVO vo, String realPath) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String qrCodeName = sdf.format(new Date()) + "_"+intIdx;	// 저장될 파일명
		
		try {
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			
			UUID uid = UUID.randomUUID();
			String strUid = uid.toString().substring(0,8)+intIdx;
			strUid = new String(strUid.getBytes("UTF-8"), "ISO-8859-1");	// qr코드 생성시에 moveFlag의 내용으로 qr코드가 만들어진다.
			
			// qr코드 만들기
			int qrCodeColor = 0xFF000000;			// qr코드 전경색(글자색)
			int qrCodeBackColor = 0xFFFFFFFF;	// qr코드 배경색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();	// QR코드 객체 생성
			BitMatrix bitMatrix = qrCodeWriter.encode(strUid, BarcodeFormat.QR_CODE, 200, 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
			
			vo.setCode(strUid);
			vo.setFSName(qrCodeName);
			
			//데이터베이스에 저장하기
			couponsDAO.setCouponInput(vo);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return qrCodeName;
	}


	@Override
	public List<CouponsVO> getCouponList(int startIndexNo, int pageSize) {
		return couponsDAO.getCouponList(startIndexNo,pageSize);
	}


	@Override
	public void setCouponUpdate(int couponIdx) {
		couponsDAO.setCouponUpdate(couponIdx);
	}


	@Override
	public void setCouponDelete(int idx) {
		couponsDAO.setCouponDelete(idx);
	}


	@Override
	public CouponsVO getCoupon(String code) {
		return couponsDAO.getCoupon(code);
	}
}
