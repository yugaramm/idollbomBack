package com.example.idollbom.service.myPageservice.parentservice;

import com.example.idollbom.domain.vo.ParentVO;
import com.example.idollbom.domain.vo.classSaveVO;
import com.example.idollbom.mapper.loginmapper.ParentMapper;
import com.example.idollbom.mapper.myPagemapper.parentmapper.classSaveMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@RequiredArgsConstructor
@Slf4j
public class classSaveServiceImpl implements classSaveService {

    private final classSaveMapper classSaveMapper;
    private final ParentMapper parentMapper;
    @Override
    public List<classSaveVO> selectClassList() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        String currentUserName = userDetails.getUsername();

//      parent VO 찾아서 아이디 찾기
        ParentVO parent = parentMapper.selectOne(currentUserName);
        return classSaveMapper.selectAll(parent.getParentNumber());
    }

    // 수업 찜 목록 추가
    @Override
    public int saveClass(Long classNumber, Long parentNumber) {
        return classSaveMapper.insertClass(classNumber, parentNumber);
    }
}
