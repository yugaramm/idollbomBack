package com.example.idollbom.service.boardservice;

import com.example.idollbom.domain.dto.boarddto.CommunityDTO;
import com.example.idollbom.domain.dto.boarddto.CommunityListDTO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public interface CommunityService {

//    게시글 목록
    List<CommunityListDTO> getCommunityList(int page, int pageSize);
//    게시판 총 갯수
    int getCommunityListCount();

    // 여러 개의 첨부부파일을 올리기 위한 메소드
    void saveFile(int parentNumber, List<MultipartFile> files);
//    게시글 작성
    void saveCommunity(CommunityDTO community, List<MultipartFile> files);






}