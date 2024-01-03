# ExternalProject 관련 명령어 셋 추가
include(ExternalProject)

# Dependency 관련 변수 설정
set(DEP_INSTALL_DIR ${PROJECT_BINARY_DIR}/install)
set(DEP_INCLUDE_DIR ${DEP_INSTALL_DIR}/include)
set(DEP_LIB_DIR ${DEP_INSTALL_DIR}/lib)

# spdlog : fast logger lib
ExternalProject_Add(
    dep-spdlog # Project 컴파일 시, 대표할 이름. build > dep-spdlog-prefix가 생성됨
    GIT_REPOSITORY "https://github.com/gabime/spdlog.git" # 사용할 Library의 git addr.
    GIT_TAG "v1.x" # branch name OR tag name
    GIT_SHALLOW 1 # boolean 값 0 / 1이라고 생각하면 된다. SHALLOW(n개의 코드 변경 내역 무시하고 최신의 log만 다운로드)를 사용하겠다는 뜻
    UPDATE_COMMAND "" # = git pull
    PATCH_COMMAND ""
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${DEP_INSTALL_DIR} # cmake configure시 인자를 어떻게 줄 것인가. -D 뒤가 변수 이름 =${변수 값} 이다. 현재는 DEP_INSTALL_DIR에 저장된 값을 꺼내쓰겠단 것.
    TEST_COMMAND ""
)

# Dependency 리스트 및 라이브러리 파일 리스트 추가
set(DEP_LIST ${DEP_LIST} dep-spdlog)
set(DEP_LIBS ${DEP_LIBS} spdlog$<$<CONFIG:Debug>:d>)

# glfw
ExternalProject_Add(
    dep_glfw
    GIT_REPOSITORY "https://github.com/glfw/glfw.git"
    GIT_TAG "3.3.3"
    GIT_SHALLOW 1
    UPDATE_COMMAND "" PATCH_COMMAND "" TEST_COMMAND ""
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${DEP_INSTALL_DIR}
        -DGLFW_BUILD_EXAMPLES=OFF
        -DGLFW_BUILD_TESTS=OFF
        -DGLFW_BUILD_DOCS=OFF
    )
set(DEP_LIST ${DEP_LIST} dep_glfw)
set(DEP_LIBS ${DEP_LIBS} glfw3)