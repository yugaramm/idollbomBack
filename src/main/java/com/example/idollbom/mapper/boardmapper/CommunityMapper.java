package com.example.idollbom.mapper.boardmapper;

import com.example.idollbom.domain.dto.boarddto.CommunityDTO;
import com.example.idollbom.domain.dto.boarddto.CommunityListDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Mapper
public interface CommunityMapper {

    //게시글 목록
    List<CommunityListDTO> selectAll(int startRow, int endRow);

    // 페이징 처리 시 사용
    int countCommunity();

//    게시글 작성때 사용할 쿼리
    int getSeq();
//    게시글 작성
    void saveCommunity(CommunityDTO community);
}


