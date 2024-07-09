package com.example.idollbom.service.applyservice;

import com.example.idollbom.domain.dto.applydto.ClassListDTO;
import jdk.jfr.Category;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ClassListService {
    // 소카에 대한 전체 클래스 목록 select
    List<ClassListDTO> findAllClass(String category);

    // 소카에 대한 갯수 가져오기
    int classCount(String category);

    // 검색 구현 select
    List<ClassListDTO> searchClassList(String searchWord, String searchType, String category);
}
