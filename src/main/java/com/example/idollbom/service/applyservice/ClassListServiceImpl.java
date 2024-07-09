package com.example.idollbom.service.applyservice;

import com.example.idollbom.domain.dto.applydto.ClassListDTO;
import com.example.idollbom.mapper.applymapper.ClassListMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ClassListServiceImpl implements ClassListService {
    private final ClassListMapper classListMapper;

    @Override
    public List<ClassListDTO> findAllClass(String category) {
        return classListMapper.findAllClass(category);
    }

    @Override
    public int classCount(String category) {
        return classListMapper.classCount(category);
    }

    @Override
    public List<ClassListDTO> searchClassList(String searchWord, String searchType, String category) {
        return classListMapper.searchClassList(searchWord, searchType, category);
    }
}
