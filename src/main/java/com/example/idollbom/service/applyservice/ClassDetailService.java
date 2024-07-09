package com.example.idollbom.service.applyservice;

import com.example.idollbom.domain.dto.applydto.ClassDetailDTO;
import org.springframework.stereotype.Service;

@Service
public interface ClassDetailService {
    // 수업 상세보기 서비스
    ClassDetailDTO classDetail(Long proNumber, Long classNumber);
}
