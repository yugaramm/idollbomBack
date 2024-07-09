package com.example.idollbom.mapper.myPagemapper.parentmapper;

import com.example.idollbom.domain.vo.classSaveVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface classSaveMapper {
    List<classSaveVO> selectAll(Long parentId);
}
