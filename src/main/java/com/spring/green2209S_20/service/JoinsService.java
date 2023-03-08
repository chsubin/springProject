package com.spring.green2209S_20.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_20.vo.JoinProductVO;
import com.spring.green2209S_20.vo.JoinsRequestVO;
import com.spring.green2209S_20.vo.JoinsVO;

public interface JoinsService {

	public void setJoinsInput( JoinsVO vo);

	public List<JoinsVO> getJoinsList(int startIndexNo, int pageSize, int joinSw, String part, String search );

	public JoinsVO getJoin(int idx);

	public int setJoinsUpdate(JoinsVO vo, MultipartFile photo);

	public void setJoinProduct(JoinProductVO vo);

	public List<JoinProductVO> getjoinsProductList(int idx);

	public List<JoinProductVO> getJoinsProductsList();

	public void setJoinsMemoUpdate(int idx, String content);

	public void setJoinsRequest(JoinsRequestVO vo);

	public List<JoinsRequestVO> getRequestList(int startIndexNo, int pageSize, String startDate, String lastDate, String part, String search);

	public void setJoinProductUpdate(JoinProductVO vo);

	public void setJoinProductDelete(int idx);

	public void setJoinSwUpdate(int idx, int joinSw);


}
