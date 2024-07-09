package com.example.idollbom.service.myPageservice.parentservice;

import com.example.idollbom.domain.vo.classSaveVO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface classSaveService {
    List<classSaveVO> selectClassList();

    int saveClass(Long classNumber, Long parentNumber);
}
