package com.spring.green2209S_20.service;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_20.common.JavawspringProvide;
import com.spring.green2209S_20.dao.JoinsDAO;
import com.spring.green2209S_20.vo.JoinProductVO;
import com.spring.green2209S_20.vo.JoinsRequestVO;
import com.spring.green2209S_20.vo.JoinsVO;

@Service
public class JoinsServiceImpl implements JoinsService {

	@Autowired
	JoinsDAO joinsDAO;

	@Override
	public void setJoinsInput(JoinsVO vo) {
		joinsDAO.setJoinsInput(vo);
	}

	@Override
	public List<JoinsVO> getJoinsList(int startIndexNo, int pageSize, int joinSw,String part , String search) {
		return joinsDAO.getJoinsList(startIndexNo, pageSize, joinSw,part,search);
	}

	@Override
	public JoinsVO getJoin(int idx) {
		return joinsDAO.getJoin(idx);
	}

	@Override
	public int setJoinsUpdate(JoinsVO vo,MultipartFile photo) {
		//업로드된 사진을 서버 파일시스템에 저장시켜준다.
		int res=0;
		JoinsVO origVo = joinsDAO.getJoin(vo.getIdx());
		try {
			String oFileName = photo.getOriginalFilename();
			if(oFileName.equals("")) {
				vo.setFSName(oFileName); //원래 사진 저장
			}
			
			else {
				JavawspringProvide ps = new JavawspringProvide();
				ps.deleteFile(origVo.getFSName(),"data/ckeditor/adJoins"); //원래있던파일 삭제
				
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" +oFileName;
				ps.writeFile(photo,saveFileName,"data/ckeditor/adjoins"); //새로운 파일 저장
				vo.setFSName(saveFileName);
			}
			joinsDAO.setJoinsUpdate(vo); //데이터베이스 업데이트
			res=1;
			
		} catch (IOException e) {
			e.getStackTrace();
		}
		return res;
		
		
	}

	@Override
	public void setJoinProduct(JoinProductVO vo) {
		joinsDAO.setJoinProduct(vo);
	}

	@Override
	public List<JoinProductVO> getjoinsProductList(int idx) {
		return joinsDAO.getjoinsProductList(idx);
	}

	@Override
	public List<JoinProductVO> getJoinsProductsList() {
		return joinsDAO.getJoinsProductsList();
	}

	@Override
	public void setJoinsMemoUpdate(int idx, String content) {
		joinsDAO.setJoinsMemoUpdate(idx,content);
	}

	@Override
	public void setJoinsRequest(JoinsRequestVO vo) {
		joinsDAO.setJoinsRequest(vo);
	}

	@Override
	public List<JoinsRequestVO> getRequestList(int startIndexNo, int pageSize, String startDate, String lastDate, String part, String search) {
		return joinsDAO.getRequestList(startIndexNo, pageSize, startDate, lastDate,part, search);
	}

	@Override
	public void setJoinProductUpdate(JoinProductVO vo) {
		joinsDAO.setJoinProductUpdate(vo);
	}

	@Override
	public void setJoinProductDelete(int idx) {
		joinsDAO.setJoinProductDelete(idx);
	}

	@Override
	public void setJoinSwUpdate(int idx, int joinSw) {
		joinsDAO.setJoinSwUpdate(idx, joinSw);
	}
	
}
