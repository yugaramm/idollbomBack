package com.example.idollbom.mapper.applymapper;

import com.example.idollbom.domain.dto.applydto.ClassDetailDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ClassDetailMapper {
    // 수업 상세보기 조회
    ClassDetailDTO selectClassByProNumber(Long proNumber, Long classNummber);
}
