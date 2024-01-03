#include <spdlog/spdlog.h>
#include <GLFW/glfw3.h>

int main(int argc, const char** argv) {
    SPDLOG_INFO("Start Program"); // log level. 출력의 단계를 결정할 수 있다?
    
    // GLFW Library Initialize. if failed, program exit after error log print.
    SPDLOG_INFO("Initialize Info.");
    if(!glfwInit()) {
        const char* description = nullptr;
        glfwGetError(&description);
        SPDLOG_ERROR("Failed to initialize glfw: {}", description); // {}가 $s\n라고 생각하자. type 지정 없어도 알아서 들어감
        return -1;
    }

    // Create glfw window
    SPDLOG_INFO("Create glfw window");
    auto window = glfwCreateWindow(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_NAME, nullptr, nullptr);
    if (!window) {
        SPDLOG_ERROR("failed to create glfw window.");
        glfwTerminate();
        return -1;
    }

    // execute GLFW loop. if press close btn on window, program exit.
    SPDLOG_INFO("Start main loop");
    while (!glfwWindowShouldClose(window)) {
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}