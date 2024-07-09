package com.example.idollbom.service.applyservice;

import com.example.idollbom.domain.dto.applydto.ClassDetailDTO;
import com.example.idollbom.mapper.applymapper.ClassDetailMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ClassDetailServiceImpl implements ClassDetailService {

    private final ClassDetailMapper classDetailMapper;

    // 수업 상세보기 서비스 구현
    @Override
    public ClassDetailDTO classDetail(Long proNumber, Long classNumber) {
        return classDetailMapper.selectClassByProNumber(proNumber, classNumber);
    }
}
