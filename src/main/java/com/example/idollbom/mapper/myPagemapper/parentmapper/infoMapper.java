package com.example.idollbom.mapper.myPagemapper.parentmapper;
import com.example.idollbom.domain.vo.ParentVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface infoMapper {
    ParentVO selectMyInfo(Long parentNumber);
}
