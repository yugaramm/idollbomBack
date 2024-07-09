package com.example.idollbom.mapper.applymapper;

import com.example.idollbom.domain.dto.applydto.ClassListDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ClassListMapper {
    // 소카에 대한 전체 클래스 목록 select
    List<ClassListDTO> findAllClass(@Param("category") String category);

    // 소카에 대한 갯수 가져오기
    int classCount(@Param("category") String category);

    // 검색 기능 구현 select
    List<ClassListDTO> searchClassList(@Param("searchWord") String searchWord,
                                       @Param("searchType") String searchType,
                                       @Param("category") String category);
}
